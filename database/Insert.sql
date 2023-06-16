USE BigGuyGear 
GO

/*
INSERT INTO [Role]
VALUES
('ROLE_SUPERADMIN'),
('ROLE_ADMIN'),
('CUSTOMER')
GO

INSERT INTO OrderStatus
VALUES (N'Pending', N'When an order is created and has not been processed or confirmed by the customer.'),
(N'Processing', N'When the order has been confirmed and is being processed by the store''s staff.'),
(N'Shipped', N'Once the order has been packed and shipped to the carrier for delivery to the customer.'),
(N'Delivered', N'When the order has been successfully delivered to the customer.'),
(N'Cancelled', N'When an order is canceled by a customer or store employee for some reason.')
GO

INSERT INTO InvoiceStatus 
VALUES (N'Pending', N'Unpaid or pending invoice.'), 
(N'Paid', N' Invoice has been paid successfully.'),
(N'Failed', N'Bill payment failed.')
GO
*/

-- PRODUCT RELATED
INSERT INTO Category (category_name, image_url)
VALUES 
(N'Shirt', 'shirt.jpg'),
(N'Shorts', 'shorts.jpg'),
(N'Jeans', 'jeans.jpg'),
(N'Jacket', 'jacket.jpg'),
(N'Hoodie, sweater & sweatshirt', 'hoodie.jpg'),
(N'Tank top', 'tank_top.jpg'),
(N'Underwear', 'underwear.jpg')
GO

INSERT INTO ProductBrand
VALUES
(N'Kilomet109'),
(N'Subtle & Simple'),
(N'The Blue T-Shirt'),
(N'Vietcetera'),
(N'Papaya')
GO

/*
Insert Into ProductColor
VALUES
('White'), -- 1
('Black'), -- 2
('Yellow'), -- 3
('Moss green'), -- 4: Xanh rêu
('Dark Blue'), -- 5: Xanh đen
('Terracotta'), -- 6: Cam đất
('Brown'),-- 7: Nâu
('Sky blue'), -- 8: Xanh da trời
('Turquoise'), -- 9: Xanh bích
('Gray'), -- Xám
('Red')
GO
*/

Insert Into ProductSize
VALUES 
(N'XL (65-75kg)'),
(N'2XL (75-85kg)'),
(N'3XL (85-100kg)'),
(N'4XL (100-110kg)'),
(N'5XL (110-120kg)'),
(N'6XL (120-135kg), 1m8'), 
(N'36 : 70-80kg'), -- 7
(N'38 : 80-90kg'), -- 8
(N'40 : 90-100kg'), -- 9
(N'42 : 100-110kg'), -- 10
(N'44 : 110-120kg'), -- 11
(N'46 : 120-135kg') -- 12
GO

/*
INSERT INTO Product (product_name, [description], price, brand_id, category_id) -- SHIRT
VALUES 
(N'',
N'', 20, 1, 1 ) -- name, desciption, pice, brand_id, cate_id
GO
	INSERT INTO ProductImage VALUES 
	((SELECT IDENT_CURRENT('Product')), N'product1_1.jpg'), -- image_name
	((SELECT IDENT_CURRENT('Product')), N'product1_2.jpg'),
	((SELECT IDENT_CURRENT('Product')), N'product1_3.jpg')
	GO
	INSERT INTO ProductVariant VALUES
	((SELECT IDENT_CURRENT('Product')), 4, , 5), -- size_id, color, quantity
	((SELECT IDENT_CURRENT('Product')), 5, , 10),
	((SELECT IDENT_CURRENT('Product')), 6, , 15)
	GO
*/
