#
# This file forms part of a formal assessment for the course.
# It is advised that copies be made of this  and the database file in the event that they might become corrupted.
# The compressed ZIP file containing this file along with its associated database (wiki05.db) should be extracted within a new folder on your University H: drive.
# Details about your University H: drive are avialable via the IT Services web pages.
# Instructions to run this file assume students are using the University's VDI resource. 
# Students must not change the contents of the database file. However, the database can be reviewed using free open source tools such as DB Browser installed on your own device.
# It is students responsibility to install and configure software systems where they choose to consider other methods of running the file.
# Warning, student marks will only be based on results produced when running submissions on the University's VDI resource.
# The command 'ruby sqlcaa01_xx.rb' (where xx is the version number) should be used to run the SQL statements and check whether they produce the correct results.
# This can be performed as many times as one likes before submitting.
# Once submitted to Myaberdeen this will count for an attempt.
# Note. All SQL statements inserted into this file must not include double quotation characters ( " " ). Instead only single qutation ( '  ' ) marks must be used where required.
#
# sqlcaa 2020-21 (Copyright 2020)

require 'rubygems'
require 'sqlite3'
# the database is based on a blog where users log in and post questions and/or answers to questions.
# the database also stores ratings associated with post questions alongside replies.
DbName = 'chinook.db'
SQLQ = []
SQLA = []
correct = 0
# display 
#SQLQ[] = ""
#SQLA[] = ''

# display all data for all users
SQLQ[0] = "SELECT * 
           FROM Employees;"
SQLA[0] ='[["EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email"], [1, "Adams", "Andrew", "General Manager", nil, "1962-02-18 00:00:00", "14/08/2002", "11120 Jasper Ave NW", "Edmonton", "AB", "Canada", "T5K 2N1", "+1 (780) 428-9482", "+1 (780) 428-3457", "andrew@chinookcorp.com"], [2, "Edwards", "Nancy", "Sales Manager", 1, "1958-12-08 00:00:00", "01/05/2002", "825 8 Ave SW", "Calgary", "AB", "Canada", "T2P 2T3", "+1 (403) 262-3443", "+1 (403) 262-3322", "nancy@chinookcorp.com"], [3, "Peacock", "Jane", "Sales Support Agent", 2, "1973-08-29 00:00:00", "01/04/2002", "1111 6 Ave SW", "Calgary", "AB", "Canada", "T2P 5M5", "+1 (403) 262-3443", "+1 (403) 262-6712", "jane@chinookcorp.com"], [4, "Park", "Margaret", "Sales Support Agent", 2, "1947-09-19 00:00:00", "03/05/2003", "683 10 Street SW", "Calgary", "AB", "Canada", "T2P 5G3", "+1 (403) 263-4423", "+1 (403) 263-4289", "margaret@chinookcorp.com"], [5, "Johnson", "Steve", "Sales Support Agent", 2, "1965-03-03 00:00:00", "17/10/2003", "7727B 41 Ave", "Calgary", "AB", "Canada", "T3B 1Y7", "1 (780) 836-9987", "1 (780) 836-9543", "steve@chinookcorp.com"], [6, "Mitchell", "Michael", "IT Manager", 1, "1973-07-01 00:00:00", "17/10/2003", "5827 Bowness Road NW", "Calgary", "AB", "Canada", "T3B 0C5", "+1 (403) 246-9887", "+1 (403) 246-9899", "michael@chinookcorp.com"], [7, "King", "Robert", "IT Staff", 6, "1970-05-29 00:00:00", "02/01/2004", "590 Columbia Boulevard West", "Lethbridge", "AB", "Canada", "T1K 5N8", "+1 (403) 456-9986", "+1 (403) 456-8485", "robert@chinookcorp.com"], [8, "Callahan", "Laura", "IT Staff", 6, "1968-01-09 00:00:00", "04/03/2004", "923 7 ST NW", "Lethbridge", "AB", "Canada", "T1H 1Y8", "+1 (403) 467-3351", "+1 (403) 467-8772", "laura@chinookcorp.com"]]'


