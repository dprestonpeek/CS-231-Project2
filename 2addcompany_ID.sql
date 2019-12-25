USE finalproject;
DROP TABLE IF EXISTS company;

CREATE TABLE company (
  company_ID int(11) NOT NULL auto_increment,
  company VARCHAR(30) NOT NULL,
  PRIMARY KEY  (company_ID)

) AS
   SELECT DISTINCT company
   FROM invoices
   WHERE company IS NOT NULL
   ORDER BY company;

ALTER TABLE invoices
   ADD COLUMN company_ID INT(11) AFTER company;

UPDATE invoices
   INNER JOIN company
   ON company.company = invoices.company
   SET invoices.company_ID = company.company_ID
   WHERE company.company IS NOT NULL;

ALTER TABLE invoices
DROP COLUMN company;