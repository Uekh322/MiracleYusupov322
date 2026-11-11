USE [master]
GO
CREATE DATABASE [MiracleShowTraining]
GO
USE [MiracleShowTraining]
GO
/****** Объект:  Table [dbo].[Category]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Clients]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] NOT NULL,
	[Lastname] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Patronymic] [nvarchar](255) NULL,
	[Login] [nvarchar](255) NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[CommodityPosition]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CommodityPosition](
	[CommodityPositionID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[SizeID] [int] NOT NULL,
	[Size] [float] NOT NULL,
	[QuantityInStock] [int] NOT NULL,
 CONSTRAINT [PK_CommodityPosition] PRIMARY KEY CLUSTERED
(
	[CommodityPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Manufacture]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacture](
	[ManufactureID] [int] NOT NULL,
	[Manufacture] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_Manufacture] PRIMARY KEY CLUSTERED
(
	[ManufactureID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Order]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ClientID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[OrderItem]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PriceAtOrderTime] [decimal](18, 2) NOT NULL,
	[CommodityPositionID] [int] NOT NULL,
	[OrderItemID] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Product]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] NOT NULL,
	[Image] [nvarchar](255) NULL,
	[ProductName] [nvarchar](255) NOT NULL,
	[Discription] [nvarchar](255) NULL,
	[Compound] [nvarchar](255) NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SubCategoryID] [int] NOT NULL,
	[ManufactureID] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[Sizes]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sizes](
	[SizeID] [int] NOT NULL,
	[SizeValue] [decimal](4, 1) NOT NULL,
	[SizeLabel] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sizes] PRIMARY KEY CLUSTERED
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[SubCategory]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategory](
	[SubCategoryID] [int] NOT NULL,
	[SubCategoryName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED
(
	[SubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Объект:  Table [dbo].[UserRole]    Дата создания скрипта: 10.11.2026 1:40:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserID] [int] NOT NULL,
	[RoleName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON

INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (1, N'Детская одежда')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (2, N'Женская одежда')
INSERT [dbo].[Category] ([CategoryID], [CategoryName]) VALUES (3, N'Мужская одежда')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (1, N'Иванов', N'Иван', N'Сергеевич', N'isivanov', 1)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (2, N'Петров', N'Пeтр', N'Алексеевич', N'papetrov', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (3, N'Сидорова', N'Анна', N'Дмитриевна', N'asidorova', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (4, N'Кузнецова', N'Екатерина', N'Андреевна', N'ekuznetsova', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (5, N'Смирнов', N'Дмитрий', N'Владимирович', N'dsmirnov', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (6, N'Попов', N'Алексей', N'Николаевич', N'apopov', 1)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (7, N'Васильева', N'Ольга', N'Игоревна', N'ovasileva', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (8, N'Соколов', N'Павел', N'Викторович', N'psokolov', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (9, N'Михайлова', N'Татьяна', N'Юрьевна', N'tmikhailova', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (10, N'Новикова', N'Наталья', N'Сергеевна', N'nnovikova', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (11, N'Фёдоров', N'Андрей', N'Максимович', N'afedorov', 1)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (12, N'Морозов', N'Сергей', N'Павлович', N'smorozov', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (13, N'Волкова', N'Юлия', N'Александровна', N'jvolkova', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (14, N'Алексеев', N'Артём', N'Евгеньевич', N'aalekseev', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (15, N'Лебедева', N'Ирина', N'Владимировна', N'ilebedeva', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (16, N'Егоров', N'Никита', N'Денисович', N'negorov', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (17, N'Павлова', N'Елена', N'Петровна', N'epavlova', 3)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (18, N'Козлов', N'Роман', N'Олегович', N'rkozlov', 1)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (19, N'Степанова', N'Виктория', N'Романовна', N'vstepanova', 2)
INSERT [dbo].[Clients] ([ClientID], [Lastname], [Name], [Patronymic], [Login], [RoleID]) VALUES (20, N'Николаев', N'Владимир', N'Иванович', N'vnikolaev', 3)
GO
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (1, 1, 3, 20, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (2, 1, 4, 21, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (3, 1, 5, 22, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (4, 1, 6, 23, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (5, 1, 7, 24, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (6, 1, 8, 25, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (7, 2, 16, 33, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (8, 2, 17, 34, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (9, 3, 2, 19, 30)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (10, 3, 3, 20, 30)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (11, 4, 2, 19, 15)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (12, 4, 3, 20, 15)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (13, 5, 4, 21, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (14, 5, 5, 22, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (15, 5, 6, 23, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (16, 6, 1, 18, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (17, 6, 2, 19, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (18, 6, 3, 20, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (19, 7, 4, 21, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (20, 7, 5, 22, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (21, 7, 6, 23, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (22, 7, 7, 24, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (23, 8, 10, 27, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (24, 8, 11, 28, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (25, 8, 12, 29, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (26, 8, 13, 30, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (27, 9, 1, 18, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (28, 9, 2, 19, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (29, 9, 3, 20, 7)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (30, 10, 19, 36, 12)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (31, 10, 21, 37, 12)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (32, 11, 25, 39, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (33, 11, 27, 40, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (34, 12, 21, 37, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (35, 12, 25, 39, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (36, 12, 27, 40, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (37, 13, 19, 36, 10)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (38, 13, 21, 37, 10)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (39, 13, 23, 38, 10)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (40, 13, 25, 39, 10)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (41, 13, 27, 40, 10)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (42, 14, 18, 35, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (43, 15, 21, 37, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (44, 15, 25, 39, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (45, 15, 27, 40, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (46, 16, 19, 36, 25)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (47, 16, 21, 37, 25)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (48, 16, 23, 38, 25)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (49, 17, 19, 36, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (50, 17, 23, 38, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (51, 17, 25, 39, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (52, 17, 27, 40, 4)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (53, 18, 18, 35, 9)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (54, 18, 23, 38, 9)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (55, 19, 18, 35, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (56, 19, 19, 36, 2)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (57, 20, 21, 37, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (58, 20, 22, 37.5, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (59, 20, 23, 38, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (60, 20, 24, 38.5, 5)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (61, 21, 18, 35, 16)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (62, 21, 19, 36, 16)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (63, 21, 23, 38, 16)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (64, 21, 25, 39, 16)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (65, 22, 18, 35, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (66, 22, 23, 38, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (67, 23, 30, 41.5, 18)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (68, 23, 31, 42, 18)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (69, 23, 32, 42.5, 18)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (70, 23, 33, 43, 18)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (71, 24, 23, 38, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (72, 24, 24, 38.5, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (73, 24, 25, 39, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (74, 24, 26, 39.5, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (75, 24, 27, 40, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (76, 24, 29, 41, 50)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (77, 25, 29, 41, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (78, 25, 31, 42, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (79, 25, 34, 44, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (80, 26, 27, 40, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (81, 26, 29, 41, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (82, 26, 33, 43, 23)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (83, 27, 31, 42, 15)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (84, 27, 33, 43, 15)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (85, 27, 34, 44, 15)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (86, 28, 34, 44, 3)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (87, 29, 29, 41, 1)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (88, 29, 31, 42, 1)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (89, 30, 31, 42, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (90, 30, 33, 43, 20)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (91, 31, 29, 41, 30)
INSERT [dbo].[CommodityPosition] ([CommodityPositionID], [ProductID], [SizeID], [Size], [QuantityInStock]) VALUES (92, 31, 31, 42, 30)
GO
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (1, N'Азимут')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (2, N'Барбари')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (3, N'Берестов')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (4, N'Весна')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (5, N'Здоровый шаг')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (6, N'Карапуз')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (7, N'Кожевенные традиции')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (8, N'Лапушка')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (9, N'Маленький франт')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (10, N'Малыш-Спорт')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (11, N'Модный силуэт')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (12, N'Северята')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (13, N'Стиль и комфорт')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (14, N'Твой комфорт')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (15, N'Тёплые ножки')
INSERT [dbo].[Manufacture] ([ManufactureID], [Manufacture]) VALUES (16, N'Топ-Топ')
GO
SET IDENTITY_INSERT [dbo].[Order] ON

INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (3, CAST(N'2026-04-02' AS Date), 11)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (17, CAST(N'2026-04-05' AS Date), 12)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (7, CAST(N'2026-04-08' AS Date), 13)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (15, CAST(N'2026-04-12' AS Date), 14)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (12, CAST(N'2026-04-18' AS Date), 15)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (9, CAST(N'2026-04-22' AS Date), 16)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (14, CAST(N'2026-04-25' AS Date), 17)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (20, CAST(N'2026-04-28' AS Date), 18)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (5, CAST(N'2026-05-05' AS Date), 19)
INSERT [dbo].[Order] ([ClientID], [OrderDate], [OrderID]) VALUES (17, CAST(N'2026-05-08' AS Date), 20)
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderItem] ON

INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (11, 1, CAST(2190.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (11, 1, CAST(2790.00 AS Decimal(18, 2)), 20, 2)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (12, 1, CAST(25000.00 AS Decimal(18, 2)), 30, 3)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (12, 1, CAST(7500.00 AS Decimal(18, 2)), 39, 4)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (13, 1, CAST(17000.00 AS Decimal(18, 2)), 34, 5)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (13, 1, CAST(8565.00 AS Decimal(18, 2)), 57, 6)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (13, 1, CAST(7795.00 AS Decimal(18, 2)), 65, 7)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (14, 1, CAST(7757.00 AS Decimal(18, 2)), 50, 8)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (14, 1, CAST(12340.00 AS Decimal(18, 2)), 48, 9)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (14, 1, CAST(7130.00 AS Decimal(18, 2)), 44, 10)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (14, 1, CAST(8765.00 AS Decimal(18, 2)), 62, 11)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (14, 1, CAST(15000.00 AS Decimal(18, 2)), 32, 12)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (15, 1, CAST(9567.00 AS Decimal(18, 2)), 77, 13)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (15, 1, CAST(21500.00 AS Decimal(18, 2)), 87, 14)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (15, 1, CAST(7890.00 AS Decimal(18, 2)), 73, 15)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (16, 1, CAST(24569.00 AS Decimal(18, 2)), 80, 16)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (16, 1, CAST(14567.00 AS Decimal(18, 2)), 89, 17)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (16, 1, CAST(15670.00 AS Decimal(18, 2)), 91, 18)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (17, 1, CAST(4290.00 AS Decimal(18, 2)), 16, 19)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (17, 2, CAST(2190.00 AS Decimal(18, 2)), 2, 20)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (17, 1, CAST(1690.00 AS Decimal(18, 2)), 24, 21)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (18, 1, CAST(25625.00 AS Decimal(18, 2)), 86, 22)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (18, 3, CAST(7890.00 AS Decimal(18, 2)), 75, 23)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (18, 2, CAST(6550.00 AS Decimal(18, 2)), 70, 24)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (19, 1, CAST(2490.00 AS Decimal(18, 2)), 7, 25)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (19, 2, CAST(3190.00 AS Decimal(18, 2)), 14, 26)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (20, 1, CAST(7550.00 AS Decimal(18, 2)), 53, 27)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (20, 1, CAST(7130.00 AS Decimal(18, 2)), 43, 28)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (20, 1, CAST(12340.00 AS Decimal(18, 2)), 46, 29)
INSERT [dbo].[OrderItem] ([OrderID], [Quantity], [PriceAtOrderTime], [CommodityPositionID], [OrderItemID]) VALUES (20, 2, CAST(8765.00 AS Decimal(18, 2)), 61, 30)
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
GO
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (1, N'IMG_KS_195217.png', N'Кроссовки детские «Звёздочка» экокожа', N'Кроссовки детские «Звёздочка» экокожа. Производитель: ООО «Малыш-Спорт», г. Смоленск', N'Верх — экокожа (полиуретан на хлопковой основе), подкладка — хлопок 100%, подошва — ПВХ', CAST(2190.00 AS Decimal(18, 2)), 1, 3, 10)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (2, N'IMG_KS_195213.png', N'Кроссовки детские «Гонщик» экокожа', N'Кроссовки детские «Гонщик» экокожа. Производитель: Фабрика «Топ-Топ», г. Киров', N'Верх — экокожа (микрофибра), подкладка — текстиль сетчатый (полиэстер), подошва — термопластичная резина (ТЭП)', CAST(2490.00 AS Decimal(18, 2)), 1, 3, 16)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (3, N'IMG_KS_195222.png', N'Кроссовки детские «Радуга» экокожа перфорированная', N'Кроссовки детские «Радуга» экокожа перфорированная. Производитель: ИП Смирнова Л.В. (бренд «Лапушка»), г. Вологда', N'Верх — экокожа перфорированная, вставки — нейлон, стелька — ортопедическая с латексной подушкой, подошва — ЭВА', CAST(1990.00 AS Decimal(18, 2)), 1, 3, 8)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (4, N'IMG_KB_185501.png', N'Сапожки детские «Снежинка» зимние на меху', N'Сапожки детские «Снежинка» зимние на меху. Производитель: ООО «Тёплые ножки», г. Новосибирск', N'Верх — экокожа морозостойкая, утеплитель — искусственный мех (акрил 70%, полиэстер 30%), подкладка — флис, подошва — термоэластопласт (ТЭП)', CAST(3490.00 AS Decimal(18, 2)), 1, 4, 15)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (5, N'IMG_KB_164816.png', N'Сапожки детские «Медвежонок» демисезонные непромокаемые', N'Сапожки детские «Медвежонок» демисезонные непромокаемые. Производитель: Компания «Северята», г. Архангельск', N'Верх — плащёвая ткань с водоотталкивающей пропиткой (полиэстер 100%), отделка — экокожа, подкладка — микрофибра, мембрана — AirTex, подошва — резина', CAST(3190.00 AS Decimal(18, 2)), 1, 4, 12)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (6, N'IMG_KB_164811.png', N'Сапожки детские «Принцесса» кожаные', N'Сапожки детские «Принцесса» кожаные. Производитель: Мастерская «Весна», г. Тула', N'Верх — натуральная кожа (КРС), подкладка — шерсть натуральная (70%), байка (30%), стелька — войлочная, подошва — полиуретан', CAST(4290.00 AS Decimal(18, 2)), 1, 4, 4)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (7, N'IMG_KSd_195207.png', N'Сандалии детские «Пчёлка» ортопедические летние', N'Сандалии детские «Пчёлка» ортопедические летние. Производитель: ООО «Здоровый шаг», г. Воронеж', N'Верх — нубук натуральный, подкладка — кожа растительного дубления, стелька — анатомическая с супинатором (латекс + пробка), подошва — каучук', CAST(2790.00 AS Decimal(18, 2)), 1, 1, 5)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (8, N'IMG_KSd_185508.png', N'Сандалии детские «Морячок» текстильные с фиксатором', N'Сандалии детские «Морячок» текстильные с фиксатором. Производитель: ИП Кузнецов А.Д. (бренд «Карапуз»), г. Краснодар', N'Верх — джинсовая ткань (хлопок 100%), окантовка — искусственная кожа, подкладка — хлопок, подошва — ЭВА лёгкая', CAST(1690.00 AS Decimal(18, 2)), 1, 1, 6)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (9, N'IMG_KSho_185512.png', N'Туфли детские «Бантик» лаковые праздничные', N'Туфли детские «Бантик» лаковые праздничные. Производитель: Дом обуви «Маленький франт», г. Москва', N'Верх — искусственная лаковая кожа (ПВХ), носок усиленный — термопластичный полиуретан, подкладка — кожа искусственная дышащая, стелька — анатомическая с амортизацией, подошва — полиуретан', CAST(2390.00 AS Decimal(18, 2)), 1, 5, 9)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (10, N'IMG_WB_170905.png', N'Сапоги зимние натуральная кожа', N'Сапоги женские зимние, нескользящая, устойчивая подошва, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', N'Верх — натуральная кожа, подкладка — евромех, натуральный мех, текстильный утеплитель, подошва — резина', CAST(25000.00 AS Decimal(18, 2)), 2, 4, 2)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (11, N'IMG_WB_170859.png', N'Сапоги осенние натуральная кожа', N'Сапоги женские демисезонные из высококачественной натуральной кожи. Производитель: Дом обуви «Барбари», г. Новороссийск ', N'Верх — натуральная кожа, подкладка — текстильный утеплитель, стелька — текстиль, подошва — ТПР', CAST(15000.00 AS Decimal(18, 2)), 2, 4, 2)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (12, N'IMG_WB_170906.png', N'Сапоги трубы демисезонные замшевые', N'Сапоги женские демисезонные замшевые. Производитель: ОАО «Твой комфорт», г. Ярославль', N'Верх — натуральная замша, утепленные, тракторная подошва, стелька — байка, подошва — резина', CAST(17000.00 AS Decimal(18, 2)), 2, 4, 14)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (13, N'IMG_WSd_174332.png', N'Босоножки «Песчаный берег» коричневые', N'Коричневая кожаная модель с открытым носком, боковой пряжкой и закрытым каблуком. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', N'Верх — 100% козья кожа, подкладка — 100% кожа; подошва: 100% кожа', CAST(7500.00 AS Decimal(18, 2)), 2, 1, 13)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (14, N'IMG_WSd_185156.png', N'Женские босоножки «Черный кофе» со скульптурным каблуком', N'Открытый носок и ремешок со сборной пряжкой, низкий каблук и резиновая подошва гарантируют комфорт. Производитель: ЗАО «Кожевенные традиции», г. Вятка', N'Верх — кожа собственного производств, подкладка — кожа; подошва: резина', CAST(5600.00 AS Decimal(18, 2)), 2, 1, 7)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (15, N'IMG_WSd_185551.png', N'Босоножки женские «Летний бриз»', N'Босоножки женские кожаные белые, регулируемый ремешок, закрытый каблук и кожаная подошва. Производитель: ООО «Модный силуэт», г. Кострома', N'Верх — натуральная кожа, подкладка — натуральная кожа, подошва — кожа', CAST(7130.00 AS Decimal(18, 2)), 2, 1, 11)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (16, N'IMG_WSho_174409.png', N'Демисезонные туфли натуральная кожа', N'Комфортные лаконичные лодочки, классический дизайна с современными акцентами. Производитель: ООО «Модный силуэт», г. Кострома', N'Верх — натуральная овечья кожа, подкладка и стелька — натуральная овечья кожа, подошва — резина', CAST(12340.00 AS Decimal(18, 2)), 2, 5, 11)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (17, N'IMG_WSho_185202.png', N'Туфли женские натуральная кожа с металлическими вставками', N'Стильные туфли для весеннего и летнего сезона. Производитель: ЗАО «Кожевенные традиции», г. Вятка', N'Верх — натуральная телячьей кожа, металлическая пряжка, подкладка и стелька— натуральная овечья кожа, подошва — резина', CAST(7757.00 AS Decimal(18, 2)), 2, 5, 7)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (18, N'IMG_WSho_185545.png', N'Туфли классические лодочки натуральная кожа', N'Модель из натуральной кожи, классический острый носок и изящная шпилька. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', N'Верх — натуральная кожа, подкладка и стелька — натуральная кожа, подошва — тунит', CAST(7550.00 AS Decimal(18, 2)), 2, 5, 13)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (19, N'IMG_WS_174110.png', N'Кроссовки белые с оранжевым и красным', N'Многослойный верх из кожи и текстиля. Производитель: Фабрика «Топ-Топ», г. Киров', N'Верх — 70% кожа, 30% текстиль, подкладка — текстиль, подошва — резина', CAST(9450.00 AS Decimal(18, 2)), 2, 3, 16)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (20, N'IMG_WS_185528.png', N'Кроссовки летние кожаные', N'Уверенность на каждом шагу. Материал обеспечивает долговечность и комфорт при носке. Производитель: Фабрика «Топ-Топ», г. Киров', N'Верх — 87% кожа, 11% текстиль, 2% синтетика; подкладка: 100% текстиль; подошва: резина, пластик', CAST(8565.00 AS Decimal(18, 2)), 2, 3, 16)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (21, N'IMG_WS_185535.png', N'Кроссовки кожаные', N'Кроссовки женские из натуральной кожи. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', N'Верх — натуральная кожа, подкладка — кожа, подошва — полиуретан', CAST(8765.00 AS Decimal(18, 2)), 2, 3, 13)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (22, N'IMG_WS_185538.png', N'Кроссовки «Стиль и комфорт»', N'Кроссовки женские из натуральной кожи и синтетических материалов, сетчатые вставки. Производитель: ИП «Стиль и комфорт», г. Санкт-Петербург', N'Верх — 70% кожа, 20% полиамид, 10% полиуретан; подкладка — текстиль, подошва — ТПУ', CAST(7795.00 AS Decimal(18, 2)), 2, 3, 13)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (23, N'IMG_MS_185531.png', N'Кроссовки для бега «Драйв»', N'Сочетание стиля, комфорта и современных технологий. Производитель: Фабрика «Азимут», г. Санкт-Петербург', N'Верх —  сетка, подкладка — текстиль, подошва —  резина', CAST(6550.00 AS Decimal(18, 2)), 3, 3, 1)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (24, N'IMG_MS_185532.png', N'Кроссовки «Азимут Бег» ', N'Универсальный выбор для повседневного использования. Производитель: Фабрика «Азимут», г. Санкт-Петербург', N'Верх — 6% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', CAST(7890.00 AS Decimal(18, 2)), 3, 3, 1)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (25, N'IMG_MS_185533.png', N'Кроссовки', N'Кроссовки для мужчин, идеальное сочетание стиля и комфорта. Производитель: Фабрика «Топ-Топ», г. Киров', N'Верх — 56% кожа, 29% текстиль, 15% полимерные материалы; подкладка — 100% текстиль; подошва — полимерные материалы, резина', CAST(9567.00 AS Decimal(18, 2)), 3, 3, 16)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (26, N'IMG_MSho_190514.png', N'Черные туфли в классическом стиле — база для деловых образов', N'Модель выполнена из натуральной кожи, на резиновой подошве. Производитель: Дом обуви «Барбари», г. Новороссийск ', N'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — резина', CAST(24569.00 AS Decimal(18, 2)), 3, 5, 2)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (27, N'IMG_MSho_190518.png', N'Туфли мужские светлые классика демисезонные', N'Туфли на низком каблуке кожаные', N'Верх — натуральная кожа, подкладка — текстиль, стелька — натуральная кожа, подошва — ТЭП', CAST(10155.00 AS Decimal(18, 2)), 3, 5, 3)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (28, N'IMG_MSho_191612.png', N'Туфли из натуральной кожи', N'Модель выполнена из натуральной кожи, на резиновой подошве, поддеживает классический и деловой стиль образов. Производитель: Дом обуви «Берестов», г. Москва', N'Верх — натуральная кожа, подкладка — натуральная кожа, стелька — натуральная кожа, подошва — резина', CAST(25625.00 AS Decimal(18, 2)), 3, 5, 3)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (29, N'IMG_MB_174349.png', N'Ботинки мужские демисезонные', N'Ботинки из натуральной кожи темно-коричневого и черного цвета на шнурках. Производитель: Дом обуви «Берестов», г. Москва', N'Верх — натуральная кожа, подкладка — текстиль, подошва — искусственный материал', CAST(21500.00 AS Decimal(18, 2)), 3, 2, 2)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (30, N'IMG_MB_191200.png', N'Ботинки черные из натуральной кожи', N'Ботинки представляют баланс традиций и современности. Выполнены из натуральной кожи насыщенного черного цвета. Производитель: ЗАО «Кожевенные традиции», г. Вятка', N'Верх — натуральная кожа, подкладка — ворсин, стелька — ворсин, подошва — тунит', CAST(14567.00 AS Decimal(18, 2)), 3, 2, 7)
INSERT [dbo].[Product] ([ProductID], [Image], [ProductName], [Discription], [Compound], [Price], [CategoryID], [SubCategoryID], [ManufactureID]) VALUES (31, N'IMG_MB_191205.png', N'Ботинки зимние классические', N'Выбор на каждый день — натуральная кожа, натуральный мех. Производитель: Дом обуви «Барбари», г. Новороссийск ', N'Верх — натуральная кожа, подкладка — натуральный мех, стелька — натуральный мех, подошва — ТЭП', CAST(15670.00 AS Decimal(18, 2)), 3, 2, 2)
GO
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (1, CAST(18.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (2, CAST(19.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (3, CAST(20.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (4, CAST(21.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (5, CAST(22.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (6, CAST(23.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (7, CAST(24.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (8, CAST(25.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (9, CAST(26.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (10, CAST(27.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (11, CAST(28.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (12, CAST(29.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (13, CAST(30.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (14, CAST(31.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (15, CAST(32.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (16, CAST(33.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (17, CAST(34.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (18, CAST(35.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (19, CAST(36.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (20, CAST(36.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (21, CAST(37.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (22, CAST(37.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (23, CAST(38.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (24, CAST(38.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (25, CAST(39.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (26, CAST(39.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (27, CAST(40.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (28, CAST(40.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (29, CAST(41.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (30, CAST(41.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (31, CAST(42.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (32, CAST(42.5 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (33, CAST(43.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (34, CAST(44.0 AS Decimal(4, 1)), NULL)
INSERT [dbo].[Sizes] ([SizeID], [SizeValue], [SizeLabel]) VALUES (35, CAST(45.0 AS Decimal(4, 1)), NULL)
GO
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName]) VALUES (1, N'Босоножки')
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName]) VALUES (2, N'Ботинки')
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName]) VALUES (3, N'Кроссовки')
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName]) VALUES (4, N'Сапоги')
INSERT [dbo].[SubCategory] ([SubCategoryID], [SubCategoryName]) VALUES (5, N'Туфли')
GO
INSERT [dbo].[UserRole] ([UserID], [RoleName]) VALUES (1, N'Администратор')
INSERT [dbo].[UserRole] ([UserID], [RoleName]) VALUES (2, N'Менеджер')
INSERT [dbo].[UserRole] ([UserID], [RoleName]) VALUES (3, N'Авторизованный пользователь')
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [FK_Clients_UserRole] FOREIGN KEY([RoleID])
REFERENCES [dbo].[UserRole] ([UserID])
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [FK_Clients_UserRole]
GO
ALTER TABLE [dbo].[CommodityPosition]  WITH CHECK ADD  CONSTRAINT [FK_CommodityPosition_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[CommodityPosition] CHECK CONSTRAINT [FK_CommodityPosition_Product]
GO
ALTER TABLE [dbo].[CommodityPosition]  WITH CHECK ADD  CONSTRAINT [FK_CommodityPosition_Sizes] FOREIGN KEY([SizeID])
REFERENCES [dbo].[Sizes] ([SizeID])
GO
ALTER TABLE [dbo].[CommodityPosition] CHECK CONSTRAINT [FK_CommodityPosition_Sizes]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Clients]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_CommodityPosition] FOREIGN KEY([CommodityPositionID])
REFERENCES [dbo].[CommodityPosition] ([CommodityPositionID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_CommodityPosition]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Manufacture] FOREIGN KEY([ManufactureID])
REFERENCES [dbo].[Manufacture] ([ManufactureID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Manufacture]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_SubCategory] FOREIGN KEY([SubCategoryID])
REFERENCES [dbo].[SubCategory] ([SubCategoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_SubCategory]
GO
USE [master]
GO
ALTER DATABASE [MiracleShowTraining] SET  READ_WRITE
GO
