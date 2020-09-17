# =====================================================
# === SQL NOTES =======================================
# === By: Jon Harris ==================================
# === Date: 09-16-20 ==================================
# =====================================================

# Important MySQL operations
	SELECT 			# extracts data from database
	UPDATE 			# updates data
	DELETE 			# deletes data
	INSERT INTO 	# inserts new data
	CREATE DATABASE # creates new database
	ALTER DATABASE  # modifies existing database
	CREATE TABLE 	# creates new table in existing database
	ALTER TABLE 	# modifies existing table
	DROP TABLE 		# deletes table
	CREATE INDEX 	# creates an index (search key)
	DROP INDEX 		# deletes an index

# Commenting in MySQL
	# single line comment

	-- single line comment
	
	/* Multiple line comment */
		SELECT CustomerName, /*City,*/ Country
		FROM Customers

		SELECT * FROM Customers WHERE (CustomerName LIKE 'L%'
		OR CustomerName LIKE 'R%' /*OR CustomerName LIKE 'S%'
		OR CustomerName LIKE 'T%'*/ OR CustomerName LIKE 'W%')
		AND Country='USA'
		ORDER BY CustomerName;

# =====================================================
# ================== MySQL Operators ==================
# =====================================================

# Arithmetic Operators
	+ # add
	- # subtract
	* # multiply
	/ # divide
	% # modulus [remainder] (6%2=0; 7%5=2)

# Bitwise Operators
	& # Bitwise AND
	| # bitwise OR
	^ # bitwise exclusive OR (either/or, but not both)

# Compound Operators
	+= 	# add equals
	-= 	# subtract equals
	*= 	# multiply equals
	/= 	# divide equals
	%= 	# modulus equals
	&= 	# bitwise AND equals
	|*= # bitwise OR equals
	^-= # bitwise exclusive equals



# =====================================================
# ==================== Basic MySQL ====================
# =====================================================

# Data Types
	INTEGER 	# numerical, no decimals
	FLOAT 		# numerical, with decimals
	BOOLEAN 	# TRUE or FALSE
	DATE 		# format YYYY-MM-DD
	DATETIME    # format YYYY-MM-DD HH:MI:SS
	TIMESTAMP 	# format YYYY-MM-DD HH:MI:SS
	YEAR		# format YYYY or YY
	CHAR() 		# stores strings in fixed character length x, INCLUDING spaces
	VARCHAR() 	# stores strings up to length x, INCLUDING spaces

# String Manipulation Functions
	LOWER() or LCASE() 						# return string in lowercase
	UPPER(col1) or UCASE() 					# return string in upper clase
	CHAR_LENGTH(col1)						# return number of characters in a string
	LEFT(col1, n) 							# return leftmost number of characters, n
	RIGHT(col1, n)							# return rightmost number of chars, n
	SUBSTR(col1, m, n)						# return number of characters (n) starting at the m-th position
	LTRIM(col1)								# return string with leading spaces remove
	RTRIM(col1)								# return string with trailing spaces remove
	TRIM(col1)								# return string with leading/trailing spaces removed
	REPLACE(col1, s_to_find, s_to_replace)	# replaces all occurarences of a substring within a string with a new substring
	CONCAT(string1, string2, ...)			# return combination of string inputs (NO SEPARATOR)
	CONCAT('sep',string1, string2,...)		# return combination of strings with separator

# Date Manipulation Functions
	CURRENT_DATE()  				# return current date
	CURRENT_TIME()					# return current time
	DATE(col1)						# extract date part of a date/datetime expression
	DAY(col1)						# extract day of month (1-31)
	DAYOFWEEK(col1)					# extract weekday index 
	MONTH(col1)						# extract month
	YEAR(col1)						# extract year
	DATE_ADD(col1, INTERVAL n UNIT)	# adds interval n units (DAY, MONTH, YEAR)

