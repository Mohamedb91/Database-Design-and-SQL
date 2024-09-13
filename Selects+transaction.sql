-- Selecting sales information along with customer and product details
SELECT
    s.saleid,              
    c.customername,         
    p.brandname,            
    ps.size,                
    s.date,                 
    s.amount               
FROM
    sales s
INNER JOIN customer c ON s.customerid = c.customerid
INNER JOIN packsize ps ON s.packsize_packsizeid = ps.packsizeid
INNER JOIN product p ON ps.product_productid = p.productid;

-- Overview of prescriptions with customer and drug type details
SELECT
    p.prescriptionid,
    c.customername,
    d.typename,
    p.issuedate,
    p.doctor
FROM
    prescriptions p
LEFT OUTER JOIN customer c ON p.customerid = c.customerid
LEFT OUTER JOIN drugtype d ON p.drugtypeid = d.drugtypeid;






-- Query to calculate total number of sales made by each customer
SELECT
    c.customerid,
    c.customername,
    COUNT(s.saleid) AS total_sales
FROM
    customer c
LEFT JOIN sales s ON c.customerid = s.customerid
GROUP BY
    c.customerid, c.customername;

-- Query to calculate average price of products within each drug type
SELECT
    dt.typename,
    AVG(CAST(ps.price AS DECIMAL(10, 2))) AS avg_price
FROM
    drugtype dt
LEFT JOIN product p ON dt.drugtypeid = p.drugtypeid
LEFT JOIN packsize ps ON p.productid = ps.productid
GROUP BY
    dt.typename;

   
   
   
   
   
-- This query will return a combined list of customer names and medical card numbers, excluding NULL values
SELECT customername AS info
FROM customer
WHERE medicalcardnumber IS NOT NULL

UNION

SELECT medicalcardnumber AS info
FROM customer
WHERE medicalcardnumber IS NOT NULL;


--query will return customers who have both medical cards and prescriptions
SELECT customername
FROM customer
WHERE medicalcardnumber IS NOT NULL

INTERSECT

SELECT c.customername
FROM customer c
JOIN prescriptions p ON c.customerid = p.customerid;


-- customers who have a medical card but no prescriptions
SELECT customername
FROM customer
WHERE medicalcardnumber IS NOT NULL

EXCEPT

SELECT c.customername
FROM customer c
JOIN prescriptions p ON c.customerid = p.customerid;

--  ranks customers by their total sales amount, using a window function to calculate the rank
SELECT
    c.customerid,
    c.customername,
    SUM(CAST(s.amount AS DECIMAL(10, 2))) AS total_amount,
    RANK() OVER (ORDER BY SUM(CAST(s.amount AS DECIMAL(10, 2))) DESC) AS sales_rank
FROM
    sales s
JOIN
    customer c ON s.customerid = c.customerid
GROUP BY
    c.customerid, c.customername
ORDER BY
    total_amount DESC;

      GRANT SELECT ON prescriptions TO "C22394893";


     
     
     
     
-- Start the transaction
BEGIN TRANSACTION;

-- Update Customer CUST005
UPDATE customer
SET customername = 'Daniel Evans'
WHERE customerid = 'CUST005';

-- Insert New Product
INSERT INTO product (productid, brandname, drugtypeid, drugtype_drugtypeid)
VALUES
    ('PROD006','HeadacheRelief','DT001','DT001');

-- Commit the transaction
COMMIT;

