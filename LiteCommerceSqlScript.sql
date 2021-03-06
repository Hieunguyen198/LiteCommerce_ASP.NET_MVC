USE [LiteCommerce]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/22/2021 3:07:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NULL,
	[Description] [nvarchar](200) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](50) NULL,
	[QuantityPerUnit] [int] NULL,
	[Descriptions] [nvarchar](100) NULL,
	[PhotoPath] [nvarchar](50) NULL,
	[UnitPrice] [money] NULL,
	[CategoryID] [int] NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Product]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Product]
AS
SELECT        dbo.Categories.CategoryName, dbo.Products.ProductID, dbo.Products.ProductName, dbo.Products.QuantityPerUnit, dbo.Products.Descriptions, dbo.Products.PhotoPath, dbo.Products.UnitPrice, dbo.Products.CategoryID
FROM            dbo.Categories INNER JOIN
                         dbo.Products ON dbo.Categories.CategoryID = dbo.Products.CategoryID
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [nchar](10) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactTitle] [nvarchar](50) NULL,
	[CompanyName] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[HireDate] [date] NULL,
	[Phone] [nvarchar](50) NULL,
	[PhotoPath] [nvarchar](50) NULL,
	[GroupName] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[HomePhone] [nvarchar](50) NULL,
	[Notes] [nvarchar](max) NULL,
	[Country] [nvarchar](50) NULL,
	[Password] [nvarchar](100) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[CustomerID] [nchar](10) NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Orders]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Orders]
AS
SELECT        dbo.Orders.OrderID, dbo.Orders.OrderDate, dbo.Orders.CustomerID, dbo.Orders.EmployeeID, dbo.Customers.ContactName, dbo.Employees.FirstName, dbo.Employees.LastName, dbo.Orders.Status
FROM            dbo.Orders INNER JOIN
                         dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID INNER JOIN
                         dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [nchar](10) NULL,
	[Discount] [float] NULL,
	[UnitPrice] [money] NULL,
	[ProductID] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_OrderDetails]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_OrderDetails]
