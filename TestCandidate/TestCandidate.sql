USE [master]
GO
/****** Object:  Database [TestCandidate]    Script Date: 8/14/2018 3:48:12 PM ******/
CREATE DATABASE [TestCandidate]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RecruitmentTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RecruitmentTest.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RecruitmentTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RecruitmentTest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TestCandidate] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestCandidate].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestCandidate] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestCandidate] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestCandidate] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestCandidate] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestCandidate] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestCandidate] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestCandidate] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [TestCandidate] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestCandidate] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestCandidate] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestCandidate] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestCandidate] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestCandidate] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestCandidate] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestCandidate] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestCandidate] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestCandidate] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestCandidate] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestCandidate] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestCandidate] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestCandidate] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestCandidate] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestCandidate] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestCandidate] SET RECOVERY FULL 
GO
ALTER DATABASE [TestCandidate] SET  MULTI_USER 
GO
ALTER DATABASE [TestCandidate] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestCandidate] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestCandidate] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestCandidate] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TestCandidate', N'ON'
GO
USE [TestCandidate]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 8/14/2018 3:48:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order Details]    Script Date: 8/14/2018 3:48:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)),
	[Quantity] [smallint] NOT NULL CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)),
	[Discount] [real] NOT NULL CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)),
 CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/14/2018 3:48:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[CustomerID] [nchar](5) NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[Freight] [money] NULL CONSTRAINT [DF_Orders_Freight]  DEFAULT ((0)),
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/14/2018 3:48:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)),
	[UnitsInStock] [smallint] NULL CONSTRAINT [DF_Products_UnitsInStock]  DEFAULT ((0)),
	[UnitsOnOrder] [smallint] NULL CONSTRAINT [DF_Products_UnitsOnOrder]  DEFAULT ((0)),
	[ReorderLevel] [smallint] NULL CONSTRAINT [DF_Products_ReorderLevel]  DEFAULT ((0)),
	[Discontinued] [bit] NOT NULL CONSTRAINT [DF_Products_Discontinued]  DEFAULT ((0)),
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RunningNumber]    Script Date: 8/14/2018 3:48:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RunningNumber](
	[Year] [int] NOT NULL,
	[RunningMonth] [int] NOT NULL,
	[Prefix] [varchar](10) NULL,
	[CurrentNo] [int] NULL,
 CONSTRAINT [PK_RunningNumber] PRIMARY KEY CLUSTERED 
(
	[Year] ASC,
	[RunningMonth] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'IGLO ', N'IGLO', N'Iglo', N'Sales Representative', N'Jakarta', N'Jakarta', N'DKI', N'123123', N'Indonesia', N'839210', N'02391')
INSERT [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (1, 1, 200.0000, 100, 0)
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrderNumber], [CustomerID], [OrderDate], [RequiredDate], [ShippedDate], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (1, N'ODR/18/08/0001', N'IGLO ', CAST(N'2018-08-14 00:00:00.000' AS DateTime), CAST(N'2018-08-20 00:00:00.000' AS DateTime), CAST(N'2018-08-17 00:00:00.000' AS DateTime), 314.0000, N'Iglo', N'Jakarta', N'Jakarta', N'DKI', N'123123', N'Indonesia')
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (1, N'Mac Pro', N'1', 200.0000, 1000, 100, 1, 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
INSERT [dbo].[RunningNumber] ([Year], [RunningMonth], [Prefix], [CurrentNo]) VALUES (2018, 8, N'ODR', 1)
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Orders]    Script Date: 8/14/2018 3:48:12 PM ******/
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [IX_Orders] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Orders]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [FK_Order_Details_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH NOCHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Discount] CHECK  (([Discount]>=(0) AND [Discount]<=(1)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Discount]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Order Details]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Order Details] CHECK CONSTRAINT [CK_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_Products_UnitPrice] CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_UnitPrice]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_ReorderLevel] CHECK  (([ReorderLevel]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_ReorderLevel]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsInStock] CHECK  (([UnitsInStock]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsInStock]
GO
ALTER TABLE [dbo].[Products]  WITH NOCHECK ADD  CONSTRAINT [CK_UnitsOnOrder] CHECK  (([UnitsOnOrder]>=(0)))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_UnitsOnOrder]
GO
USE [master]
GO
ALTER DATABASE [TestCandidate] SET  READ_WRITE 
GO