# Basic table searches and manipulations 

	# SELECT statement - to select data
		SELECT *
		FROM table;

		SELECT col1, column2 
		FROM table;

	# SELECT DISTINCT statement - to select unique values
		SELECT DISTINCT col1
		FROM table;

	# WHERE clause - to filter records (observations) 
		SELECT *
		FROM table
		WHERE condition;

		# Logical operators - returns TRUE or FALSE
			<> 						# filter if record not equal to value
			!= 						# filter if record not equal to value
			LIKE 					# filter if record matches pattern (faster)
			REGEXP (RLIKE)			# filter if record matches subtext pattern (slower)
			BETWEEN val1 AND val2 	# filter records between range of values (num and char)
			IN 						# filter records found in list
			AND 					# fitler records by multiple conditions
			OR 						# filter if record satisfies either or both conditions
			XOR 					# filter if either condition met, BUT NOT BOTH
			NOT 					# filter if condition NOT met
			IS NULL 				# filter if record null 
			IS NOT NULL 			# filter if record NOT null 

		# LIKE operator - to search for specified pattern in column
			# % = zero, one, or multiple characters
			# _ = one character
				LIKE 'a%'      # find values that STARTS with 'a'
				LIKE '%a'      # find values that ENDS with 'a'
				LIKE '%or%'    # find values that have 'or' in any position
				LIKE 'a%o'     # find values that starts with A and ends with O
				LIKE 'a__'     # find values that starts with A and atleast 3 characters
				LIKE 'h[oa]t'  # finds values with either O or A (ie. hat or hot)
				LIKE 'h[^oa]t' # finds values without O or A
				LIKE 'c[a-d]t' # find range of characters

		# RLIKE operator - to search for specified subtext in column
			# REXEXP syntax just like Python
				RLIKE '^a'	     # match beginning of string
				RLIKE 'a$'		 # match end of a string
				RLIKE '.'		 # match any character
				RLIKE 'a*'		 # match sequence 0+ times
				RLIKE 'a+'		 # match sequence 1+ times
				RLIKE 'a?'		 # match sequence 0 or 1 times
				RLIKE 'abc|de'   # match either sequence
				RLIKE '(abc)*'	 # match sequence 0+ times
				RLIKE '(a){m,n}' # match sequence m to n times

			# Wildcard Characters - included in LIKE and RLIKE (REXEXP)
				*	# represents 0+ characters
				?	# represents single character
				[]	# represents any single character within brackets
				^	# represents any character NOT in brackets
				-	# represents a range of characters
				_	# represents any single character

		# EXIST operator - to test existence of record in subquery using WHERE clause
			SELECT *
			FROM table
			WHERE EXISTS (SELECT col1 
						  FROM table 
						  WHERE condition)

			#Ex: Return suppliers, if any, with product price <20$
			SELECT SupplierName
			FROM Suppliers AS s
			WHERE EXISTS (SELECT ProductName 
						  FROM Products AS p 
						  WHERE p.SupplierID = s.supplierID AND Price < 20)

		# IN operator - to specify multiple values in WHERE clause
			SELECT *
			FROM table
			WHERE col1 IN (val1, val2, ...); #shorthand for multiple OR conditions

			SELECT *
			FROM table1
			WHERE col1 IN (SELECT col2
						   FROM table2); #values found in results of SELECT statement

		# BETWEEN operator - to select values within/outside range
			SELECT *
			FROM table
			WHERE col1 BETWEEN val1 AND val2; #inside range

			SELECT *
			FROM table
			WHERE col1 NOT BETWEEN val1 AND val2; #outside range

	# ORDER BY statement - to sort result-set in asc or desc order
		# Default is ASC
			# Text - A, B, C, ...
			# Number - 1, 2, 3, ...
		SELECT *
		FROM table
		ORDER BY col1; #default is ascending order

		SELECT *
		FROM table
		ORDER BY col1 DESC, col2 ASC;

	# LIMIT clause - to specify the number of records to return
		Select *
		FROM table
		WHERE condition
		LIMIT number; #return n observations



# =====================================================
# ============= Aggregate MySQL Functions =============
# =====================================================

# Aggregate functions return single value based on calculation performed

	# MIN() functions - returns smallest value of column
		SELECT MIN(col1)  
		FROM table;

	# MAX() functions - returns largest value of column
		SELECT MAX(col1)  
		FROM table;

	# COUNT() function - returns number of observations
		SELECT COUNT(col1)
		FROM table;

	# AVG() function - returns average value of NUMERIC column
		SELECT AVG(col1)
		FROM table;

	# SUM() function - returns total sum value of NUMERIC column
		SELECT SUM(col1)
		FROM table;

# GROUP BY statement - aggregates records by same value
	SELECT COUNT(col1), col2 #aggregate functions often used
	FROM table
	WHERE condition
	GROUP BY col1; #return how many unique val in col1, per col2

	#Ex: What is number of orders per shipping company?
		SELECT s.ShipperName, COUNT(o.orderID) AS n_orders
		FROM orders AS o
		LEFT JOIN shippers AS s
		ON o.shipperID = s.shipperID
		GROUP BY ShipperName;