# display last name and first name data for all employees  
SQLQ[1] = "SELECT LastName, FirstName 
           FROM Employees;"
SQLA[1] = '[["LastName", "FirstName"], ["Adams", "Andrew"], ["Edwards", "Nancy"], ["Peacock", "Jane"], ["Park", "Margaret"], ["Johnson", "Steve"], ["Mitchell", "Michael"], ["King", "Robert"], ["Callahan", "Laura"]]'


# display employee id, last name and first name data for all employees and rename columns (EmployeeId renamed Staff ID,  FirstName renamed First Name and LastName renamed Last Name) 
SQLQ[2] = "SELECT EmployeeId AS 'Staff ID', FirstName AS 'First Name', LastName AS 'Last Name' 
           FROM Employees;"
SQLA[2] = '[["Staff ID", "First Name", "Last Name"], [1, "Andrew", "Adams"], [2, "Nancy", "Edwards"], [3, "Jane", "Peacock"], [4, "Margaret", "Park"], [5, "Steve", "Johnson"], [6, "Michael", "Mitchell"], [7, "Robert", "King"], [8, "Laura", "Callahan"]]'


# display  LastName and FirstName data for employee with id = 2
SQLQ[3] = "SELECT LastName, FirstName 
           FROM Employees 
           WHERE EmployeeId=2;"
SQLA[3] = '[["LastName", "FirstName"], ["Edwards", "Nancy"]]'


# display all data for employees whose last name begins with �P�
SQLQ[4] = "SELECT * 
           FROM employees 
           WHERE employees.LastName LIKE'P%';"
SQLA[4] = '[["EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email"], [3, "Peacock", "Jane", "Sales Support Agent", 2, "1973-08-29 00:00:00", "01/04/2002", "1111 6 Ave SW", "Calgary", "AB", "Canada", "T2P 5M5", "+1 (403) 262-3443", "+1 (403) 262-6712", "jane@chinookcorp.com"], [4, "Park", "Margaret", "Sales Support Agent", 2, "1947-09-19 00:00:00", "03/05/2003", "683 10 Street SW", "Calgary", "AB", "Canada", "T2P 5G3", "+1 (403) 263-4423", "+1 (403) 263-4289", "margaret@chinookcorp.com"]]'


# display all invoice and customer details for invoice id 1
SQLQ[5] = "SELECT * 
           FROM invoices INNER JOIN customers ON invoices.CustomerId = customers.CustomerId 
           WHERE invoices.InvoiceId=1;"
SQLA[5] = '[["InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total", "CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId"], [1, 2, "2009-01-01 00:00:00", "Theodor-Heuss-Strabe 34", "Stuttgart", nil, "Germany", "70174", 1.98, 2, "Leonie", "Kohler", nil, "Theodor-Heuss-Strabe 34", "Stuttgart", nil, "Germany", "70174", "+49 0711 2842222", nil, "leonekohler@surfeu.de", 5]]'


# display invoice id, customer first name and last  name and total details for invoice id 1 and not using the JOIN keyword
SQLQ[6] = "SELECT invoices.InvoiceId, customers.FirstName, customers.LastName, invoices.Total 
           FROM invoices, customers 
           WHERE invoices.CustomerId = customers.CustomerId AND invoices.InvoiceId=1;"
SQLA[6] = '[["InvoiceId", "FirstName", "LastName", "Total"], [1, "Leonie", "Kohler", 1.98]]'


# display invoice id, customer first name and last  name, and support representative first name and last name for invoice id 1, and not using the JOIN keyword
SQLQ[7] = "SELECT invoices.InvoiceId, customers.FirstName, customers.LastName, employees.FirstName, employees.LastName 
           FROM invoices, customers, employees 
           WHERE invoices.CustomerId=customers.CustomerID AND customers.SupportRepId=employees.EmployeeId AND invoices.InvoiceId=1;"
SQLA[7] = '[["InvoiceId", "FirstName", "LastName", "FirstName", "LastName"], [1, "Leonie", "Kohler", "Steve", "Johnson"]]'