AS
SELECT        dbo.Products.ProductID, dbo.Products.ProductName, dbo.OrderDetails.OrderID, dbo.OrderDetails.Discount, dbo.OrderDetails.Quantity, dbo.OrderDetails.UnitPrice
FROM            dbo.Products INNER JOIN
                         dbo.OrderDetails ON dbo.Products.ProductID = dbo.OrderDetails.ProductID
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryName] [varchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1, N'Hieuapi', N'HieuApi')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (2, N'Clother', N'Garment Meterial')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (4, N'Smart phone', N'Product about smart phone')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1019, N'Gear113', N'Something')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1121, N'Hieu12', N'Hieu')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1122, N'Hieu1234', N'Hieu')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1133, N'Hieu', N'Cao')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1135, N'Dung', N'Hand some')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1136, N'Hieu', N'addbyapi')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1137, N'Hieuapi', N'HieuApi')
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description]) VALUES (1140, N'Hieu', N'addbyid2')
SET IDENTITY_INSERT [dbo].[Categories] OFF
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Afghanistan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Aland Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Albania')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Algeria')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'American Samoa')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Andorra')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Angola')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Anguilla')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Antarctica')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Antigua and Barbuda')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Argentina')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Armenia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Aruba')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Australia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Austria')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Azerbaijan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bahamas')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bahrain')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bangladesh')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Barbados')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belarus')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belgium')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Belize')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Benin')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bermuda')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bhutan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bolivia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bonaire, Sint Eustatius and Saba')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bosnia and Herzegovina')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Botswana')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bouvet Island')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Brazil')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'British Indian Ocean Territory')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Brunei')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Bulgaria')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Burkina Faso')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Burundi')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cambodia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cameroon')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Canada')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cape Verde')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cayman Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Central African Republic')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Chad')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Chile')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'China')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Christmas Island')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cocos (Keeling) Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Colombia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Comoros')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Congo')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cook Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Costa Rica')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ivory Coast')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Croatia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cuba')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Curacao')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Cyprus')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Czech Republic')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Democratic Republic of the Congo')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Denmark')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Djibouti')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Dominica')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Dominican Republic')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ecuador')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Egypt')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'El Salvador')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Equatorial Guinea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Eritrea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Estonia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ethiopia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Falkland Islands (Malvinas)')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Faroe Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Fiji')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Finland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'France')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'French Guiana')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'French Polynesia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'French Southern Territories')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gabon')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gambia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Georgia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Germany')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ghana')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Gibraltar')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Greece')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Greenland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Grenada')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guadaloupe')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guam')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guatemala')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guernsey')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guinea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guinea-Bissau')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Guyana')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Haiti')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Heard Island and McDonald Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Honduras')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Hong Kong')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Hungary')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iceland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'India')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Indonesia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iran')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Iraq')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ireland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Isle of Man')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Israel')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Italy')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Jamaica')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Japan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Jersey')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Jordan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kazakhstan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kenya')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kiribati')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kosovo')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kuwait')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Kyrgyzstan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Laos')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Latvia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Lebanon')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Lesotho')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Liberia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Libya')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Liechtenstein')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Lithuania')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Luxembourg')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Macao')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Macedonia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Madagascar')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Malawi')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Malaysia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Maldives')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mali')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Malta')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Marshall Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Martinique')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mauritania')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mauritius')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mayotte')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mexico')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Micronesia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Moldava')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Monaco')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mongolia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Montenegro')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Montserrat')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Morocco')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Mozambique')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Myanmar (Burma)')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Namibia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Nauru')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Nepal')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Netherlands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'New Caledonia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'New Zealand')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Nicaragua')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Niger')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Nigeria')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Niue')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Norfolk Island')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'North Korea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Northern Mariana Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Norway')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Oman')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Pakistan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Palau')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Palestine')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Panama')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Papua New Guinea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Paraguay')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Peru')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Phillipines')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Pitcairn')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Poland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Portugal')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Puerto Rico')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Qatar')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Reunion')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Romania')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Russia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Rwanda')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Barthelemy')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Helena')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Kitts and Nevis')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Lucia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Martin')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Pierre and Miquelon')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saint Vincent and the Grenadines')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Samoa')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'San Marino')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sao Tome and Principe')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Saudi Arabia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Senegal')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Serbia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Seychelles')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sierra Leone')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Singapore')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sint Maarten')
GO
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Slovakia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Slovenia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Solomon Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Somalia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'South Africa')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'South Georgia and the South Sandwich Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'South Korea')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'South Sudan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Spain')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sri Lanka')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sudan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Suriname')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Svalbard and Jan Mayen')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Swaziland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Sweden')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Switzerland')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Syria')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Taiwan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tajikistan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tanzania')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Thailand')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Timor-Leste (East Timor)')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Togo')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tokelau')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tonga')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Trinidad and Tobago')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tunisia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Turkey')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Turkmenistan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Turks and Caicos Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Tuvalu')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Uganda')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Ukraine')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'United Arab Emirates')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'United Kingdom')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'United States')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'United States Minor Outlying Islands')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Uruguay')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Uzbekistan')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Vanuatu')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Vatican City')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Venezuela')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Vietnam')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Virgin Islands, British')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Virgin Islands, US')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Wallis and Futuna')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Western Sahara')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Yemen')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Zambia')
INSERT [dbo].[Countries] ([CountryName]) VALUES (N'Zimbabwe')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'45443     ', N'Hieu', N'Management', N'add by api 1', N'Hue', N'012215454', N'VietNam', N'155454', N'An Duong Vuong')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'45445     ', N'Hieu', N'Management', N'add by api 1', N'Hue', N'012215454', N'VietNam', N'155454', N'An Duong Vuong')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'ADADD     ', N'Nam Tran', N'DEV', N'AIT', N'Hue', N'1521521545', N'Slovenia', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'ADADK     ', N'Hoang Ha', N'DEV', N'AIT', N'Ha Noi', N'1521521545', N'Vietnam', N'12312312', N'Ha Noi')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'ADADQ     ', N'Hoang Ha', N'DEV', N'AIT', N'Ha Noi', N'1521521545', N'Vietnam', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'ADSAS     ', N'Hoang Nguyen', N'DEV', N'AIT', N'Ho Chi Minh', N'123123123', N'Vietnam', N'121354532', N'Quang Ngai')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'C01       ', N'Thuan Nguyen', N'Sale', N'AIT', N'Ho Chi Minh', N'01521521545', N'Panama', N'1312312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'C02       ', N'Nhan Nguyen', N'Sale Managerment', N'AIT', N'Ha Noi', N'0215215655', N'Algeria', N'12312321', N'Thua Thien Hue')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'C03       ', N'Dien Nguyen', N'Sale', N'AIT', N'Da Nang', N'1564656544', N'Sweden', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'GSAAD     ', N'Long Nhan', N'DEV', N'AIT', N'Hue', N'1521521545', N'Vietnam', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'GSADA     ', N'Hieu Nguyen', N'Management', N'AIT', N'Ho Chi Minh', N'1521521545', N'Vietnam', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'GSADD     ', N'Hieu Nguyen', N'DEV', N'AIT', N'Ha Noi', N'1521521545', N'Vietnam', N'12312312', N'Quang Nam')
INSERT [dbo].[Customers] ([CustomerID], [ContactName], [ContactTitle], [CompanyName], [City], [Phone], [Country], [Fax], [Address]) VALUES (N'GSADF     ', N'Hieu Nguyen Van', N'DEV', N'AIT', N'Da Nang', N'1521521545', N'Vietnam', N'12312312', N'Quang Nam')
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (1, N'Hieu', N'Nguyen', N'Administrator', CAST(N'1998-05-17' AS Date), N'hieu@gmail.com', N'Hue', CAST(N'2021-03-01' AS Date), N'0969861254', N'Images/Cat5.png', N'administrator', N'Ha Noi', N'2021023021', N'eque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.', N'Benin', N'250cf8b51c773f3f8dc8b4be867a9a02')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (2, N'Thuan ', N'Nguyen', N'Catalog Management', CAST(N'1998-03-02' AS Date), N'thuan@gmail.com', N'Quang Binh', CAST(N'2021-01-03' AS Date), N'6548878778', N'Images/Cat2.jpg', N'Catalog Management', N'Da Nang', N'4242452542', N'hieu', N'Cameroon', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (3, N'Hoang ', N'Le', N'Order Management', CAST(N'1997-02-04' AS Date), N'hoang@gmail.com', N'Da Nang', CAST(N'2021-01-03' AS Date), N'5241254545', N'Images/Cat5.png', N'Order Management', N'Ha Noi', N'102402424', N'eque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..." "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."', N'Brazil', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (4, N'Nam', N'Tran', N'Employee Management', CAST(N'1994-07-12' AS Date), N'Nam@gmail.com', N'Quang Nam', CAST(N'2021-01-03' AS Date), N'4152545454', N'Images/Cat3.jfif', N'Employee Management', N'Hue', N'242453245', N'eque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..." "There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."', N'Bangladesh', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (5, N'Long ', N'Duong ', N'staff', CAST(N'1997-12-02' AS Date), N'Long@gmail.com', N'Hue', CAST(N'2021-01-03' AS Date), N'3232032323', N'Images/Cat4.jpg', N'staff', N'Hue', N'244255547', N'eque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..." "Ther', N'Vietnam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (6, N'Hieu', N'Nguyen', N'staff', CAST(N'1998-05-17' AS Date), N'hieu1@gmail.com', N'Hue', CAST(N'2021-03-01' AS Date), N'0212121215', N'Images/Cat1.jpg', N'staff', N'Hue', N'121154564', N'Handsome', N'United States', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (7, N'Nhan', N'Nam', N'staff', CAST(N'2014-03-05' AS Date), N'nhan@gmail.com', N'Thua Thien Hue', CAST(N'2021-01-03' AS Date), N'0212121215', N'Images/Cat3.jfif', N'staff', N'Hue', N'02154154', N'Hand Some', N'Hue', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (9, N'Long', N'Hoang', N'staff', CAST(N'2001-05-07' AS Date), N'long1@gmail.com', N'Thua Thien Hue', CAST(N'2021-01-12' AS Date), N'0212121215', N'Images/Cat5.png', N'staff', N'HN', N'85456456', N'alo alo 123456', N'HN', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (10, N'Nhan', N'Le', N'staff', CAST(N'2021-02-12' AS Date), N'hieu123@gmail.com', N'Quang Nam', CAST(N'2021-01-03' AS Date), N'4152545454', N'Images/Cat2.jpg', N'staff', N'HN', N'85456456', N'My Name is Nhan', N'HN', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (11, N'Nhan', N'Le', N'staff', CAST(N'2021-02-12' AS Date), N'hieu1234@gmail.com', N'Quang Nam', CAST(N'2021-01-03' AS Date), N'5241254545', N'Images/Cat2.jpg', N'staff', N'HN', N'85456456', N'My Name is Nhan', N'HN', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (12, N'Thuan', N'Nguyen', N'staff', CAST(N'2021-03-02' AS Date), N'abc@gmail.com', N'Quang Nam', CAST(N'2021-03-02' AS Date), N'6548878778', N'Images/Cat5.png', N'staff', N'Ho Chi Minh', N'1521521545', N'125454', N'Vietnam', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Employees] ([EmployeeID], [FirstName], [LastName], [Title], [BirthDate], [Email], [Address], [HireDate], [Phone], [PhotoPath], [GroupName], [City], [HomePhone], [Notes], [Country], [Password]) VALUES (13, N'Thuan', N'Nguyen', N'staff', CAST(N'2021-02-02' AS Date), N'abc1@gmail.com', N'Quang Nam', CAST(N'2021-02-02' AS Date), N'0969861254', N'Images/Cat4.jpg', N'staff', N'Ho Chi Minh', N'1521521545', N'123213', N'Vietnam', N'e10adc3949ba59abbe56e057f20f883e')
SET IDENTITY_INSERT [dbo].[Employees] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (2, 1, N'21        ', 0.5, 20.0000, 2)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (4, 1, N'20        ', 0.1, 50.0000, 2)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (5, 2, N'10        ', 0.2, 100.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (7, 3, N'15        ', 0, 50.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (10, 4, N'5         ', 0.1, 300.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (11, 1, N'4         ', 0, 30.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (13, 8, N'20        ', 0, 50.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (14, 9, N'20        ', 0.1, 100.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (16, 8, N'5         ', 0, 30.0000, 5)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (17, 8, N'24        ', 0.2, 60.0000, 5)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (18, 8, N'1         ', 0.05, 50.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (19, 9, N'30        ', 0, 40.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (20, 10, N'4         ', 0, 30.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (22, 10, N'40        ', 0.3, 50.0000, 8)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (24, 15, N'10        ', 0.05, 60.0000, 12)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (25, 13, N'15        ', 0.1, 10.0000, 13)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (26, 13, N'4         ', 0, 70.0000, 15)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (27, 15, N'3         ', 0, 50.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (28, 20, N'20        ', 0.2, 40.0000, 16)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (29, 20, N'25        ', 0, 25.0000, 15)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (30, 21, N'7         ', 0.2, 80.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (31, 21, N'10        ', 0, 50.0000, 12)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (32, 21, N'30        ', 0.1, 60.0000, 16)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (33, 24, N'15        ', 0, 70.0000, 12)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (34, 24, N'60        ', 0.5, 100.0000, 16)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (35, 24, N'5         ', 0, 32.0000, 10)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (36, 25, N'6         ', 0.3, 45.0000, 10)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (37, 25, N'15        ', 0, 36.0000, 15)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (38, 26, N'10        ', 0.1, 40.0000, 2)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (39, 26, N'7         ', 0.2, 28.0000, 3)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (40, 27, N'4         ', 0.6, 47.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (42, 27, N'9         ', 0.7, 65.0000, 10)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (43, 27, N'17        ', 0.4, 78.0000, 15)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (44, 28, N'17        ', 0, 24.0000, 12)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (46, 28, N'10        ', 0, 30.0000, 6)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (47, 29, N'5         ', 0, 35.0000, 9)
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [Quantity], [Discount], [UnitPrice], [ProductID]) VALUES (48, 29, N'17        ', 0.2, 48.0000, 9)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (1, CAST(N'2021-03-08' AS Date), N'C01       ', 1, 1)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (2, CAST(N'2019-03-07' AS Date), N'C01       ', 1, 1)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (3, CAST(N'2021-05-03' AS Date), N'C02       ', 2, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (4, CAST(N'2021-04-01' AS Date), N'C03       ', 3, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (8, CAST(N'2020-03-02' AS Date), N'C01       ', 2, 1)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (9, CAST(N'2020-02-01' AS Date), N'C03       ', 1, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (10, CAST(N'2020-01-01' AS Date), N'C02       ', 2, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (13, CAST(N'2021-02-06' AS Date), N'ADADD     ', 7, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (15, CAST(N'2019-02-06' AS Date), N'ADADK     ', 6, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (20, CAST(N'2021-01-06' AS Date), N'GSAAD     ', 11, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (21, CAST(N'2021-10-06' AS Date), N'GSADF     ', 9, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (24, CAST(N'2021-11-06' AS Date), N'GSADF     ', 11, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (25, CAST(N'2021-12-01' AS Date), N'C02       ', 2, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (26, CAST(N'2021-06-06' AS Date), N'C01       ', 7, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (27, CAST(N'2021-07-17' AS Date), N'ADADD     ', 2, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (28, CAST(N'2019-12-10' AS Date), N'C03       ', 3, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (29, CAST(N'2021-08-20' AS Date), N'C02       ', 9, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (34, CAST(N'2021-08-20' AS Date), N'C02       ', 3, 0)
INSERT [dbo].[Orders] ([OrderID], [OrderDate], [CustomerID], [EmployeeID], [Status]) VALUES (35, CAST(N'2021-08-20' AS Date), N'C03       ', 9, 0)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (2, N'Pen Italya', 10, N'stationery', N'Images/Cat1.jpg', 5.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (3, N'Ruler', 100, N'stationery', N'Images/Cat1.jpg', 10.0000, 1019)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (5, N'Cloth', 20, N'grament accessories', N'Images/Cat2.jpg', 10.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (6, N'Thread', 500, N'grament accessories', N'Images/Cat5.png', 20.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (8, N'IPhone', 100, N'Phone', N'Images/Cat4.jpg', 20.0000, 4)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (9, N'SamSung', 200, N'Phone', N'Images/Cat4.jpg', 20.0000, 4)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (10, N'LG', 50, N'Phone', N'Images/Cat2.jpg', 50.0000, 4)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (12, N'Laptop', 100, N'stationery', N'Images/Cat2.jpg', 50.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (13, N'Pc', 100, N'stationery', N'Images/Cat4.jpg', 20.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (15, N'Pencel', 100, N'stationery', N'Images/Cat2.jpg', 41.0000, 2)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (16, N'Bag', 100, N'stationery', N'Images/Cat3.jfif', 21.0000, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [QuantityPerUnit], [Descriptions], [PhotoPath], [UnitPrice], [CategoryID]) VALUES (28, N'Cat', 100, N'Meo meo meo', N'Images/Cat2.jpg', 50.0000, 1140)
SET IDENTITY_INSERT [dbo].[Products] OFF
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Add]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Proc [dbo].[Proc_Category_Add]
(
	@CategoryName nvarchar(50),
	@Description  nvarchar(100)
)
as
Begin
INSERT INTO Categories( CategoryName, Description)
VALUES
            (@CategoryName,@Description);
SELECT @@IDENTITY;
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Count]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROC [dbo].[Proc_Category_Count]
(
	@searchValue varchar(50)
)
AS
BEGIN
	SELECT count(*)
    FROM Categories
    WHERE    (@searchValue=N'')
           OR(CategoryName like @searchValue)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Delete_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Proc_Category_Delete_By_ID]
(
	@CategoryID int
)
as
Begin
DELETE 
FROM  Categories
WHERE (CategoryID = @CategoryID)
AND(CategoryID NOT IN(SELECT CategoryID FROM Products))
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Edit]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Proc_Category_Edit]
(
	@CategoryName nvarchar(50),
	@Description  nvarchar(100),
	@CategoryID int
)
as
Begin
UPDATE Categories
SET  CategoryName = @CategoryName,Description = @Description
WHERE CategoryID = @CategoryID
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Get_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Proc_Category_Get_By_ID]
(
	@CategoryID int
)
as
Begin
SELECT * 
FROM Categories 
WHERE CategoryID = @CategoryID
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_Category_List]
(
	@searchValue nvarchar(50)
)as
Begin
SELECT *
FROM Categories
WHERE    (@searchValue = N'')
      OR (CategoryName like @searchValue)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Country_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Country_List]
AS
BEGIN
	SELECT CountryName FROM Countries
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Add]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_Add]
(
	 @CustomerID	nchar(50),
	 @CompanyName   nvarchar(100),
	 @ContactName   nvarchar(100),
	 @Address		nvarchar(200),
	 @City			nvarchar(100),
	 @Country		nvarchar(100),
	 @ContactTitle  nvarchar(100),
	 @Phone			nvarchar(50),
	 @Fax			nvarchar(50)
)
AS
BEGIN
	INSERT INTO Customers
                (
                  CustomerID,
	              CompanyName,
	              ContactName,
	              ContactTitle,
	              Address,
	              City,
	              Country,
	              Phone,
	              Fax
                 )
           VALUES
                 (
                   @CustomerID,    
	               @CompanyName,
	               @ContactName,
	               @ContactTitle,
	               @Address,
	               @City,
	               @Country,
	               @Phone,
	               @Fax
                 );
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Count]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_Count]
(
	 @searchValue	nvarchar(100)
)
AS
BEGIN
	SELECT count(*)
    FROM Customers
	WHERE  (@searchValue=N'')
          OR(ContactName like @searchValue)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Delete]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_Delete]
(
	 @CustomerID	nchar(50)
)
AS
BEGIN
	DELETE  
    FROM Customers 
    WHERE   (CustomerID = @CustomerID)
         AND(CustomerID NOT IN (SELECT CustomerID FROM Orders))
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Edit]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_Edit]
(
	 @CustomerID		nchar(50),
	 @CompanyName		nvarchar(50),
	 @ContactName		nvarchar(50),
	 @ContactTitle		nvarchar(50),
	 @Address			nvarchar(50),
	 @City				nvarchar(50),
	 @Country			nvarchar(50),
	 @Phone				nvarchar(50),
	 @Fax				nvarchar(50)
)
AS
BEGIN
		UPDATE Customers
        SET 
               CustomerID = @CustomerID,
               CompanyName =  @CompanyName,
	           ContactName =  @ContactName,
	           ContactTitle = @ContactTitle,
	           Address =  @Address,
	           City=  @City,
	           Country = @Country,
	           Phone = @Phone,
	           Fax = @Fax
       WHERE CustomerID = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Get_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_Get_By_ID]
(
	 @CustomerID	nchar(50)
)
AS
BEGIN
	SELECT * 
    FROM Customers 
    WHERE CustomerID = @CustomerID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Customer_List]
(
	 @searchValue	nvarchar(100),
	 @page			int,
	 @pageSize		int
)
AS
BEGIN
	SELECT *
    FROM(
         SELECT *,ROW_NUMBER() OVER(ORDER BY CustomerID) AS RowNumber
         FROM Customers
         WHERE	 (@searchValue=N'')
               OR(ContactName like @searchValue)
         ) AS T
    WHERE t.RowNumber BETWEEN (@page*@pageSize)-@pageSize+1 AND @page*@pageSize
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_Discount_By_Year]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Dashboard_Discount_By_Year]
(
	@Year int
)
AS
BEGIN
	SELECT Year, COALESCE([1] , 0) AS January, COALESCE([2] , 0) AS February, COALESCE([3] , 0) AS March, COALESCE([4] , 0) AS April, 
				 COALESCE([5] , 0) AS May, COALESCE([6] , 0) AS June, COALESCE([7] , 0) AS July, COALESCE([8] , 0) AS August, 
				 COALESCE([9] , 0) AS September, COALESCE([10], 0) AS October, COALESCE([11], 0) AS November, COALESCE([12], 0) AS December 
    FROM (
			SELECT YEAR(OrderDate) as Year  , MONTH(OrderDate) AS Month ,CT.Quantity*CT.UnitPrice*CT.Discount AS ToTal FROM Orders HD JOIN OrderDetails CT ON CT.OrderID = HD.OrderID WHERE YEAR(HD.OrderDate) = @Year)  
			TEMP PIVOT( SUM(ToTal) FOR Month IN ([1], [2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PivotTable            
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_OrderQuantity_By_Year]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Dashboard_OrderQuantity_By_Year]
(
	@Year int
)
AS
BEGIN
	SELECT Year, COALESCE([1] , 0) AS January, COALESCE([2] , 0) AS February, COALESCE([3] , 0) AS March, COALESCE([4] , 0) AS April, 
				 COALESCE([5] , 0) AS May, COALESCE([6] , 0) AS June, COALESCE([7] , 0) AS July, COALESCE([8] , 0) AS August,
				 COALESCE([9] , 0) AS September, COALESCE([10], 0) AS October, COALESCE([11], 0) AS November, COALESCE([12], 0) AS December 
    FROM   
   (SELECT YEAR(OrderDate) as Year  , MONTH(OrderDate) AS Month   , HD.OrderID    FROM Orders HD	WHERE YEAR(OrderDate) = @Year)  TEMP PIVOT(  COUNT(OrderID)    FOR Month IN ([1], [2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PivotTable
                
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_Revenue_By_Year]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Dashboard_Revenue_By_Year]
(
	@Year int
)
AS
BEGIN
	SELECT Year, COALESCE([1] , 0) AS January, COALESCE([2] , 0) AS February, COALESCE([3] , 0) AS March, COALESCE([4] , 0) AS April, 
				 COALESCE([5] , 0) AS May, COALESCE([6] , 0) AS June, COALESCE([7] , 0) AS July, COALESCE([8] , 0) AS August, 
				 COALESCE([9] , 0) AS September, COALESCE([10], 0) AS October, COALESCE([11], 0) AS November, COALESCE([12], 0) AS December 
    FROM (
			SELECT YEAR(OrderDate) as Year  , MONTH(OrderDate) AS Month ,(CT.Quantity*CT.UnitPrice)-(CT.Quantity*CT.UnitPrice)*CT.Discount AS ToTal FROM Orders HD JOIN OrderDetails CT ON CT.OrderID = HD.OrderID WHERE YEAR(HD.OrderDate) = @Year)  
			TEMP PIVOT( SUM(ToTal) FOR Month IN ([1], [2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) AS PivotTable            
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Add]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Add]
(
	 @LastName		nvarchar(100),
     @FirstName		nvarchar(100),
     @Title			nvarchar(100),
     @BirthDate	    date,
	 @HireDate		date ,
     @Email			nvarchar(100),
     @Address		nvarchar(100),
     @City			nvarchar(50),
     @Country		nvarchar(50),
     @HomePhone		nvarchar(100),
     @Notes			nvarchar(100),
     @PhotoPath		nvarchar(100),
     @Password		nvarchar(MAX)
)
AS
BEGIN
	INSERT INTO Employees(
						  LastName,
                          FirstName,
                          Title,
                          BirthDate,
                          HireDate,
                          Email,
                          Address,
                          City,
                          Country,
                          HomePhone,
                          Notes,
                          PhotoPath,
                          Password
                          )
   VALUES
                          (
                          @LastName,
                          @FirstName,
                          @Title,
                          @BirthDate,
                          @HireDate,
                          @Email,
                          @Address,
                          @City,
                          @Country,
                          @HomePhone,
                          @Notes,
                          @PhotoPath,
                          @Password
                          );
   SELECT @@IDENTITY;
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Count]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Count]
(
	 @searchValue		nvarchar(50),
     @searchCountry		nvarchar(50)
)
AS
BEGIN
	SELECT COUNT(*)
    FROM Employees
    WHERE		((@searchValue=N'')
          OR	(FirstName LIKE @searchValue) OR (LastName LIKE @searchValue))
          AND	((Country LIKE @searchCountry) OR(@searchCountry=N''))
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Delete_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Delete_By_ID]
(
	 @employeeID   int
)
AS
BEGIN
	DELETE FROM Employees
    WHERE	  (EmployeeID = @employeeID)
          AND (EmployeeID NOT IN (SELECT EmployeeID FROM Orders) ) 
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Edit]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Edit]
(
		 @LastName		nvarchar(100),
		 @FirstName		nvarchar(100),
		 @Title			nvarchar(100),
		 @BirthDate	    date,
		 @HireDate		date ,
		 @Email			nvarchar(100),
		 @Address		nvarchar(100),
		 @City			nvarchar(50),
		 @Country		nvarchar(50),
		 @HomePhone		nvarchar(100),
		 @Notes			nvarchar(100),
		 @PhotoPath		nvarchar(100),
		 @EmployeeID	int
)
AS
BEGIN
	UPDATE Employees
    SET 
           LastName = @LastName,
           FirstName = @FirstName,
           Title = @Title,
           BirthDate = @BirthDate,
           HireDate = @HireDate,
           Email  = @Email,
           Address = @Address,
           City = @City,
           Country = @Country,
           HomePhone = @HomePhone,
           Notes = @Notes,
           PhotoPath = @PhotoPath
    WHERE EmployeeID = @EmployeeID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Get_By_Email]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Get_By_Email]
(
	@Email nvarchar(100)
)
AS
BEGIN
	SELECT *
    FROM    Employees 
	WHERE	Email = @Email
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Get_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_Get_By_ID]
(
	 @employeeID int
)
AS
BEGIN
	SELECT * 
	FROM Employees 
	WHERE EmployeeID = @employeeID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Employee_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Employee_List]
(
	 @searchValue   nvarchar(50),
	 @searchCountry nvarchar(50),
	 @page			int,
	 @pageSize		int
)
AS
BEGIN
	SELECT *
    FROM (
			SELECT *,ROW_NUMBER() OVER(ORDER BY EmployeeID) AS RowNumber
            FROM Employees
            WHERE ((@searchValue=N'')
                   OR (FirstName LIKE @searchValue) OR (LastName LIKE @searchValue))
                   AND ((Country LIKE @searchCountry) OR (@searchCountry=N''))
					) AS T
   WHERE t.RowNumber BETWEEN (@page*@pageSize)-@pageSize+1 AND @page*@pageSize
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_Approval]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_Approval]
(
		@OrderID int
)
AS
BEGIN
	UPDATE Orders
	SET Status =  (CASE  
			WHEN (Status = 'True') THEN 'False' 
			WHEN (Status = 'False') THEN 'True' END)
	WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_By_ID]
(
		@id int
)
AS
BEGIN
	SELECT *
    FROM Orders
    WHERE    OrderID=@id
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_Count]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_Count]
(
		@SearchValue nvarchar(50)
)
AS
BEGIN
	SELECT COUNT(*)
    FROM View_Orders
    WHERE      (@searchValue=N'')
           OR  (FirstName like @searchValue) OR (LastName like @searchValue)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_Delete]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_Delete]
