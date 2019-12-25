USE finalproject;
DROP TABLE IF EXISTS address;

CREATE TABLE address (
  street_ID int(11) NOT NULL auto_increment,
  street VARCHAR(30) NOT NULL,
  PRIMARY KEY  (street_ID)

) AS
   SELECT DISTINCT Street, City, State, PostalCode
   FROM invoices
   WHERE Street IS NOT NULL
   ORDER BY Street;

ALTER TABLE invoices
   ADD COLUMN street_ID INT(11) AFTER Street;

UPDATE invoices
   INNER JOIN address
   ON address.street = invoices.Street
   SET invoices.street_ID = address.street_ID
   WHERE address.street IS NOT NULL;

ALTER TABLE invoices
DROP COLUMN Street;
ALTER TABLE invoices
DROP COLUMN State;
ALTER TABLE invoices
DROP COLUMN City;
ALTER TABLE invoices
DROP COLUMN PostalCode;