# HAVING clause - to filter groups (WHERE filters records)
	SELECT *
	FROM table
	WHERE condition
	GROUP BY col1
	HAVING condition;

	#Ex: List number of customers in each country with >5 customers
		SELECT Country, COUNT(CustomerID)
		FROM Customers
		GROUP BY Country
		HAVING COUNT(CustomerID) > 5
		ORDER BY COUNT(CustomerID) DESC;

	#Ex: list if employees Davolio or Fuller have registered more than 25 orders
		SELECT e.LastName, COUNT(o.OrderID) AS n_orders
		FROM Orders AS o
		INNER JOIN Employees as e
		ON o.EmployeeID = e.EmployeeID
		WHERE LastName IN ('Davolio', 'Fuller')		# filter out only Davolio or Fuller records
		GROUP BY LastName							# group by employee names
		HAVING COUNT(o.OrderID) > 25;				# filter out names (ie. groups) with >25 orders

# ANY operator - returns TRUE if ANY subquery values meet the condition
	# Used with a WHERE or HAVING clause 
	# Returns TRUE if *any* subquery values (either records or groups) meet condition
	SELECT *
	FROM table1
	WHERE col1 <operator> ANY(SELECT col1 
					 		  FROM table2 
					 		  WHERE condition);

	# <operator> must be standard compairons operator
		=, <> or !=, >, >=, <, <=

	# Ex: List product names if quantity sold >99
		SELECT ProductName
		FROM Products
		WHERE ProductID = ANY(SELECT Product ID 
							  FROM OrderDetails 
							  WHERE Quantity>99);
		# returns TRUE and lists product names if ANY records in OrderDetails table have quantity > 99

# ALL operator - returns TRUE if ALL subquery values meet the condition
	# Used with a WHERE or HAVING clause 
	# Returns TRUE if *all* subquery values (either records or groups) meet condition
	SELECT *
	FROM table1
	WHERE col1 <operator> ALL(SELECT col1 
					 		  FROM table2 
					 		  WHERE condition);

	# Ex: List product names if all records in OrderDetails table has quantity = 10
		SELECT ProductName
		FROM Products
		WHERE ProductID = ALL(SELECT Product ID 
							  FROM OrderDetails 
							  WHERE Quantity=10);
		# returns FALSE because not ALL records in OrderDetails table has quantity = 10  



# =====================================================
# ====================== Aliases ======================
# =====================================================

# Aliases are used to give a table, or a column in a table, a temporary name
# May be useful when:
	# More than one table involved in a query
	# Functions are used in the query
	# Column names are big and not very readable
	# 2+ columns are combined together

# Basic Syntax
	SELECT col1 AS alias # column alias
	FROM table

	SELECT *
	FROM table AS alias  # table alias

# Use when 2+ columns are combined together
	SELECT CustomerName, CONCAT(Address,
								',',
								PostalCode,
								',',
								City,
								',',
								Country) AS Address
	FROM Customers;
	# Output: Alfreds Futterkiste 	Obere Str. 57, 12209 Berlin, Germany 

# Use when a new column is created
	# Ex: Find number of employees making max earnings (salaary*months)
	SELECT salary * months AS earnings, COUNT(*)
	FROM Employee
	GROUP BY earnings
	ORDER BY earnings DESC
	LIMIT 1;

# Use when more than one table used
	SELECT o.OrderID, o.OrderDate, c.CustomerName
	FROM Customers AS c, Orders AS o
	WHERE c.CustomerName='Around the Horn' AND c.CustomerID=o.CustomerID;
	# CustomerName not found in Orders table





# =====================================================
# =================== JOINING TABLES ==================
# =====================================================

