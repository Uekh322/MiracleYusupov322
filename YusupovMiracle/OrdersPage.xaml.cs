using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace YusupovMiracle
{
    public partial class OrdersPage : Page
    {
        private Client currentUser;
        public OrdersPage(Client user)
        {
            if (user == null || (user.RoleID != 1 && user.RoleID != 3)) throw new InvalidOperationException("Нет доступа к списку заказов.");
            InitializeComponent();
            currentUser = user;
            EditBtn.Visibility = user.RoleID == 1 ? Visibility.Visible : Visibility.Collapsed;
        }

        private void Page_Loaded(object sender, RoutedEventArgs e) { UpdateOrders(); }
        private void UpdateOrders()
        {
            try
            {
                OrdersGrid.ItemsSource = YusupovMiracleShowEntities.GetContext().Order.Include(p => p.Client)
                    .Include(p => p.OrderItem.Select(q => q.CommodityPosition.Product)).OrderByDescending(p => p.OrderID).ToList();
            }
            catch (Exception ex) { MessageBox.Show("Не удалось загрузить заказы: " + ex.GetBaseException().Message); }
        }

        private Order SelectedOrder()
        {
            var order = OrdersGrid.SelectedItem as Order;
            if (order == null) MessageBox.Show("Выберите заказ!");
            return order;
        }

        private void OpenOrder(Order order, bool readOnly)
        {
            var window = new OrderWindow(new List<OrderItem>(), currentUser, order, readOnly);
            window.Owner = Window.GetWindow(this);
            window.ShowDialog();
            UpdateOrders();
        }

        private void ViewBtn_Click(object sender, RoutedEventArgs e) { var order = SelectedOrder(); if (order != null) OpenOrder(order, true); }
        private void AddBtn_Click(object sender, RoutedEventArgs e) { OpenOrder(null, false); }
        private void EditBtn_Click(object sender, RoutedEventArgs e)
        {
            if (currentUser.RoleID != 1) return;
            var order = SelectedOrder(); if (order != null) OpenOrder(order, false);
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            var order = SelectedOrder();
            if (order == null) return;
            if (MessageBox.Show("Удалить заказ №" + order.OrderID + " и вернуть товары в каталог?", "Удаление заказа", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes) return;
            // A separate context keeps an unsuccessful save from changing the shared page data.
            using (var context = new YusupovMiracleShowEntities())
            using (var transaction = context.Database.BeginTransaction(IsolationLevel.Serializable))
            {
                try
                {
                    var currentOrder = context.Order.Include(p => p.OrderItem).FirstOrDefault(p => p.OrderID == order.OrderID);
                    if (currentOrder == null) throw new InvalidOperationException("Заказ уже удалён. Обновите список.");
                    foreach (var item in currentOrder.OrderItem.ToList())
                    {
                        int changed = context.Database.ExecuteSqlCommand("UPDATE CommodityPosition SET QuantityInStock = QuantityInStock + @p0 WHERE CommodityPositionID = @p1", item.Quantity, item.CommodityPositionID);
                        if (changed != 1) throw new InvalidOperationException("Не найдена товарная позиция заказа.");
                    }
                    context.OrderItem.RemoveRange(currentOrder.OrderItem);
                    context.Order.Remove(currentOrder);
                    context.SaveChanges();
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    MessageBox.Show("Ошибка удаления: " + ex.GetBaseException().Message);
                    return;
                }
            }
            var shared = YusupovMiracleShowEntities.GetContext();
            foreach (var item in order.OrderItem.ToList()) shared.Entry(item).State = EntityState.Detached;
            shared.Entry(order).State = EntityState.Detached;
            foreach (var position in shared.CommodityPosition.Local.ToList()) shared.Entry(position).Reload();
            UpdateOrders();
            MessageBox.Show("Заказ удалён.");
        }
    }
}
