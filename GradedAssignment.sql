CREATE TABLE IF NOT EXISTS supplier (
    supp_id INT PRIMARY KEY,
    supp_name VARCHAR(50) NOT NULL,
    supp_city VARCHAR(50) NOT NULL,
    supp_phone VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS customer (
    cus_id INT PRIMARY KEY,
    cus_name VARCHAR(20) NOT NULL,
    cus_phone VARCHAR(10) NOT NULL,
    cus_city VARCHAR(30) NOT NULL,
    cus_gender VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS category (
    cat_id INT PRIMARY KEY,
    cat_name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(20) NOT NULL DEFAULT 'Dummy',
    pro_desc VARCHAR(60) NOT NULL,
    cat_id INT,
    FOREIGN KEY (cat_id)
        REFERENCES category (cat_id)
);

CREATE TABLE IF NOT EXISTS supplier_pricing (
    pricing_id INT PRIMARY KEY,
    pro_id INT,
    supp_id INT,
    supp_price INT DEFAULT 0,
    FOREIGN KEY (pro_id)
        REFERENCES product (pro_id),
    FOREIGN KEY (supp_id)
        REFERENCES supplier (supp_id)
);

CREATE TABLE IF NOT EXISTS `order` (
    ord_id INT PRIMARY KEY,
    ord_amount INT NOT NULL,
    ord_date DATE NOT NULL,
    cus_id INT,
    pricing_id INT,
    FOREIGN KEY (cus_id)
        REFERENCES customer (cus_id),
    FOREIGN KEY (pricing_id)
        REFERENCES supplier_pricing (pricing_id)
);

CREATE TABLE IF NOT EXISTS rating (
    rat_id INT PRIMARY KEY,
    ord_id INT,
    rat_ratstars INT NOT NULL,
    FOREIGN KEY (ord_id)
        REFERENCES `order` (ord_id)
);

INSERT INTO supplier VALUES(1,"Rajesh Retails","Delhi",'1234567890'); 
INSERT INTO supplier VALUES(2,"Appario Ltd.","Mumbai",'2589631470');
INSERT INTO supplier VALUES(3,"Knome products","Banglore",'9785462315'); 
INSERT INTO supplier VALUES(4,"Bansal Retails","Kochi",'8975463285'); 
INSERT INTO supplier VALUES(5,"Mittal Ltd.","Lucknow",'7898456532');
INSERT INTO supplier VALUES(6,"Mani Retails","Hosur",'1234567890'); 
INSERT INTO customer VALUES(1,"AAKASH",'9999999999',"DELHI",'M'); 
INSERT INTO customer VALUES(2,"AMAN",'9785463215',"NOIDA",'M'); 
INSERT INTO customer VALUES(3,"NEHA",'9999999999',"MUMBAI",'F');
INSERT INTO customer VALUES(4,"MEGHA",'9994562399',"KOLKATA",'F');
INSERT INTO customer VALUES(5,"PULKIT",'7895999999',"LUCKNOW",'M');
INSERT INTO category VALUES( 1,"BOOKS");
INSERT INTO category VALUES(2,"GAMES"); 
INSERT INTO category VALUES(3,"GROCERIES");
INSERT INTO category VALUES (4,"ELECTRONICS"); 
INSERT INTO category VALUES(5,"CLOTHES"); 
INSERT INTO product VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2); 
INSERT INTO product VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO product VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4); 
INSERT INTO product VALUES(4,"OATS","Highly Nutritious from Nestle",3); INSERT INTO product VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1); 
INSERT INTO product VALUES(6,"MILK","1L Toned MIlk",3); 
INSERT INTO product VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO product VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO product VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO product VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO product VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO product VALUES(12,"Train Your Brain","By Shireen Stephen",1); 
INSERT INTO supplier_pricing VALUES(5,4,1,1000);
INSERT INTO supplier_pricing VALUES(6,12,2,780);
INSERT INTO supplier_pricing VALUES(7,12,4,789);
INSERT INTO supplier_pricing VALUES(8,3,1,31000);
INSERT INTO supplier_pricing VALUES(9,1,5,1450); 
INSERT INTO supplier_pricing VALUES(10,4,2,999); 
INSERT INTO supplier_pricing VALUES(11,7,3,549); 
INSERT INTO supplier_pricing VALUES(12,7,4,529); 
INSERT INTO supplier_pricing VALUES(13,6,2,105); 
INSERT INTO supplier_pricing VALUES(14,6,1,99); 
INSERT INTO supplier_pricing VALUES(15,2,5,2999);
INSERT INTO supplier_pricing VALUES(16,5,2,2999);
INSERT INTO `order` VALUES(102,1000,"2021-10-12",3,5);
INSERT INTO `order` VALUES(106,1450,"2021-08-18",1,9); 
INSERT INTO `order` VALUES(107,789,"2021-09-01",3,7); 
INSERT INTO `order` VALUES(108,780,"2021-09-07",5,6);  
INSERT INTO `order` VALUES(111,1000,"2021-09-15",4,5); 
INSERT INTO `order` VALUES(112,789,"2021-09-16",4,7); 
INSERT INTO `order` VALUES(113,31000,"2021-09-16",1,8); 
INSERT INTO `order` VALUES(114,1000,"2021-09-16",3,5);  
INSERT INTO `order` VALUES(116,99,"2021-09-17",2,14);
 
INSERT INTO rating VALUES(2,102,3);  
INSERT INTO rating VALUES(6,106,3); 
INSERT INTO rating VALUES(7,107,4); 
INSERT INTO rating VALUES(8,108,4); 
INSERT INTO rating VALUES(11,111,3); 
INSERT INTO rating VALUES(12,112,4); 
INSERT INTO rating VALUES(13,113,2); 
INSERT INTO rating VALUES(14,114,1);  
INSERT INTO rating VALUES(16,116,0);  
 
SELECT 
    COUNT(DISTINCT (customer.cus_id)) AS `total number of customers`
FROM
    e_com.customer,
    e_com.`order`
WHERE
    customer.cus_gender = 'M'
        AND `order`.ord_amount > 3000;
        
        
        
SELECT 
    COUNT(DISTINCT (e_com.customer.cus_id)),
    e_com.customer.cus_gender
FROM
    e_com.customer
        INNER JOIN
    (SELECT 
        cus_id
    FROM
        e_com.order
    WHERE
        e_com.order.ord_amount >= 3000) AS result ON e_com.customer.cus_id = result.cus_id
GROUP BY e_com.customer.cus_gender;

SELECT 
    e_com.product.pro_name
FROM
    product
        INNER JOIN
    (SELECT 
        pro_id
    FROM
        supplier_pricing
    INNER JOIN (SELECT 
        pricing_id
    FROM
        e_com.order
    WHERE
        e_com.order.cus_id = 2) AS result ON e_com.supplier_pricing.pricing_id = result.pricing_id) AS prodResult ON e_com.product.pro_id = prodResult.pro_id;
        
        
SELECT 
    e_com.product.pro_name, result.*
FROM
    product
        INNER JOIN
    (SELECT 
        e_com.order.*, supplier_pricing.pro_id
    FROM
        e_com.order
    INNER JOIN supplier_pricing ON e_com.order.pricing_id = supplier_pricing.pricing_id
    WHERE
        e_com.order.cus_id = 2) AS result ON result.pro_id = product.pro_id;