USE master
GO

DROP DATABASE IF EXISTS ClearReflection
CREATE DATABASE ClearReflection
GO

USE ClearReflection
GO

-- ACCOUNT RELATED -- 
DROP TABLE IF EXISTS [Role]
CREATE TABLE [Role] (
	role_id INT PRIMARY KEY IDENTITY,
	[name] VARCHAR(50) NOT NULL UNIQUE,
)
GO

DROP TABLE IF EXISTS [Image]
CREATE TABLE [Image] (
	image_id INT PRIMARY KEY IDENTITY,
	image_url VARCHAR(200) NOT NULL
)
GO

DROP TABLE IF EXISTS Account
CREATE TABLE Account (
	account_id INT PRIMARY KEY IDENTITY,
	username VARCHAR(255) NOT NULL UNIQUE,
	[password] VARCHAR(255) NOT NULL,
	full_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	phone_number VARCHAR(20) NOT NULL,
	image_id INT,
	[address] VARCHAR(255) NOT NULL,
	role_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (role_id) REFERENCES [Role](role_id),
	FOREIGN KEY (image_id) REFERENCES [Image](image_id),
)
GO



-- PRODUCT RELATED -- 
DROP TABLE IF EXISTS Category
CREATE TABLE Category (
	category_id INT PRIMARY KEY IDENTITY,
	category_name NVARCHAR(100) NOT NULL,
	image_id INT,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (image_id) REFERENCES [Image](image_id),

)
GO






DROP TABLE IF EXISTS ProductColor
CREATE TABLE ProductColor (
	product_color_id INT PRIMARY KEY IDENTITY,
	color_name NVARCHAR(50),
)
GO

DROP TABLE IF EXISTS ProductShape
CREATE TABLE ProductShape (
	product_shape_id INT PRIMARY KEY IDENTITY,
	shape_name NVARCHAR(50),
)
GO

DROP TABLE IF EXISTS ProductStyle
CREATE TABLE ProductStyle (
	product_style_id INT PRIMARY KEY IDENTITY,
	style_name NVARCHAR(50),
)
GO

DROP TABLE IF EXISTS Product
CREATE TABLE Product (
	product_id INT PRIMARY KEY IDENTITY,
	product_name NVARCHAR(200) NOT NULL,
	[description] NVARCHAR(1000),
	price DECIMAL(18, 2) NOT NULL,
	is_hide BIT,
	category_id INT,
	product_shape_id INT,
	product_style_id INT,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (category_id) REFERENCES Category(category_id),
	FOREIGN KEY (product_shape_id) REFERENCES ProductShape(product_shape_id),
	FOREIGN KEY (product_style_id) REFERENCES ProductStyle(product_style_id)

)
GO

DROP TABLE IF EXISTS ProductImage
CREATE TABLE ProductImage (
	product_id INT,
	image_id INT,
	PRIMARY KEY (product_id, image_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id),
	FOREIGN KEY (image_id) REFERENCES [Image](image_id)
)
GO

DROP TABLE IF EXISTS ProductVariant
CREATE TABLE ProductVariant (
	product_variant_id INT PRIMARY KEY IDENTITY,
	product_id INT NOT NULL,
	height INT NOT NULL,
	width INT NOT NULL,
	color_id INT NOT NULL,
	quantity INT NOT NULL,
	image_id INT,
	FOREIGN KEY (product_id) REFERENCES Product(product_id),
	FOREIGN KEY (color_id) REFERENCES ProductColor(product_color_id),
	FOREIGN KEY (image_id) REFERENCES [Image](image_id)
)
GO

DROP TABLE IF EXISTS ProductReview
CREATE TABLE ProductReview (
	product_review_id INT PRIMARY KEY IDENTITY,
	account_id INT NOT NULL,
	product_id INT NOT NULL,
	content NVARCHAR(1000) NOT NULL,
	rating TINYINT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (account_id) REFERENCES Account(account_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id),
)
GO


-- WISHLIST
DROP TABLE IF EXISTS Wishlist
CREATE TABLE Wishlist (
	wishlist_id INT PRIMARY KEY IDENTITY,
	account_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (account_id) REFERENCES Account(account_id)
)
GO

DROP TABLE IF EXISTS WishlistDetail
CREATE TABLE WishlistDetail (
	wishlist_detail_id INT PRIMARY KEY IDENTITY,
	product_id INT NOT NULL,
	wishlist_id INT NOT NULL,
	FOREIGN KEY (wishlist_id) REFERENCES Wishlist(wishlist_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id)
)
GO

-- CART RELATED -- 
DROP TABLE IF EXISTS Cart
CREATE TABLE Cart (
	cart_id INT PRIMARY KEY IDENTITY,
	account_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (account_id) REFERENCES Account(account_id)
)
GO