# JOIN clause used to combine rows from two+ tables based on related column between them (ie. key)
	# Ex: Orders and Customers (CustomerID field same in both tables)
		# Orders table - OrderID, CustomerID, OrderDate
		# Customers table - CustomerID, CustomerName, ContactName, Country

	# INNER JOIN - returns records matching values in both tables
		SELECT *
		FROM table1
		INNER JOIN table2
		ON table1.col1 = table2.col2; #only records with matching values in col1 and col2

	# LEFT JOIN - returns all records from LEFT table; matched records from RIGHT table
		SELECT *
		FROM table1
		LEFT JOIN table2
		ON table1.col1 = table2.col2; #only matching values in TABLE2 returned

	# RIGHT JOIN - returns matched records from LEFT table; all records from RIGHT table
		SELECT *
		FROM table1
		RIGHT JOIN table2
		ON table1.col1 = table2.col2; #only matching values in TABLE1 returned

	# FULL JOIN - returns all records regardless of matching values
		# MySQL doesn't support FULL JOIN, must combine LEFT, RIGHT, and UNION joints
		SELECT *
		FROM table1
		LEFT JOIN table1 ON table2.col1 = table1.col1
		UNION
		SELECT *
		FROM table1
		RIGHT JOIN table1 on table2.col1 = table1.col1

	# SELF JOIN - returns records joined with itself
		SELECT *
		FROM table1 AS a
		INNER JOIN table1 AS b
		ON a.col1 = b.col2

# UNION clause - to combine result-set of 2+ SELECT statements
	# Conditions:
		# SELECT statements must have same number of columns
		# Columns must have similar data types
		# Columns in each SELECT statement must be in same order
	# 'Stacks' tables on top of each other
		# JOIN increases number of columns

	SELECT col1 
	FROM table1
	UNION
	SELECT col1
	FROM table2

	# Possible to create new column when stacking tables
		SELECT 'Customer' AS Type, ContactName, City, Country #new column 'Type'
		FROM Customers
		UNION 
		SELECT 'Supplier', ContactName, City, Country #column 'Type' filled in with 'Supplier'
		FROM Suppliers

		# Ex: List shortest and longest city names, order by city if tie
			(SELECT CITY, CHAR_LENGTH(CITY) AS len
			 FROM STATION
			 ORDER BY CHAR_LENGTH(CITY) ASC, CITY
			 LIMIT 1)
			UNION
			(SELECT CITY, CHAR_LENGTH(CITY)
			 FROM STATION
			 ORDER BY CHAR_LENGTH(CITY) DESC, CITY
			 LIMIT 1);

# UNION ALL clause - to combine only distinct values 
	SELECT col1
	FROM table1
	UNION ALL
	SELECT col1
	FROM table2



# =====================================================
# ====== MODIFYING TABLES -- CREATING NEW TABLES ======
# =====================================================

# Creating Tables
	# CREATE TABLE - create new table in existing database
		CREATE TABLE new_table (col1 datatype,
							    col2 datatype,
							    col3 datatype, ...);

		CREATE TABLE new_table 
		AS
			SELECT col1, col2, ...
			FROM existing_table
			WHERE conditions;
		# creates new table using existing table

	# Adding constraints to columns in new table
		CREATE TABLE new_table(
			col1 datatype constraint,
			col2 datatype constraint,
			col3 datatype constraint, ...);

		# Constraints used specify rules for data in table
			NOT NULL 	# ensure column cannot have null value
			UNIQUE  	# ensures all column values are different
			PRIMARY KEY # creates primary key for table (must be unique, non-null)
			FOREIGN KEY # uniquely identifies a row/record in another table (referencing key)
			CHECK 		# ensures all values satisfy specific condition (ex: CHECK >5)
			DEFAULT 	# sets default value for column when no value is specified
			INDEX  		# used to create and retrieve data from the database very quickly

	# AUTO INCREMENT field - generates unique (sequential) number when new record inserted into table
		CREATE TABLE Persons( 
			PersonID int NOT NULL AUTO_INCREMENT,   # creates index ID
			LastName varchar(255) NOT NULL,			# each record MUST have a last name
			FirstName varchar(255),					# first name optional (can be null)
			Age int,
			PRIMARY KEY (PersonID)					# sets PersonID as primary key (must be unique and non-null)
		);

# Modifying Tables
	# ALTER TABLE - used to add, dlete, or modify columns in existing table
		ALTER TABLE table1
		ADD col1 datatype; 			#adds column

		ALTER TABLE table1
		DROP COLUMN col1; 			# remove column

		ALTER TABLE table1
		MODIFY COLUMN col1 datatype; # change datatype of column

