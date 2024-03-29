USE [master]
GO
/****** Object:  Database [TestCandidate]    Script Date: 8/6/2022 11:48:56 PM ******/
CREATE DATABASE [TestCandidate]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestCandidate', FILENAME = N'C:\Users\nonemee\TestCandidate.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestCandidate_log', FILENAME = N'C:\Users\nonemee\TestCandidate_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
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
ALTER DATABASE [TestCandidate] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestCandidate] SET QUERY_STORE = OFF
GO
USE [TestCandidate]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [TestCandidate]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 8/6/2022 11:48:56 PM ******/
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
/****** Object:  Table [dbo].[Order Details]    Script Date: 8/6/2022 11:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order Details](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/6/2022 11:48:56 PM ******/
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
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Orders] UNIQUE NONCLUSTERED 
(
	[OrderNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/6/2022 11:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
	[UnitsInStock] [smallint] NULL,
	[UnitsOnOrder] [smallint] NULL,
	[ReorderLevel] [smallint] NULL,
	[Discontinued] [bit] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RunningNumber]    Script Date: 8/6/2022 11:48:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_Quantity]  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Order Details] ADD  CONSTRAINT [DF_Order_Details_Discount]  DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Freight]  DEFAULT ((0)) FOR [Freight]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitPrice]  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitsInStock]  DEFAULT ((0)) FOR [UnitsInStock]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_UnitsOnOrder]  DEFAULT ((0)) FOR [UnitsOnOrder]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_ReorderLevel]  DEFAULT ((0)) FOR [ReorderLevel]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_Discontinued]  DEFAULT ((0)) FOR [Discontinued]
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