# display invoice id, customer first name and last  name and merge the name of the support representative as one column named �Support Contact� for invoice id 1 and not using the JOIN keyword
SQLQ[8] = "SELECT invoices.InvoiceId, customers.FirstName, customers.LastName, employees.FirstName||' '||employees.LastName AS 'Support Contact' 
           FROM invoices, customers, employees 
           WHERE invoices.CustomerId=customers.CustomerId AND customers.SupportRepId=employees.EmployeeId AND invoices.InvoiceId=1;"
SQLA[8] = '[["InvoiceId", "FirstName", "LastName", "Support Contact"], [1, "Leonie", "Kohler", "Steve Johnson"]]'


# display German customers first name, last name and country along with the merged name as one column named �Support Contact� who are supported by employee �Johnson� not using the JOIN keyword
SQLQ[9] = "SELECT customers.FirstName, customers.LastName, customers.Country, employees.FirstName||' '||employees.LastName AS 'Support Contact' 
           FROM customers, employees 
           WHERE customers.Country='Germany' AND customers.SupportRepId=employees.EmployeeId AND employees.LastName='Johnson';"
SQLA[9] = '[["FirstName", "LastName", "Country", "Support Contact"], ["Leonie", "Kohler", "Germany", "Steve Johnson"], ["Hannah", "Schneider", "Germany", "Steve Johnson"]]'


# display employee first and last name along with the number of customers they support for employee id 5, not using the JOIN keyword, and using the table alias e for employees and c for customers
SQLQ[10] = "SELECT e.FirstName, e.LastName, COUNT(*) 
            FROM customers c, employees e 
            WHERE c.SupportRepId=e.EmployeeId AND e.EmployeeId=5;"
SQLA[10] = '[["FirstName", "LastName", "COUNT(*)"], ["Steve", "Johnson", 18]]'


# display German customers last name and first name in descending order
SQLQ[11] = "SELECT customers.LastName, customers.FirstName 
            FROM customers 
            WHERE customers.Country='Germany' 
            ORDER BY customers.LastName DESC;"
SQLA[11] = '[["LastName", "FirstName"], ["Zimmermann", "Fynn"], ["Schroder", "Niklas"], ["Schneider", "Hannah"], ["Kohler", "Leonie"]]'


# display name of country and number of customers who are either German or Canadian in ascending order 
SQLQ[12] = "SELECT customers.Country, count (*) 
            FROM customers 
            WHERE customers.country='Germany' OR customers.country='Canada' 
            GROUP BY Country 
            ORDER BY customers.Country;"
SQLA[12] = '[["Country", "count (*)"], ["Canada", 8], ["Germany", 4]]'


# display  customers ids along with their total spend for tracks in ascending order spent for the first 9 invoices
SQLQ[13] = "SELECT customers.CustomerId, invoices.Total AS 'Total Spent' 
            FROM customers INNER JOIN invoices ON invoices.CustomerId=customers.CustomerId 
            WHERE invoices.InvoiceId<10 
            ORDER BY invoices.Total;"
SQLA[13] = '[["CustomerId", "Total Spent"], [37, 0.99], [38, 1.98], [40, 1.98], [2, 1.98], [42, 3.96], [4, 3.96], [8, 5.94], [14, 8.91], [23, 13.86]]'


# display customers ids along with their total spend for tracks in descending order spent for the invoices greater or equal to �45.
SQLQ[14] = "SELECT customers.CustomerId, SUM(invoices.Total) AS 'Total_Spent' 
            FROM customers INNER JOIN invoices ON invoices.CustomerId=customers.CustomerId 
            GROUP BY customers.CustomerId 
            HAVING Total_Spent>=45 
            ORDER BY Total_Spent DESC;"
SQLA[14] = '[["CustomerId", "Total_Spent"], [6, 49.620000000000005], [26, 47.620000000000005], [57, 46.62], [45, 45.62], [46, 45.62]]'