(
	@OrderID int
)
AS
BEGIN
	DELETE 
    FROM     Orders
    WHERE   (OrderID = @OrderID)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_List]
(
		@SearchValue nvarchar(50),
		@Page			int,
		@PageSize		int
)
AS
BEGIN
	SELECT *
    FROM (
            SELECT *,ROW_NUMBER() over(order by OrderID) AS RowNumber
            FROM View_Orders
            WHERE (@searchValue=N'')
                    OR(FirstName like @searchValue) OR (LastName like @searchValue)
         ) AS T
    WHERE  (t.RowNumber between (@page*@pageSize)-@pageSize+1 and @page*@pageSize)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_OrderDetail]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_OrderDetail]
AS
BEGIN
	SELECT OrderID,ProductID,ProductName,Quantity,UnitPrice,Discount
    FROM View_OrderDetails
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Order_OrderDetail_By_OrderID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Order_OrderDetail_By_OrderID]
(
		@OrderID int
)
AS
BEGIN
	SELECT OrderID,ProductID,ProductName,Quantity,UnitPrice,Discount
    FROM View_OrderDetails
	WHERE OrderID = @OrderID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_Add]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Proc_Product_Add]
(
	 @ProductName nvarchar(100),
	 @CategoryID int,
	 @QuantityPerUnit nvarchar(100),
	 @UnitPrice float,
	 @Descriptions nvarchar(100),
	 @PhotoPath nvarchar(100)
)
as
Begin
INSERT INTO Products
            (
              ProductName,
              CategoryID,
              QuantityPerUnit,
              UnitPrice,
              Descriptions,
              PhotoPath
              )
