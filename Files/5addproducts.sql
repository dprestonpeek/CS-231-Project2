USE finalproject;
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  productName VARCHAR(100) NOT NULL,
  partNumber CHAR(15),
  productWeight INT(11) NOT NULL,
  quantity INT(11) NOT NULL,
  price FLOAT NOT NULL,
  extendedPrice FLOAT NOT NULL,
  taxable CHAR(1) NOT NULL,
  taxAmount FLOAT NOT NULL,
  unitDimensions CHAR(10),
  PRIMARY KEY  (partNumber)
) AS
   SELECT DISTINCT ProductName, PartNumber, ProductWeight, Quantity, Price, ExtendedPrice, Taxable, TaxAmount, UnitDimensions
   FROM invoices
   WHERE ProductName IS NOT NULL
   ORDER BY ProductName;

UPDATE invoices
   INNER JOIN products
   ON products.productName = invoices.ProductName
   SET invoices.PartNumber = products.partNumber
   WHERE products.productName IS NOT NULL;

ALTER TABLE invoices
DROP COLUMN ProductName;
ALTER TABLE invoices
DROP COLUMN ProductWeight;
ALTER TABLE invoices
DROP COLUMN Quantity;
ALTER TABLE invoices
DROP COLUMN Price;
ALTER TABLE invoices
DROP COLUMN ExtendedPrice;
ALTER TABLE invoices
DROP COLUMN Taxable;
ALTER TABLE invoices
DROP COLUMN TaxAmount;
ALTER TABLE invoices
DROP COLUMN UnitDimensions;