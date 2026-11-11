using System;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using Microsoft.Win32;

namespace YusupovMiracle
{
    public partial class AnalyticsPage : Page
    {
        private SalesReport report;
        private int requestVersion;

        public AnalyticsPage(Client user)
        {
            if (user == null || user.RoleID != 1)
                throw new InvalidOperationException("Аналитика доступна только администратору.");

            InitializeComponent();
            var today = DateTime.Today;
            StartDate.SelectedDate = new DateTime(today.Year, today.Month, 1);
            EndDate.SelectedDate = StartDate.SelectedDate.Value.AddMonths(1).AddDays(-1);
        }

        private async void Page_Loaded(object sender, RoutedEventArgs e)
        {
            await UpdateReport();
        }

        private async void Period_Changed(object sender, SelectionChangedEventArgs e)
        {
            if (IsLoaded) await UpdateReport();
        }

        private void Period_Invalid(object sender, DatePickerDateValidationErrorEventArgs e)
        {
            e.ThrowException = false;
            var picker = (DatePicker)sender;
            ClearReport();
            int version = ++requestVersion;

            // DatePicker first restores its previous text after a failed parse.
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (version != requestVersion) return;
                picker.SelectedDate = null;
                picker.Text = "";
                ShowStatus("Введите корректную дату в формате ДД.ММ.ГГГГ.", true);
            }));
        }

        private async Task UpdateReport()
        {
            int version = ++requestVersion;
            ClearReport();
            var start = StartDate.SelectedDate;
            var end = EndDate.SelectedDate;
            if (!start.HasValue || !end.HasValue || start > end)
            {
                ShowStatus(!start.HasValue || !end.HasValue
                    ? "Укажите дату начала и дату окончания."
                    : "Дата начала не может быть позже даты окончания.", true);
                return;
            }

            ShowStatus("Загрузка отчёта…");
            try
            {
                SalesReport result = await SalesReport.LoadAsync(start.Value.Date, end.Value.Date);
                if (version != requestVersion || !IsLoaded) return;

                report = result;
                OrderCountText.Text = $"Количество заказов: {report.OrderCount}";
                TotalSalesText.Text = $"Сумма продаж: {report.TotalSales:N2} ₽";
                TopModelsGrid.ItemsSource = report.TopModels;
                ShowStatus(report.OrderCount == 0 ? "За выбранный период заказов нет." : "");
                ExportBtn.IsEnabled = true;
            }
            catch (Exception ex)
            {
                if (version == requestVersion && IsLoaded)
                    ShowStatus("Не удалось загрузить отчёт: " + ex.GetBaseException().Message, true);
            }
        }

        private void ClearReport()
        {
            report = null;
            OrderCountText.Text = "";
            TotalSalesText.Text = "";
            TopModelsGrid.ItemsSource = null;
            ExportBtn.IsEnabled = false;
        }

        private void ShowStatus(string text, bool isError = false)
        {
            StatusText.Text = text;
            StatusText.Foreground = isError ? Brushes.DarkRed : Brushes.DimGray;
        }

        private void Export_Click(object sender, RoutedEventArgs e)
        {
            var currentReport = report;
            if (currentReport == null) return;
            var dialog = new SaveFileDialog
            {
                Filter = "Документ PDF (*.pdf)|*.pdf",
                DefaultExt = ".pdf",
                FileName = $"Отчёт_{currentReport.Start:yyyy-MM-dd}_{currentReport.End:yyyy-MM-dd}"
            };
            try
            {
                if (dialog.ShowDialog(Window.GetWindow(this)) != true) return;
                currentReport.SavePdf(dialog.FileName);
                MessageBox.Show("Отчёт сохранён.", "Экспорт в PDF");
            }
            catch (Exception ex)
            {
                ShowStatus("Не удалось сохранить PDF: " + ex.GetBaseException().Message, true);
            }
        }
    }
}
