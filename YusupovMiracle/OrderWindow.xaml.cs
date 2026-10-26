using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace YusupovMiracle
{
    public partial class OrderWindow : Window
    {
        List<OrderItem> selectedOrderProducts = new List<OrderItem>();
        private Client currentUser;
        private Order currentOrder;
        private bool readOnly;
        private List<OrderItem> originalItems;
        public bool CanChangeOrder { get { return !readOnly; } }

        public OrderWindow(List<OrderItem> orderProducts, Client user, Order order = null, bool onlyView = false)
        {
            if (user == null) throw new InvalidOperationException("Для оформления заказа войдите в систему.");
            if (order != null && user.RoleID != 1 && user.RoleID != 3) throw new InvalidOperationException("Нет доступа к заказу.");
            currentUser = user;
            currentOrder = order;
            readOnly = onlyView || (order != null && user.RoleID != 1);
            InitializeComponent();
            originalItems = order == null ? new List<OrderItem>() : order.OrderItem.ToList();
            foreach (var item in order == null ? orderProducts : originalItems)
                selectedOrderProducts.Add(new OrderItem { CommodityPositionID = item.CommodityPositionID,
                    CommodityPosition = item.CommodityPosition, Quantity = item.Quantity, PriceAtOrderTime = item.PriceAtOrderTime });
            var context = YusupovMiracleShowEntities.GetContext();
            ClientCombo.ItemsSource = context.Client.OrderBy(p => p.LastName).ToList();
            ClientCombo.SelectedItem = order == null ? user : order.Client;
            ClientCombo.IsEnabled = !readOnly && (user.RoleID == 1 || user.RoleID == 3);
            OrderDP.SelectedDate = order == null ? DateTime.Today : order.OrderDate;
            OrderDP.IsEnabled = !readOnly && user.RoleID == 1;
            TBOrderID.Text = order == null ? "Новый (номер присвоит база данных)" : order.OrderID.ToString();
            HeaderTB.Text = readOnly ? "Состав заказа №" + order.OrderID : (order == null ? "Оформление заказа" : "Редактирование заказа №" + order.OrderID);
            Title = HeaderTB.Text;
            AddPanel.Visibility = readOnly ? Visibility.Collapsed : Visibility.Visible;
            SaveBtn.Visibility = readOnly ? Visibility.Collapsed : Visibility.Visible;
            PositionCombo.ItemsSource = context.CommodityPosition.Include(p => p.Product).ToList()
                .Where(p => AvailableQuantity(p) > 0).OrderBy(p => p.Product.ProductName).ThenBy(p => p.Size).ToList();
            RefreshOrder();
        }

        private int AvailableQuantity(CommodityPosition position)
        {
            return position.QuantityInStock + originalItems.Where(p => p.CommodityPositionID == position.CommodityPositionID).Sum(p => p.Quantity);
        }

        private void RefreshOrder()
        {
            ProductListView.ItemsSource = selectedOrderProducts;
            ProductListView.Items.Refresh();
            TotalTB.Text = "Итого: " + selectedOrderProducts.Sum(p => p.Quantity * p.PriceAtOrderTime).ToString("N2") + " ₽";
        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {
            if (readOnly) return;
            var position = PositionCombo.SelectedItem as CommodityPosition;
            if (position == null) { MessageBox.Show("Выберите модель и размер!"); return; }
            var selectedOP = selectedOrderProducts.FirstOrDefault(p => p.CommodityPositionID == position.CommodityPositionID);
            if ((selectedOP == null ? 0 : selectedOP.Quantity) >= AvailableQuantity(position))
            { MessageBox.Show("Недостаточно товара на складе."); return; }
            if (selectedOP == null)
            {
                var original = originalItems.FirstOrDefault(p => p.CommodityPositionID == position.CommodityPositionID);
                selectedOrderProducts.Add(new OrderItem { CommodityPositionID = position.CommodityPositionID, CommodityPosition = position,
                    Quantity = 1, PriceAtOrderTime = original == null ? position.Product.Price : original.PriceAtOrderTime });
            }
            else selectedOP.Quantity++;
            RefreshOrder();
        }

        private void BtnPlus_Click(object sender, RoutedEventArgs e)
        {
            if (readOnly) return;
            var item = (sender as Button).DataContext as OrderItem;
            if (item.Quantity >= AvailableQuantity(item.CommodityPosition)) { MessageBox.Show("Недостаточно товара на складе."); return; }
            item.Quantity++;
            RefreshOrder();
        }

        private void BtnMinus_Click(object sender, RoutedEventArgs e)
        {
            if (readOnly) return;
            var item = (sender as Button).DataContext as OrderItem;
            if (item.Quantity > 1) item.Quantity--;
            RefreshOrder();
        }

        private void RemoveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (readOnly) return;
            selectedOrderProducts.Remove((sender as Button).DataContext as OrderItem);
            RefreshOrder();
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (readOnly || (currentOrder != null && currentUser.RoleID != 1)) return;
            var client = ClientCombo.SelectedItem as Client;
            if (client == null) { MessageBox.Show("Выберите клиента!"); return; }
            if (!selectedOrderProducts.Any()) { MessageBox.Show("Добавьте товары в заказ!"); return; }
            if (OrderDP.SelectedDate == null) { MessageBox.Show("Укажите корректную дату заказа!"); return; }
            if (selectedOrderProducts.Any(p => p.Quantity < 1 || p.PriceAtOrderTime < 0)) { MessageBox.Show("Проверьте количество и стоимость позиций."); return; }
            // SQL generates identity keys; Count + 1 would reuse numbers after deletion.
            // Save the order and the change in stock as one transaction.
            using (var context = new YusupovMiracleShowEntities())
            using (var transaction = context.Database.BeginTransaction(IsolationLevel.Serializable))
            {
                try
                {
                    Order savedOrder;
                    var oldItems = new List<OrderItem>();
                    if (currentOrder == null)
                    {
                        savedOrder = new Order();
                        context.Order.Add(savedOrder);
                    }
                    else
                    {
                        savedOrder = context.Order.Include(p => p.OrderItem).FirstOrDefault(p => p.OrderID == currentOrder.OrderID);
                        if (savedOrder == null) throw new InvalidOperationException("Заказ уже удалён. Обновите список.");
                        oldItems = savedOrder.OrderItem.ToList();
                        if (savedOrder.ClientID != currentOrder.ClientID || savedOrder.OrderDate != currentOrder.OrderDate || oldItems.Count != originalItems.Count ||
                            oldItems.Any(p => !originalItems.Any(q => q.OrderItemID == p.OrderItemID && q.Quantity == p.Quantity && q.PriceAtOrderTime == p.PriceAtOrderTime && q.CommodityPositionID == p.CommodityPositionID)))
                            throw new InvalidOperationException("Заказ изменён другим пользователем. Откройте его заново.");
                    }
                    var positionIDs = oldItems.Select(p => p.CommodityPositionID).Union(selectedOrderProducts.Select(p => p.CommodityPositionID)).OrderBy(p => p).ToList();
                    foreach (int positionID in positionIDs)
                    {
                        int oldQuantity = oldItems.Where(p => p.CommodityPositionID == positionID).Sum(p => p.Quantity);
                        int newQuantity = selectedOrderProducts.Where(p => p.CommodityPositionID == positionID).Sum(p => p.Quantity);
                        int delta = newQuantity - oldQuantity;
                        int changed = context.Database.ExecuteSqlCommand(
                            "UPDATE CommodityPosition SET QuantityInStock = QuantityInStock - @p0 WHERE CommodityPositionID = @p1 AND QuantityInStock >= @p0", delta, positionID);
                        if (changed != 1) throw new InvalidOperationException("Недостаточно товара на складе. Обновите каталог и проверьте размеры.");
                    }
                    savedOrder.ClientID = currentUser.RoleID == 2 ? currentUser.ClientID : client.ClientID;
                    savedOrder.OrderDate = OrderDP.SelectedDate.Value.Date;
                    context.OrderItem.RemoveRange(oldItems);
                    foreach (var item in selectedOrderProducts)
                        savedOrder.OrderItem.Add(new OrderItem { CommodityPositionID = item.CommodityPositionID, Quantity = item.Quantity, PriceAtOrderTime = item.PriceAtOrderTime });
                    context.SaveChanges();
                    transaction.Commit();
                    TBOrderID.Text = savedOrder.OrderID.ToString();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    MessageBox.Show("Ошибка при сохранении заказа: " + ex.GetBaseException().Message);
                    return;
                }
            }
            var shared = YusupovMiracleShowEntities.GetContext();
            if (currentOrder != null)
            {
                foreach (var item in currentOrder.OrderItem.ToList()) shared.Entry(item).State = EntityState.Detached;
                shared.Entry(currentOrder).State = EntityState.Detached;
            }
            foreach (var position in shared.CommodityPosition.Local.ToList()) shared.Entry(position).Reload();
            MessageBox.Show("Заказ №" + TBOrderID.Text + " успешно сохранён!");
            DialogResult = true;
        }
    }
}
