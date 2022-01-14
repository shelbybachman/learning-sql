--All queries refer to the Chinook Database (https://ucde-rey.s3.amazonaws.com/DSV1015/ChinookDatabaseSchema.png)

--Using a subquery, find the names of all the tracks for the album "Californication"
SELECT
    AlbumId
    ,TrackId
    ,Name
FROM 
    Tracks
WHERE AlbumId = 
   (SELECT AlbumId
   FROM Albums
   WHERE Title = 'Californication');


--Using a join, find the names of all the tracks for the album "Californication"
SELECT 
    a.Title
    ,TrackId
    ,Name
FROM 
    Albums a
LEFT JOIN Tracks t ON (a.AlbumId = t.AlbumId)
WHERE a.Title = 'Californication';


--Find the total number of invoices for each customer along with the customer's full name, city and email.
SELECT
    c.CustomerId
    ,c.FirstName
    ,c.LastName
    ,c.City
    ,c.Email
    ,COUNT(DISTINCT(i.InvoiceId)) as n_invoices
FROM 
    Customers c
LEFT JOIN Invoices i ON (c.CustomerId = i.CustomerId)
GROUP BY c.CustomerId;


--Retrieve the track name, album, artistID, and trackID for all the albums.
--Then return info for "For Those About to Rock We Salute You" album.
SELECT
    a.AlbumId
    ,a.Title
    ,a.ArtistId
    ,t.TrackId
    ,t.Name
FROM 
    Albums as a
LEFT JOIN Tracks t ON (a.AlbumId = t.AlbumId)
WHERE a.Title = 'For Those About to Rock We Salute You';


--Retrieve a list with the managers last name, and the last name of the employees who report to him or her.
SELECT
    t1.EmployeeId as manager_id
    ,t1.LastName as manager_lastname
    ,t2.ReportsTo as employee_reportsto
    ,t2.LastName as employee_lastname
FROM
    Employees t1
LEFT JOIN Employees t2 ON (t1.EmployeeId = t2.ReportsTo)
WHERE t2.ReportsTo IS NOT NULL;


--Find the name and ID of the artists who do not have albums. 
SELECT
    Artists.Name
    ,Artists.ArtistId
    ,Albums.Title
FROM 
    Artists
LEFT JOIN Albums ON (Artists.ArtistId = Albums.ArtistId)
WHERE Albums.Title IS NULL;


--Use a UNION to create a list of all the employee's and customer's first names and last names
--ordered by the last name in descending order.
SELECT
    FirstName
    ,LastName
FROM
    Employees

UNION

SELECT
    FirstName
    ,LastName
FROM
    Customers

ORDER BY LastName desc;


--See if there are any customers who have a different city listed in their billing city versus their customer city.
SELECT 
    c.CustomerId
    ,c.City
    ,i.BillingCity
FROM
    Customers c
INNER JOIN Invoices i ON (c.CustomerId = i.CustomerId)
WHERE c.City != i.BillingCity;


--Pull a list of customer ids with the customer’s full name, and address,
--along with combining their city and country together. 
--Be sure to make a space in between these two and make it UPPER CASE. (e.g. LOS ANGELES USA)
SELECT
    CustomerId
    ,FirstName
    ,LastName
    ,Address
    ,UPPER(CONCAT(City, ' ', Country)) as city_country
FROM 
    Customers;


--Create a new employee user id by combining the first 4 letters of the employee’s first name 
--with the first 2 letters of the employee’s last name. 
--Make the new field lower case and pull each individual step to show your work.
SELECT
    EmployeeId
    ,FirstName
    ,LastName
    ,CONCAT(SUBSTR(FirstName,1,4), SUBSTR(Lastname,1,2)) as userid
FROM 
    Employees;


--Show a list of employees who have worked for the company for 15 or more years using the current date function. 
--Sort by lastname ascending.
SELECT
    EmployeeId
    ,LastName
    ,HireDate
    ,(STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)) as years_worked
FROM 
    Employees
WHERE years_worked >= 15
ORDER BY LastName asc;


--Profiling the Customers table, are there any columns with null values?
SELECT
    COUNT(*)
FROM 
    Customers
WHERE (PostalCode OR FirstName OR Fax) IS NULL;


--Find the cities with the most customers and rank in descending order.
SELECT
    City
    ,COUNT(DISTINCT(CustomerId)) as total_customers
FROM
    Customers
GROUP BY City
ORDER BY total_customers desc;


--Create a new customer invoice id by combining a customer’s invoice id with their first and last name 
--while ordering your query in the following order: firstname, lastname, and invoiceID.
SELECT
    c.CustomerId
    ,i.InvoiceId
    ,c.FirstName
    ,c.LastName
    ,CONCAT(c.FirstName, c.LastName, i.InvoiceId) as newid
FROM
    Customers c
LEFT JOIN Invoices i ON (c.CustomerId = i.CustomerId)
ORDER BY FirstName, LastName, InvoiceId desc;