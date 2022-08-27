-- 1 ЗАДАНИЕ
-- Вывод автомобилей, которые были созданы на базе авто той же марки.
SELECT 
     Name AS Car 
FROM Cars 
WHERE BaseID IN
     (SELECT ID FROM Cars AS SubCars
      WHERE BrandID = Cars.BrandID)

-- 2 ЗАДАНИЕ
-- Вывод марок, которые содержат больше 3 автомобилей.
SELECT 
     (SELECT Name FROM Brands WHERE ID = Cars.BrandID) AS Brand
FROM Cars
GROUP BY BrandID
HAVING COUNT(ID) > 3

-- 3 ЗАДАНИЕ
-- Вывод марок с необходимой суммой на покупку всего модельного ряда.
SELECT 
     (SELECT Name FROM Brands WHERE ID = Cars.BrandID) AS Brand
     ,SUM(Price) AS 'Sum'
FROM Cars
GROUP BY BrandID

-- 4 ЗАДАНИЕ
-- Вывод двух стран с максимальной средней мощностью автомобилей.
SELECT TOP 2
     (SELECT Name FROM Countries WHERE ID = Brands.CountryID) AS Country
     ,AVG(Pow) AS 'Average power'
FROM Cars
LEFT JOIN Brands
ON Cars.BrandID = Brands.ID
GROUP BY Brands.CountryID
ORDER BY AVG(Pow) DESC

-- 5 ЗАДАНИЕ
-- Вывод списка самых дешевых автомобилей каждой марки.
SELECT 
     Name AS Car
     ,(SELECT Name FROM Brands WHERE ID = Cars.BrandID) AS Brand
FROM Cars
WHERE Price =
     (SELECT MIN(Price) 
      FROM Cars AS SubCars
      WHERE Cars.BrandID = SubCars.BrandID
      GROUP BY BrandID)