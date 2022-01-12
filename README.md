## SQL cheatsheet

the example below uses the publically available Chinook dataset ([ER diagram](https://i.stack.imgur.com/LhVjF.jpg)). note that the example uses sqlite conventions.

```
SELECT 
  c.CustomerId                                  --column(s) to select
  ,c.FirstName                                  --use "as" to name a created column
  ,c.LastName
  ,SUBSTR(c.LastName,1,2) as LastNameShort      --extract part of a string (here, first two chars)
  ,UPPER(c.CustomerID || c.LastName) as NewId
  ,COUNT(i.InvoiceId) as NInvoices              --aggregating performed by each level of "GROUP BY"
WHERE
  c.CustomerId < 200                            --filter rows based on condition
FROM 
  Customers c                                   --table from which to select, plus alias
LEFT JOIN 
  Invoices i ON (c.CustomerId = i.CustomerId)   --join with additional table, based on key
GROUP BY 
  c.CustomerId                                  --group data according to a column
HAVING 
  c.CustomerId NInvoices > 1                    --filter rows based on condition
ORDER BY 
  c.NewId desc                                  --sort rows according to a column (asc/desc)

```

### to add

- creating a view
- profiling a table
