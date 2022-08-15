# Simple queries
    SELECT *
    FROM Families f
    WHERE f.id = "AndersenFamily"

    SELECT {"Name":f.id, "City":f.address.city} AS Family
    FROM Families f
    WHERE f.address.city = f.address.state

    SELECT c.givenName
    FROM Families f
    JOIN c IN f.children
    WHERE f.id = 'WakefieldFamily'
    ORDER BY f.address.city ASC

# Arrays
SELECT [f.address.city, f.address.state] AS CityState
FROM Families f

# Iteration
SELECT *
FROM Families.children

SELECT *
FROM c IN Families.children

# Joins
    SELECT f.id
    FROM Families f
    JOIN f.children

    SELECT f.id
    FROM Families f
    JOIN c IN f.children

   SELECT VALUE f
    FROM Families f
    JOIN c IN f.children
    WHERE f.id = 'WakefieldFamily'
    ORDER BY f.address.city ASC

# Subqueries

SELECT Count(1) AS Count
FROM c
JOIN (SELECT VALUE t FROM t IN c.tags WHERE t.name = 'infant formula')
JOIN (SELECT VALUE n FROM n IN c.nutrients WHERE n.nutritionValue > 0 AND n.nutritionValue < 10)
JOIN (SELECT VALUE s FROM s IN c.servings WHERE s.amount > 1)

SELECT TOP 5 (SELECT VALUE Concat('id_', f.id)) AS id
FROM food f

SELECT TOP 5
    f.id,
    (SELECT VALUE Count(1) FROM n IN f.nutrients WHERE n.units = 'mg'
) AS count_mg
FROM food f

SELECT TOP 5 f.id, (
    SELECT Count(1) AS count, Sum(n.nutritionValue) AS sum
    FROM n IN f.nutrients
    WHERE n.units = 'mg'
) AS unit_mg
FROM food f
