USE sakila;
GO

DROP VIEW IF EXISTS dbo.vw_customer;
DROP VIEW IF EXISTS dbo.vw_store;
GO

CREATE VIEW dbo.vw_customer AS
--ALTER VIEW dbo.vw_customer AS
    SELECT c.customer_id [cus id], c.last_name [cus last name], c.first_name [cus first name],
        ci.city[cus city], cty.country [cus country],
        c.store_id [sto id]
    FROM dbo.customer AS c

    --work out inner joins for customer -> address -city - >country
    INNER JOIN dbo.address AS a ON c.address_id = a.address_id
    INNER JOIN dbo.city AS ci ON a.city_id = ci.city_id
    INNER JOIN dbo.country AS cty ON ci.country_id = cty.country_id;
GO

CREATE VIEW dbo.vw_store AS
--ALTER VIEW dbo.vw_store AS
    SELECT s.store_id [store id], ci.city [store city], cty.country [store country]
    FROM dbo.store AS s

    --work out inner joins for store -> address -> city -> country
    INNER JOIN dbo.address AS a ON s.address_id = a.address_id
    INNER JOIN dbo.city AS ci ON a.city_id = ci.city_id
    INNER JOIN dbo.country AS cty ON ci.country_id = cty.country_id;
GO

SELECT TOP 5 * FROM dbo.vw_customer;
SELECT * FROM dbo.vw_store;
GO