# display last and first names, job title and date hired of employees hired after 2003 
SQLQ[15] = "SELECT employees.LastName, employees.FirstName, employees.Title, employees.HireDate AS 'Date' 
            FROM employees 
            WHERE SUBSTRING(HireDate,-4)>='2004';"
SQLA[15] = '[["LastName", "FirstName", "Title", "Date"], ["King", "Robert", "IT Staff", "02/01/2004"], ["Callahan", "Laura", "IT Staff", "04/03/2004"]]'


# display last and first names, job title and date hired of employees hired during 2002; 
SQLQ[16] = "SELECT employees.LastName, employees.FirstName, employees.Title, employees.HireDate AS 'Date' 
            FROM employees 
            WHERE employees.HireDate LIKE '%2002' 
            GROUP BY employees.HireDate 
            ORDER BY employees.LastName;"
SQLA[16] = '[["LastName", "FirstName", "Title", "Date"], ["Adams", "Andrew", "General Manager", "14/08/2002"], ["Edwards", "Nancy", "Sales Manager", "01/05/2002"], ["Peacock", "Jane", "Sales Support Agent", "01/04/2002"]]'


# display employee first, last names and job title who have other employees reporting to them 
SQLQ[17] = "SELECT E.LastName, E.FirstName, E.Title 
            FROM employees E, employees R 
            WHERE E.EmployeeId=R.ReportsTo 
            GROUP BY E.EmployeeId;"
SQLA[17] = '[["LastName", "FirstName", "Title"], ["Adams", "Andrew", "General Manager"], ["Edwards", "Nancy", "Sales Manager"], ["Mitchell", "Michael", "IT Manager"]]'


# display a column called �'Customers Reporting to Managers� containing the number of employees who have other employees reporting to them and who also have customers to support  
SQLQ[18] = "SELECT COUNT(employees.EmployeeId) AS 'Customers Reporting to Managers' 
            FROM employees INNER JOIN customers ON employees.EmployeeId=customers.SupportRepId 
            WHERE employees.EmployeeId=employees.ReportsTo;"
SQLA[18] = '[["Customers Reporting to Managers"], [0]]'


# display employees last name, first name and job title who have employees who report to them who themselves have other employees who report to them. 
SQLQ[19] = "SELECT employees.LastName, employees.FirstName, employees.Title 
            FROM employees 
            WHERE employees.ReportsTo IS NULL AND employees.Title LIKE ('%Manager');"
SQLA[19] = '[["LastName", "FirstName", "Title"], ["Adams", "Andrew", "General Manager"]]'


# display the last name, first name and title of employees who do not report to another employee
SQLQ[20] = "SELECT employees.LastName, employees.FirstName, employees.Title 
            FROM employees 
            WHERE employees.ReportsTo IS NULL;"
SQLA[20] = '[["LastName", "FirstName", "Title"], ["Adams", "Andrew", "General Manager"]]'


# display artist id, their name and their number of albums if produced more than 10.
SQLQ[21] = "SELECT artists.ArtistId, artists.Name, COUNT(albums.AlbumId) AS 'Number_of_Albums' 
            FROM artists INNER JOIN albums ON albums.ArtistId=artists.ArtistId 
            GROUP BY artists.ArtistId 
            HAVING Number_of_Albums>10;"
SQLA[21] = '[["ArtistId", "Name", "Number_of_Albums"], [22, "Led Zeppelin", 14], [58, "Deep Purple", 11], [90, "Iron Maiden", 21]]'


# display album id and title produced by AC/DC using a nested query.
SQLQ[22] = "SELECT albums.AlbumId, albums.Title 
            FROM albums 
            WHERE albums.ArtistId = (SELECT artists.ArtistId FROM artists WHERE artists.Name='AC/DC');"
SQLA[22] = '[["AlbumId", "Title"], [1, "For Those About To Rock We Salute You"], [4, "Let There Be Rock"]]'


# display all invoice id, customer id whose total invoice is greater than the average price, and show by how much their price is greater than average where prices differ by more than �15.
SQLQ[23] = "SELECT invoices.InvoiceId, invoices.CustomerId, invoices.Total-(SELECT AVG(invoices.Total) FROM invoices) AS 'priceDiff' 
            FROM invoices 
            GROUP BY invoices.InvoiceId 
            HAVING priceDiff>15;"