# Modifying Records within Tables
	# INSERT INTO statement - to insert new records in an existing table
		INSERT INTO table (col1, col2, col3, ...)
		VALUES (val1, val2, val3, ...); #will insert null if val missing

		INSERT INTO table #don't list col names if adding values into all cols
		VALUES (val1, val2, val3, ...);

	# UPDATE statement - to modify existing records in a table
		UPDATE table
		SET col1 = val1, col2 = val2, ...
		WHERE condition; #must include, else all will be updated

	# DELETE statement - to delete existing records in a table
		DELETE 
		FROM table
		WHERE condition; #must include, else will delete all records

	# SELECT INTO statement - copies selected items from one table into a new table
		# Basic Syntax
			SELECT *
			INTO NewTable [IN externalDB]
			FROM OldTable;
			# Copies all columns into a new table created in external database

			SELECT *
			INTO NewTable
			FROM OldTable
			WHERE 1 = 0; 
			# Create a new, empty table using schema (ie. fields) of another table

		# Ex: copy only german customers into a new table
			SELECT * 
			INTO CustomersGermany
			FROM Customers
			WHERE Country = 'Germany'

		# Ex: copy data from more than one table into new table
			SELECT c.CustomerName, o.OrderID
			INTO CustomersOrdersBackup
			FROM Customers AS c
			LEFT JOIN Orders AS o
			ON c.CustomerID = o.CustomerID

	# INSERT INTO SELECT statement - copies data from one table and inserts into existing table
		# Requirements:
			# Requires that data types in source and target tables match
			# Existing records in the target table are unaffected

		# Basic Syntax:
			INSERT INTO table2 (col1, col2, col3, ...)
			SELECT col1, col2, col3, ... 
			FROM table1
			WHERE condition;

		# Ex: Assign all employees living in Bangalore to the project p01
			# employeeaddress - id, employeeid, addresstype, addressline1
			# projectemployee - empty
			INSERT INTO projectemployee(Projectid, EmployeeID)
			SELECT 'p01', ea.EmployeeID
			FROM employeeaddress AS ea
			WHERE ea.city = 'Bangalore';
			# populates projectemployee table with ProjectID, and EmployeeID

	# CASE statement - nested if-else-then statement to update values
		# Basic Syntax:
			SELECT col1, col2
			CASE
				WHEN col2 condition THEN return1
				WHEN col2 condition THEN return2
				ELSE return3
			END AS col3 #returns col3 in addition to col1 and col2
			FROM table

		# Ex: Order customers by City, or country if city=NULL
			SELECT CustomerName, City, Country
			FROM Customers
			ORDER BY (CASE
						 WHEN City IS NULL THEN Country
						 ELSE City)
					  END);

	# IFNULL() function [MySQL only] - return alternative value if an expression is NULL
		# Ex: 
			SELECT ProductName, 
				   UnitPrice*( UnitsInStock + IFNULL(UnitsOnOrder,0) ) #can't multiply NULL values
			FROM Products;

	# COALESCE() function - return 1st non-NULL alternative value in list if an expression is NULL
		# Ex:
			SELECT ProductName, 
				   UnitPrice*( UnitsInStock + COALESCE(UnitsOnOrder,0) ) #can't multiply NULL values
			FROM Products;

# Delete Tables
	# DROP TABLE - drops existing table in a database
		DROP TABLE table_name

	# TRUNCATE TABLE - drops data inside table, but keeps table
		TRUNCATE TABLE table_name


# Creating/Modifying Databases
	# CREATE DATABASE - to create a new SQL database
		CREATE DATABASE new_database;

	# DROP DATABASE - to remove existing SQL database
		DROP DATABASE database_name;

	# BACKUP DATABASE - to backup existing SQL database
		BACKUP DATABASE database_name
		TO DISK = 'filepath';

		BACKUP DATABASE database_name
		TO DISK = 'filepath'
		WITH DIFFERENTIAL; -- only backups part of database that has changed since last backup



# =====================================================
# ================ CREATING PROCEDURES ================
# =====================================================

# CREATE PROCEDURE - prepared SQL code to save and use repeatedly in future
	# Basic Syntax:
		CREATE PROCEDURE procedure_name
		AS 
		sql_statement
		GO;

		EXEC procedure_name;

		# Allow input parameters into procedure
		CREATE PROCEDURE procedure_name @col1_input datatype, 
										@col2_input datatype
		AS
			SELECT * FROM table1
			WHERE col1 = @col1 AND col2 = @col2 
		GO;

	# Ex: Create stored procedure to select all records from customer table
		CREATE PROCEDURE SelectAllCustomers
		AS
		SELECT * FROM Customers
		GO;

		EXEC SelectAllCustomers; #executes saved procedure
































