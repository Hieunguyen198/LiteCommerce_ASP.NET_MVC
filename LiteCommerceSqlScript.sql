USE [LiteCommerce]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  View [dbo].[View_Product]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  Table [dbo].[Employees]    Script Date: 3/16/2021 4:59:25 PM ******/
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
	[GroupName] [nchar](10) NULL,
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
/****** Object:  Table [dbo].[Customers]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 3/16/2021 4:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[CustomerID] [nchar](10) NOT NULL,
	[EmployeeID] [int] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Orders]    Script Date: 3/16/2021 4:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Orders]
AS
SELECT        dbo.Orders.OrderID, dbo.Orders.OrderDate, dbo.Orders.CustomerID, dbo.Orders.EmployeeID, dbo.Customers.ContactName, dbo.Employees.FirstName, dbo.Employees.LastName
FROM            dbo.Orders INNER JOIN
                         dbo.Employees ON dbo.Orders.EmployeeID = dbo.Employees.EmployeeID INNER JOIN
                         dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  View [dbo].[View_OrderDetails]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  Table [dbo].[Countries]    Script Date: 3/16/2021 4:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryName] [varchar](50) NULL
) ON [PRIMARY]
GO
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
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Customers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Employees]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
/****** Object:  StoredProcedure [dbo].[Proc_Category_Add]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Category_Count]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Category_Delete_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Category_Edit]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Category_Get_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Category_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Country_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Add]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Count]    Script Date: 3/16/2021 4:59:25 PM ******/
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
          OR(CompanyName like @searchValue)
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Delete]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Edit]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Customer_Get_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Customer_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
               OR(CompanyName like @searchValue)
         ) AS T
    WHERE t.RowNumber BETWEEN (@page*@pageSize)-@pageSize+1 AND @page*@pageSize
END
GO
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_Discount_By_Year]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_OrderQuantity_By_Year]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Dashboard_Revenue_By_Year]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Add]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Count]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Delete_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Edit]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Get_By_Email]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_Get_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Employee_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Order_Count]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Order_Delete]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Order_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Order_OrderDetail]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Order_OrderDetail_By_OrderID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_Add]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_Count]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_Delete]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_Edit]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_Get_By_ID]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_List]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_Product_List_Category]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_UserAccount_Authorize]    Script Date: 3/16/2021 4:59:25 PM ******/
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
/****** Object:  StoredProcedure [dbo].[Proc_UserAccount_Change_PWd]    Script Date: 3/16/2021 4:59:25 PM ******/
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
            TopColumn = 0
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
