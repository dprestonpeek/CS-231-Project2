USE finalproject;
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
  contact_ID int(11) NOT NULL auto_increment,
  title VARCHAR(8),
  firstName VARCHAR(30) NOT NULL,
  lastName VARCHAR(30) NOT NULL,
  email VARCHAR(40) NOT NULL,
  phone CHAR(12) NOT NULL,
  fax CHAR(12) NOT NULL,
  PRIMARY KEY  (contact_ID)
) AS
   SELECT DISTINCT Title, FirstName, LastName, Email, Phone, Fax
   FROM invoices
   WHERE LastName IS NOT NULL
   ORDER BY LastName;

ALTER TABLE invoices
   ADD COLUMN contact_ID INT(11) AFTER FirstName;

UPDATE invoices
   INNER JOIN contacts
   ON contacts.lastName = invoices.LastName
   SET invoices.contact_ID = contacts.contact_ID
   WHERE contacts.contact_ID IS NOT NULL;

SELECT c.contact_ID, inv.Title, inv.FirstName, inv.LastName, inv.Email, inv.Phone, inv.Fax
   FROM contacts AS c
      INNER JOIN invoices AS inv
   ON c.contact_ID = inv.contact_ID;

ALTER TABLE invoices
DROP COLUMN FirstName;
ALTER TABLE invoices
DROP COLUMN LastName;
ALTER TABLE invoices
DROP COLUMN FullName;
ALTER TABLE invoices
DROP COLUMN Email;
ALTER TABLE invoices
DROP COLUMN Phone;
ALTER TABLE invoices
DROP COLUMN Fax;
ALTER TABLE invoices
DROP COLUMN Title;