SQLA[23] = '[["InvoiceId", "CustomerId", "priceDiff"], [96, 45, 16.208058252427175], [194, 46, 16.208058252427175], [299, 26, 18.208058252427175], [404, 6, 20.208058252427175]]'


# display employees id first name, last name and title who support companies sorted by lastname and using the reserve EXIST word
SQLQ[24] = "SELECT employees.EmployeeId, employees.FirstName, employees.LastName, employees.Title 
            FROM employees 
            WHERE EXISTS (SELECT employees.EmployeeId FROM employees WHERE employees.EmployeeId<>employees.ReportsTo)
            AND employees.Title LIKE '%Support%' 
            ORDER BY employees.LastName;"
SQLA[24] = '[["EmployeeId", "FirstName", "LastName", "Title"], [5, "Steve", "Johnson", "Sales Support Agent"], [4, "Margaret", "Park", "Sales Support Agent"], [3, "Jane", "Peacock", "Sales Support Agent"]]'


# display tracks which exist on a Grunge playlist but no invoice using reserve EXCEPT word
SQLQ[25] = "SELECT playlist_track.TrackId 
            FROM playlist_track 
            INNER JOIN playlists ON playlist_track.PlaylistId=playlists.PlaylistId AND playlists.Name='Grunge' 
            EXCEPT 
            SELECT invoice_items.TrackId 
            FROM invoice_items, playlist_track 
            WHERE invoice_items.TrackId<>playlist_track.TrackId;"
SQLA[25] = '[["TrackId"], [52], [2005], [2007], [2010], [2194], [2198], [2206], [3367]]'


# display playlist id, track id and track name of playlists which contain  only one track
SQLQ[26] = "SELECT playlists.PlaylistId, playlist_track.TrackId, tracks.Name 
            FROM playlists 
            INNER JOIN playlist_track ON playlist_track.PlaylistId=playlists.PlaylistId 
            INNER JOIN tracks ON tracks.TrackId=playlist_track.TrackId 
            GROUP BY playlists.PlaylistId 
            HAVING COUNT(playlist_track.TrackId)=1;"
SQLA[26] = '[["PlaylistId", "TrackId", "Name"], [9, 3402, "Band Members Discuss Tracks from \"Revelations\""], [18, 597, "Now\'s The Time"]]'


# display all artists id and their names, the number of albums produced containing the genre �Soundtrack� using left joins only
SQLQ[27] = "SELECT albums.ArtistId, artists.Name, COUNT(albums.ArtistId), genres.Name 
            FROM ((albums LEFT JOIN artists ON albums.ArtistId=artists.ArtistId) 
            LEFT JOIN tracks ON tracks.AlbumId=albums.AlbumId) 
            LEFT JOIN genres ON tracks.genreId=genres.GenreId 
            GROUP BY albums.ArtistId 
            HAVING genres.Name='Soundtrack';"
SQLA[27] = '[["ArtistId", "Name", "COUNT(albums.ArtistId)", "Name"], [27, "Gilberto Gil", 32, "Soundtrack"], [116, "Passengers", 14, "Soundtrack"], [275, "Philip Glass Ensemble", 1, "Soundtrack"]]'


db = SQLite3::Database.new(DbName)
db.results_as_hash = false
sqlnum = 0
sqlnum = SQLQ.size 
puts "Checking #{sqlnum} SQL statements."

for i in 0..sqlnum-1 do
	if SQLQ[i] != "" then
		results = db.execute2(SQLQ[i])
		puts "#{i}) Actual:   " + results.inspect
	end
	puts "#{i}) Expected: " + SQLA[i]
	if results.inspect == SQLA[i]
		puts "Match exists between expected SQLData and actual database data."
		correct = correct + 1
	else
		puts "No match exists between expected SQLData and actual database data."
	end
end
puts "Result: #{correct} out of #{sqlnum} correct."
