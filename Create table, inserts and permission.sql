--DROP TABLE IF EXISTS sales;
--DROP TABLE IF EXISTS packsize;
--DROP TABLE IF EXISTS prescriptions;
--DROP TABLE IF EXISTS product;
--DROP TABLE IF EXISTS drugtype;
--DROP TABLE IF EXISTS customer;

-- Create customer table
CREATE TABLE customer (
    customerid        VARCHAR(20) NOT NULL,
    customername      VARCHAR(20),
    holder            CHAR(1),
    medicalcardnumber VARCHAR(20),
    PRIMARY KEY (customerid)
);

-- Create drugtype table
CREATE TABLE drugtype (
    drugtypeid           VARCHAR(20) NOT NULL,
    typename             VARCHAR(20),
    recommendeddosage    VARCHAR(20),
    prescriptionrequired CHAR(1),
    PRIMARY KEY (drugtypeid)
);

-- Create product table
CREATE TABLE product (
    productid           VARCHAR(50) NOT NULL,
    brandname           VARCHAR(50),
    drugtypeid          VARCHAR(20),
    drugtype_drugtypeid VARCHAR(20) NOT NULL,
    PRIMARY KEY (productid),
    FOREIGN KEY (drugtype_drugtypeid) REFERENCES drugtype (drugtypeid)
);

-- Create packsize table
CREATE TABLE packsize (
    packsizeid        VARCHAR(20) NOT NULL,
    productid         VARCHAR(20),
    size              VARCHAR(20), -- Changed "Size" to size (non-quoted)
    price             VARCHAR(20),
    product_productid VARCHAR(50) NOT NULL,
    PRIMARY KEY (packsizeid),
    FOREIGN KEY (product_productid) REFERENCES product (productid)
);

-- Create prescriptions table
CREATE TABLE prescriptions (
    prescriptionid      VARCHAR(20) NOT NULL,
    customerid          VARCHAR(20),
    drugtypeid          VARCHAR(20),
    issuedate           DATE,
    doctor              VARCHAR(20),
    customer_customerid VARCHAR(20) NOT NULL,
    PRIMARY KEY (prescriptionid),
    FOREIGN KEY (customer_customerid) REFERENCES customer (customerid)
);

-- Create sales table
CREATE TABLE sales (
    saleid              VARCHAR(20) NOT NULL,
    customerid          VARCHAR(20),
    packsize            VARCHAR(20),
    date                DATE,
    amount              VARCHAR(10),
    customer_customerid VARCHAR(20) NOT NULL,
    packsize_packsizeid VARCHAR(20) NOT NULL,
    PRIMARY KEY (saleid),
    FOREIGN KEY (customer_customerid) REFERENCES customer (customerid),
    FOREIGN KEY (packsize_packsizeid) REFERENCES packsize (packsizeid)
);

INSERT INTO customer (customerid, customername, holder, medicalcardnumber)
VALUES
	('CUST001', 'John Doe', 'Y', 'MC12345'),
    ('CUST002', 'Jane Smith', 'N', NULL),
    ('CUST003', 'Michael Johnson', 'Y', 'MC67890'),
    ('CUST004', 'Emily Brown', 'N', NULL),
    ('CUST005', 'David Lee', 'Y', 'MC54321'),
	('CUST006', 'sean Burke', 'Y', 'MC54323');

INSERT INTO drugtype (drugtypeid, typename, recommendeddosage, prescriptionrequired)
VALUES
    ('DT001', 'Pain Relief', '500mg', 'Y'),
    ('DT002', 'Antibiotic', '600mg', 'Y'),
    ('DT003', 'Allergy Relief', '250mg', 'N'),
    ('DT004', 'Cold & Flu', '1000mg', 'N'),
    ('DT005', 'Antacid', '300mg', 'N');

INSERT INTO product (productid, brandname, drugtypeid, drugtype_drugtypeid)
VALUES
    ('PROD001', 'PainAway', 'DT001', 'DT001'),
    ('PROD002', 'AmoxiCillin', 'DT002', 'DT002'),
    ('PROD003', 'AllerClear', 'DT003', 'DT003'),
    ('PROD004', 'ColdRelief', 'DT004', 'DT004'),
    ('PROD005', 'AntaGel', 'DT005', 'DT005');

INSERT INTO packsize (packsizeid, productid, size, price, product_productid)
VALUES
    ('PS001', 'PROD001', '50 tablets', '20.99', 'PROD001'),
    ('PS002', 'PROD002', '30 tablets', '15.50', 'PROD002'),
    ('PS003', 'PROD003', '60 tablets', '25.75', 'PROD003'),
    ('PS004', 'PROD004', '10 packets', '8.99', 'PROD004'),
    ('PS005', 'PROD005', '100 tablets', '12.25', 'PROD005');

INSERT INTO prescriptions (prescriptionid, customerid, drugtypeid, issuedate, doctor, customer_customerid)
VALUES
    ('RX001', 'CUST001', 'DT001', '2024-04-10', 'Dr. Smith', 'CUST001'),
    ('RX002', 'CUST002', 'DT002', '2024-04-11', 'Dr. Johnson', 'CUST002'),
    ('RX003', 'CUST003', 'DT003', '2024-04-12', 'Dr. Brown', 'CUST003'),
    ('RX004', 'CUST004', 'DT004', '2024-04-13', 'Dr. Lee', 'CUST004'),
    ('RX005', 'CUST005', 'DT005', '2024-04-14', 'Dr. White', 'CUST005');

INSERT INTO sales (saleid, customerid, packsize, date, amount, customer_customerid, packsize_packsizeid)
VALUES
    ('SALE001', 'CUST001', 'PS001', '2024-04-15', '1', 'CUST001', 'PS001'),
    ('SALE002', 'CUST002', 'PS002', '2024-04-16', '2', 'CUST002', 'PS002'),
    ('SALE003', 'CUST003', 'PS003', '2024-04-17', '1', 'CUST003', 'PS003'),
    ('SALE004', 'CUST004', 'PS004', '2024-04-15', '3', 'CUST004', 'PS004'),
    ('SALE005', 'CUST005', 'PS005', '2024-04-16', '2', 'CUST005', 'PS005');   

GRANT select on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 1";
GRANT UPDATE on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 1";
GRANT INSERT on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 1";
GRANT delete  on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 1";

GRANT select on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 2";
GRANT update on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 2";
GRANT INSERT on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 2";
GRANT delete  on customer, drugtype, product, packsize, prescriptions, sales TO "CENSORED USER 2";