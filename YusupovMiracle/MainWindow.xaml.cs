using System.Windows;
using System.Windows.Navigation;

namespace YusupovMiracle
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            Manager.MainFrame = MainFrame;
            MainFrame.Navigate(new AuthPage());
        }

        private void BtnBack_Click(object sender, RoutedEventArgs e)
        {
            if (MainFrame.CanGoBack) MainFrame.GoBack();
        }

        private void MainFrame_Navigating(object sender, NavigatingCancelEventArgs e)
        {
            if (MainFrame.Content is AuthPage && e.NavigationMode == NavigationMode.Forward)
                e.Cancel = true;
        }

        private void MainFrame_Navigated(object sender, NavigationEventArgs e)
        {
            BtnBack.Visibility = MainFrame.CanGoBack ? Visibility.Visible : Visibility.Collapsed;
        }
    }
}