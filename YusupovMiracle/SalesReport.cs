using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using MigraDoc.DocumentObjectModel;
using MigraDoc.DocumentObjectModel.Tables;
using MigraDoc.Rendering;

namespace YusupovMiracle
{
    internal sealed class SalesReport
    {
        internal sealed class ModelSales
        {
            public string Name { get; set; }
            public string Manufacturer { get; set; }
            public long Pairs { get; set; }
        }

        public DateTime Start { get; private set; }
        public DateTime End { get; private set; }
        public int OrderCount { get; private set; }
        public decimal TotalSales { get; private set; }
        public List<ModelSales> TopModels { get; private set; }

        public static async Task<SalesReport> LoadAsync(DateTime start, DateTime end)
        {
            using (var context = new YusupovMiracleShowEntities())
            {
                var orders = context.Order.Where(order => order.OrderDate >= start);
                if (end < DateTime.MaxValue.Date)
                {
                    var nextDay = end.AddDays(1);
                    orders = orders.Where(order => order.OrderDate < nextDay);
                }

                // Keep orders without lines in the order count.
                var rows = await (from order in orders
                                  from item in order.OrderItem.DefaultIfEmpty()
                                  select new
                                  {
                                      order.OrderID,
                                      ProductID = (int?)item.CommodityPosition.ProductID,
                                      Name = item.CommodityPosition.Product.ProductName,
                                      Manufacturer = item.CommodityPosition.Product.Manufacture.Manufacture1,
                                      Quantity = (long?)item.Quantity,
                                      Amount = (decimal?)(item.Quantity * item.PriceAtOrderTime)
                                  }).ToListAsync();

                return new SalesReport
                {
                    Start = start,
                    End = end,
                    OrderCount = rows.Select(row => row.OrderID).Distinct().Count(),
                    TotalSales = rows.Sum(row => row.Amount) ?? 0m,
                    TopModels = rows.Where(row => row.ProductID.HasValue)
                        .GroupBy(row => new { row.ProductID, row.Name, row.Manufacturer })
                        .Select(model => new ModelSales
                        {
                            Name = model.Key.Name,
                            Manufacturer = model.Key.Manufacturer,
                            Pairs = model.Sum(row => row.Quantity.GetValueOrDefault())
                        })
                        .OrderByDescending(model => model.Pairs)
                        .ThenBy(model => model.Name)
                        .ThenBy(model => model.Manufacturer)
                        .Take(5)
                        .ToList()
                };
            }
        }

        public void SavePdf(string path)
        {
            var culture = CultureInfo.GetCultureInfo("ru-RU");
            var document = new Document();
            document.Info.Title = "Чудо Обувь — отчёт о продажах";
            document.Styles[StyleNames.Normal].Font.Name = "Calibri";
            document.Styles[StyleNames.Normal].Font.Size = Unit.FromPoint(11);

            var section = document.AddSection();
            section.PageSetup.PageFormat = PageFormat.A4;
            section.PageSetup.LeftMargin = Unit.FromCentimeter(2);
            section.PageSetup.RightMargin = Unit.FromCentimeter(2);

            var title = section.AddParagraph("Чудо Обувь — отчёт о продажах");
            title.Format.Font.Size = Unit.FromPoint(20);
            title.Format.Font.Bold = true;
            title.Format.SpaceAfter = Unit.FromPoint(10);
            section.AddParagraph(string.Format(culture, "Период: {0:dd.MM.yyyy} — {1:dd.MM.yyyy}", Start, End));
            section.AddParagraph(string.Format(culture, "Количество заказов: {0}", OrderCount));
            section.AddParagraph(string.Format(culture, "Сумма продаж: {0:N2} ₽", TotalSales));

            var heading = section.AddParagraph("Топ-5 моделей по количеству проданных пар");
            heading.Format.Font.Bold = true;
            heading.Format.SpaceBefore = Unit.FromPoint(16);
            heading.Format.SpaceAfter = Unit.FromPoint(6);
            heading.Format.KeepWithNext = true;
            if (TopModels.Count == 0)
                section.AddParagraph("Нет проданных моделей за выбранный период.");
            else
            {
                var table = section.AddTable();
                table.Borders.Width = Unit.FromPoint(0.5);
                table.Borders.Color = Colors.LightGray;
                table.AddColumn(Unit.FromCentimeter(8));
                table.AddColumn(Unit.FromCentimeter(6));
                table.AddColumn(Unit.FromCentimeter(3)).Format.Alignment = ParagraphAlignment.Right;
                Row header = AddModelRow(table, "Модель", "Производитель", "Продано пар");
                header.HeadingFormat = true;
                header.Format.Font.Bold = true;
                header.Shading.Color = Color.FromRgb(210, 246, 231);
                foreach (var model in TopModels)
                    AddModelRow(table, model.Name, model.Manufacturer, model.Pairs.ToString(culture));
            }

            var renderer = new PdfDocumentRenderer { Document = document };
            renderer.RenderDocument();
            renderer.PdfDocument.Save(path);
        }

        private static Row AddModelRow(Table table, string name, string manufacturer, string pairs)
        {
            var row = table.AddRow();
            row.TopPadding = Unit.FromPoint(4);
            row.BottomPadding = Unit.FromPoint(4);
            row.Cells[0].AddParagraph(name ?? "");
            row.Cells[1].AddParagraph(manufacturer ?? "");
            row.Cells[2].AddParagraph(pairs);
            return row;
        }
    }
}
