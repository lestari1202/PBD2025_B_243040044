--menampilkan semua data pada tabel produk
SELECT *
FROM Production.Product;

--menampilkan Name, ProductNumber, dan ListPrice
SELECT Name, ProductNumber, ListPrice
FROM production.Product;

--menampilkan data menggunakan alias kolom
SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual'
FROM Production.Product;

--menampilkan HargaBaru = ListPrice * 1.1
SELECT Name, ListPrice, (ListPrice * 1.1) AS HargaBaru
FROM Production.Product;

--menampilkan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber + ')' AS ProdukLengkap
FROM Production.Product;

--Filterisasi data
--menampilkan produk yang berwarna 'red'
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'red';

--menampilkan produk yang ListPrice lebih dari 1000
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > 1000;

--menampilkan produk yang berwarna black Dan List pricenya lebih dari 500
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color = 'black' AND ListPrice > 500;

--menampilkan produk yang berwarna red, blue, ATAU black
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color IN ('red', 'blue', 'black');

--menampilkan produk yang namanya mengandung kata 'Road'
--persen bagian depan di hapus maka akan tampil nama road dibagian depan saja
SELECT Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%Road%';

--Agregasi dan pengelompokkan
--menghitung total baris
SELECT COUNT(*) AS TotalProduk
FROM Production.Product;

--menampilkan warna produk dan jumlahnya
SELECT Color, COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

--menampilkan ProductID, jumlah OrderQty, dan rata2 UnitPrice
SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT *
FROM Sales.SalesOrderDetail;

--Menampilkan data dengan grouping lebih dari satu kolom
SELECT Color, Size, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;

SELECT *
FROM Production.Product;

--filter hasil agregasi
--menampilkan warna produk yang jumlahnya lebih dari 2
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) > 2;

--menampilkan warna produk yang ListPricenya > 500 dan jumlahnya < 10
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING COUNT(*) < 10;

--Menampilkan ProductID yang jumlah OrderQtynya lebih dari 10
SELECT ProductID, SUM(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;

--menampilkan SpecialOfferID yang rata2 OrderQtynya lebih dari 2
--AVG menghitung rata rata orderqty
--AS Menampilkan kolom baru
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING AVG(OrderQty) > 2;

--menampilkan warna yang ListPricenya lebih dari 3000 menggunakan MAX 
SELECT Color
FROM Production.Product
GROUP BY Color
HAVING MAX(ListPrice) > 3000;

--Advanced Select dan Order By 
--menampilkan JobTitle tanpa duplikat
SELECT DISTINCT JobTitle
FROM HumanResources.Employee;

SELECT JobTitle
FROM HumanResources.Employee;

--menampilkan 5 nama produk termahal
--DESC HARGA TERMAHAL, ASC harg PRODUK TERMURAH
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice ASC;

--OFFSET FETCH
SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 3 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0
GROUP BY Color
ORDER BY TotalNilaiStok DESC;

--TUGAS MANDIRI
--1. Menampilkan ProductID dan total uang yang didapat (LineTotal) dari produk 
SELECT ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

--2.Hanya hitung transaksi yang OrderQty (jumlah beli) >= 2.
SELECT ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 2
GROUP BY ProductID;

--3.Kelompokkan berdasarkan ProductID. 
SELECT ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

--4.Filter agar hanya menampilkan produk yang total uangnya (SUM(LineTotal)) di atas $50,000.
SELECT ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 50000;

--5.Urutkan dari pendapatan tertinggi. 
SELECT ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalUang DESC;

--6.Ambil 10 produk teratas saja. 
SELECT TOP 10 ProductID, SUM(LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY TotalUang DESC;