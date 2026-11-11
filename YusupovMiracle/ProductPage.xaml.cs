using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace YusupovMiracle
{
    public partial class ProductPage : Page
    {
        List<OrderItem> selectedOrderProducts = new List<OrderItem>();
        private Client currentUser;
        private bool isReady;
        public Visibility OrderControlsVisibility { get { return currentUser == null ? Visibility.Collapsed : Visibility.Visible; } }

        public ProductPage(Client user)
        {
            currentUser = user;
            InitializeComponent();
            FIOTB.Text = user == null ? "Гость" : user.FIO;
            RoleTB.Text = user == null ? "Гость" : user.UserRole.RoleName;
            OrdersBtn.Visibility = user != null && (user.RoleID == 1 || user.RoleID == 2) ? Visibility.Visible : Visibility.Collapsed;
            AnalyticsBtn.Visibility = user != null && user.RoleID == 1 ? Visibility.Visible : Visibility.Collapsed;
            FilterPanel.Visibility = OrderControlsVisibility;
            if (user != null)
            {
                var categories = YusupovMiracleShowEntities.GetContext().Category.ToList();
                categories.Insert(0, new Category { CategoryID = 0, CategoryName = "Все категории" });
                ComboType.ItemsSource = categories;
                ComboType.DisplayMemberPath = "CategoryName";
                ComboType.SelectedIndex = 0;
            }
            isReady = true;
            UpdateServices();
        }

        private void TBoxSearch_TextChanged(object sender, TextChangedEventArgs e) { UpdateServices(); }
        private void ComboType_SelectionChanged(object sender, SelectionChangedEventArgs e) { UpdateServices(); }
        private void RButtonUp_Checked(object sender, RoutedEventArgs e) { UpdateServices(); }
        private void RButtonDown_Checked(object sender, RoutedEventArgs e) { UpdateServices(); }
        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            try { UpdateServices(); }
            catch (Exception ex) { MessageBox.Show("Не удалось обновить каталог: " + ex.GetBaseException().Message); }
        }

        private void UpdateServices()
        {
            if (!isReady) return;
            var currentServices = YusupovMiracleShowEntities.GetContext().Product
                .Include(p => p.Category).Include(p => p.SubCategory).Include(p => p.Manufacture)
                .Include(p => p.CommodityPosition).ToList();
            int totalCount = currentServices.Count;
            if (currentUser != null)
            {
                var category = ComboType.SelectedItem as Category;
                if (category != null && category.CategoryID != 0)
                    currentServices = currentServices.Where(p => p.CategoryID == category.CategoryID).ToList();
                currentServices = currentServices.Where(p => p.ProductName.ToLower().Contains(TBoxSearch.Text.Trim().ToLower())).ToList();
                if (RButtonDown.IsChecked == true) currentServices = currentServices.OrderByDescending(p => p.Price).ToList();
                if (RButtonUp.IsChecked == true) currentServices = currentServices.OrderBy(p => p.Price).ToList();
            }
            TBlockRecordCount.Text = $"Записей: {currentServices.Count} из {totalCount}";
            ProductListView.ItemsSource = currentServices.ToList();
        }

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            if (currentUser == null) return;
            var position = (sender as Button).Tag as CommodityPosition;
            if (position == null) { MessageBox.Show("Выберите доступный размер!"); return; }
            var selectedOP = selectedOrderProducts.FirstOrDefault(p => p.CommodityPositionID == position.CommodityPositionID);
            if ((selectedOP == null ? 0 : selectedOP.Quantity) >= position.QuantityInStock)
            { MessageBox.Show("Нельзя заказать больше пар, чем есть в наличии."); return; }
            if (selectedOP == null)
                selectedOrderProducts.Add(new OrderItem { CommodityPositionID = position.CommodityPositionID, CommodityPosition = position, Quantity = 1, PriceAtOrderTime = position.Product.Price });
            else selectedOP.Quantity++;
            OrderBTn.Visibility = Visibility.Visible;
            OrderBTn.Content = "Просмотреть заказ (" + selectedOrderProducts.Sum(p => p.Quantity) + ")";
        }

        private void OrderBTn_Click(object sender, RoutedEventArgs e)
        {
            var orderWindow = new OrderWindow(selectedOrderProducts, currentUser);
            orderWindow.Owner = Window.GetWindow(this);
            if (orderWindow.ShowDialog() == true) selectedOrderProducts.Clear();
            OrderBTn.Visibility = selectedOrderProducts.Any() ? Visibility.Visible : Visibility.Collapsed;
            OrderBTn.Content = "Просмотреть заказ (" + selectedOrderProducts.Sum(p => p.Quantity) + ")";
            UpdateServices();
        }

        private void OrdersBtn_Click(object sender, RoutedEventArgs e)
        {
            Manager.MainFrame.Navigate(new OrdersPage(currentUser));
        }

        private void AnalyticsBtn_Click(object sender, RoutedEventArgs e)
        {
            if (currentUser != null && currentUser.RoleID == 1)
                Manager.MainFrame.Navigate(new AnalyticsPage(currentUser));
        }
    }
}
