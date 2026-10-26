using System;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace YusupovMiracle
{
    public partial class AuthPage : Page
    {
        public AuthPage() { InitializeComponent(); }

        private void LoginGuestBtn_Click(object sender, RoutedEventArgs e)
        {
            try { Manager.MainFrame.Navigate(new ProductPage(null)); }
            catch (Exception ex) { MessageBox.Show("Ошибка подключения к базе данных: " + ex.GetBaseException().Message); }
        }

        private void LoginBtn_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginTB.Text.Trim();
            if (login == "") { MessageBox.Show("Введите логин!"); return; }
            try
            {
                Client user = YusupovMiracleShowEntities.GetContext().Client.ToList().Find(p => p.Login == login);
                if (user != null)
                {
                    Manager.MainFrame.Navigate(new ProductPage(user));
                    LoginTB.Text = "";
                }
                else MessageBox.Show("Пользователь с таким логином не найден.");
            }
            catch (Exception ex) { MessageBox.Show("Ошибка подключения к базе данных: " + ex.GetBaseException().Message); }
        }
    }
}