VALUES
             (
	           @ProductName,
	           @CategoryID,
	           @QuantityPerUnit,
	           @UnitPrice,
	           @Descriptions,
	           @PhotoPath
             );
SELECT @@IDENTITY;
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_Count]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[Proc_Product_Count]
(
	 @searchValue nvarchar(100),
	 @searchCategory nvarchar(100),
	 @searchPrice nvarchar(50)
)
as
Begin
SELECT count(*)
FROM View_Product
WHERE       ((@searchValue=N'')
       OR   (ProductName like @searchValue)) 
       AND  ((CategoryID like @searchCategory) OR (@searchCategory=N''))
       AND  ((UnitPrice >= @searchPrice)	   OR  (@searchPrice=N''))
end
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_Delete]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_Product_Delete]
(
	 @ProductID int
)
AS
BEGIN
DELETE 
FROM Products 
WHERE    (ProductID = @ProductID)
      AND(ProductID NOT IN(SELECT ProductID FROM OrderDetails))
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_Edit]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_Product_Edit]
(
	 @ProductName nvarchar(100),
	 @CategoryID int,
	 @QuantityPerUnit nvarchar(100),
	 @UnitPrice float,
	 @Descriptions nvarchar(100),
	 @PhotoPath nvarchar(100),
	 @ProductID int
)
AS
BEGIN
	UPDATE Products
    SET    ProductName =  @ProductName,
	       CategoryID = @CategoryID,
	       QuantityPerUnit =  @QuantityPerUnit,
	       UnitPrice=  @UnitPrice,
	       Descriptions = @Descriptions,
	       PhotoPath = @PhotoPath
    WHERE  ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_Get_By_ID]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_Product_Get_By_ID]