DROP TABLE IF EXISTS CartDetail
CREATE TABLE CartDetail (
	cart_detail_id INT PRIMARY KEY IDENTITY,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL(18,2) NOT NULL,
	cart_id INT NOT NULL,
	FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id)
)
GO



-- ORDER RELATED -- 
DROP TABLE IF EXISTS CouponType
CREATE TABLE CouponType(
	coupon_type_id INT PRIMARY KEY IDENTITY,
	coupon_type_name NVARCHAR(50) NOT NULL
)
GO

DROP TABLE IF EXISTS Coupon
CREATE TABLE Coupon (
	coupon_id INT PRIMARY KEY IDENTITY,
	coupon_name VARCHAR(200) NOT NULL,
	discount INT NOT NULL,
	coupon_type_id INT NOT NULL,
	[description] NVARCHAR(200),
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	expired_at DATETIME NOT NULL,
	FOREIGN KEY (coupon_type_id) REFERENCES CouponType(coupon_type_id)
)
GO

DROP TABLE IF EXISTS AccountCoupon
CREATE TABLE AccountCoupon(
	coupon_id INT,
	account_id INT,
	is_used BIT NOT NULL, 
	PRIMARY KEY (coupon_id, account_id),
	FOREIGN KEY (coupon_id) REFERENCES Coupon(coupon_id),
	FOREIGN KEY (account_id) REFERENCES Account(account_id)
)
GO

DROP TABLE IF EXISTS PaymentMethod
CREATE TABLE PaymentMethod (
	payment_method_id INT PRIMARY KEY IDENTITY,
	payment_method_name VARCHAR(100) NOT NULL,
)
GO

DROP TABLE IF EXISTS [OrderStatus]
CREATE TABLE [OrderStatus] (
	order_status_id INT PRIMARY KEY IDENTITY,
	status_name NVARCHAR(50) NOT NULL,
	status_description NVARCHAR(100) NOT NULL,
)
GO

DROP TABLE IF EXISTS [Order]
CREATE TABLE [Order] (
	order_id INT PRIMARY KEY IDENTITY,
	order_tracking_number VARCHAR(50),
	account_id INT NOT NULL,
	coupon_id INT,
	total_price DECIMAL(18,2) NOT NULL,
	total_quantity INT NOT NULL,
	order_status_id INT NOT NULL,
	billing_address NVARCHAR(200),
	shipping_address NVARCHAR(200),
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (account_id) REFERENCES Account(account_id),
	FOREIGN KEY (order_status_id) REFERENCES OrderStatus(order_status_id),
	FOREIGN KEY (coupon_id) REFERENCES Coupon(coupon_id)
)
GO

DROP TABLE IF EXISTS OrderDetail
CREATE TABLE OrderDetail (
	order_detail_id INT PRIMARY KEY IDENTITY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	address_id INT NOT NULL,
	quantity INT NOT NULL,
	price DECIMAL(18,2) NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	updated_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (order_id) REFERENCES [Order](order_id),
	FOREIGN KEY (product_id) REFERENCES Product(product_id)
)
GO

-- INVOICE RELATED
DROP TABLE IF EXISTS InvoiceStatus
CREATE TABLE InvoiceStatus (
	invoice_status_id INT PRIMARY KEY IDENTITY,
	status_name NVARCHAR(50) NOT NULL,
	status_description NVARCHAR(100) NOT NULL,
)
GO

DROP TABLE IF EXISTS Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY IDENTITY,
	payment_method_id INT NOT NULL,
	coupon_id INT,
	invoice_status_id INT NOT NULL,
	account_id INT NOT NULL,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(payment_method_id),
	FOREIGN KEY (account_id) REFERENCES Account(account_id),
	FOREIGN KEY (invoice_status_id) REFERENCES [InvoiceStatus](invoice_status_id)
)
GO


-- Other tables
DROP TABLE IF EXISTS CompanyInformation
CREATE TABLE CompanyInformation (
	company_information_id INT PRIMARY KEY IDENTITY,
	company_name NVARCHAR(50) NOT NULL,
	company_address NVARCHAR(100) NOT NULL,
	company_phone_number NVARCHAR(20) NOT NULL,
	company_vat_number NVARCHAR(20) NOT NULL,
)
GO

DROP TABLE IF EXISTS [Notification]
CREATE TABLE [Notification] (
	notification_id INT PRIMARY KEY IDENTITY,
	[message] NVARCHAR(200) NOT NULL,
	account_id INT,
	created_at DATETIME NOT NULL DEFAULT GETDATE(),
	is_read BIT,
	FOREIGN KEY (account_id) REFERENCES Account(account_id)
)
GO