(
	 @ProductID int
)
AS
BEGIN
	SELECT * 
	FROM View_Product 
	WHERE ProductID = @ProductID
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_List]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[Proc_Product_List]
(
	 @searchValue nvarchar(100),
	 @searchCategory nvarchar(100),
	 @searchPrice nvarchar(50),
	 @page	int,
	 @pageSize int
)
AS
BEGIN
	SELECT *
    FROM
          (SELECT *, ROW_NUMBER() OVER (order by ProductID) AS RowNumber
           FROM    View_Product
           WHERE       ((@searchValue=N'')
                    OR   (ProductName like @searchValue)) 
                    AND  ((CategoryID like @searchCategory) OR (@searchCategory=N''))
                    AND  ((UnitPrice >=@searchPrice) OR (@searchPrice=N''))
           ) AS T
   WHERE t.RowNumber BETWEEN (@page*@pageSize)-@pageSize+1 AND @page*@pageSize
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Product_List_Category]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Product_List_Category]
AS
BEGIN
	SELECT CategoryID,CategoryName
    FROM	Categories
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_UserAccount_Authorize]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_UserAccount_Authorize]
(
	 
	 @email nvarchar(100),
	 @pWd	nvarchar(MAX)
)
AS
BEGIN
	SELECT	EmployeeID,FirstName,LastName,PhotoPath,GroupName,Title,HireDate
    FROM	Employees
    WHERE	(Email=@email) and  (Password=@pWd)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_UserAccount_Change_PWd]    Script Date: 3/22/2021 3:07:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_UserAccount_Change_PWd]
(
	 
	 @EmployeeID int,
	 @Password	nvarchar(MAX)
)
AS
BEGIN
	UPDATE	Employees
    SET		Password = @Password
    WHERE   EmployeeID = @EmployeeID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "OrderDetails"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OrderDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Orders"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Employees"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 12
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Orders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Orders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Categories"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Product'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Product'
GO
