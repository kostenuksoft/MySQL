-- 1|2) =============================================================
	-- 2.1)

CREATE TABLE IF NOT EXISTS City (
    idCity INT AUTO_INCREMENT,
    NameCity CHAR(30),
    idCountry INT,
    District CHAR(30),
    PopulationCity INT,
	PRIMARY KEY (idCity),
    FOREIGN KEY (idCountry) REFERENCES Country(idCountry)
);
	-- 2.2) ================================================

CREATE TABLE IF NOT EXISTS CountryLanguage (
    idLanguage INT AUTO_INCREMENT,
    Language CHAR(30),
    IsOfficial ENUM('T', 'F'),
    Percentage DECIMAL(4, 1),
    idCountry INT,
    PRIMARY KEY (idLanguage),
    FOREIGN KEY (idCountry) REFERENCES Country(idCountry)
);

-- 3) ==================================================
-- ALTER TABLE Country 
-- DROP COLUMN Capital;
-- 4) =========================================================================
DELETE FROM Country;
DELETE FROM City;
DELETE FROM CountryLanguage;
	-- 4.1) ================================================
SET GLOBAL FOREIGN_KEY_CHECKS = 0;

INSERT INTO Country 
(idCountry, Name, Continent, Region, SurfaceArea, IndeptYear, Population, LifeExpectancy, GDP, LocalName, GovernmentForm, PoliticalSystem, GCR, CodeISO) VALUES
(1,'Норвегія', 'Європа', 'Північна Європа', 323802.00, 1905, 5378857, 82.3, 403.3, 'Norge', 'Конституційна монархія', 'Парламентська', 1.0, 'NO'),
(2,'Швеція', 'Європа', 'Північна Європа', 450295.00, 1523, 10327589, 82.4, 556.1, 'Sverige', 'Конституційна монархія', 'Парламентська', 1.0, 'SE'),
(3,'Данія', 'Європа', 'Північна Європа', 43094.00, 1849, 5818553, 81.3, 346.6, 'Danmark', 'Конституційна монархія', 'Парламентська', 1.0, 'DK'),
(4,'Фінляндія', 'Європа', 'Північна Європа', 338424.00, 1917, 5540720, 81.9, 276.7, 'Suomi', 'Республіка', 'Парламентська', 1.0, 'FI'),
(5,'Ісландія', 'Європа', 'Північна Європа', 103000.00, 1944, 366425, 83.1, 24.2, 'Ísland', 'Республіка', 'Парламентська', 1.0, 'IS'),
(6,'Чеська Республіка', 'Європа', 'Східна Європа', 78865.00, 1993, 10701777, 79.1, 245.2, 'Česká republika', 'Республіка', 'Парламентська', 1.0, 'CZ'),
(7,'Словаччина', 'Європа', 'Східна Європа', 49035.00, 1993, 5456362, 77.4, 106.5, 'Slovensko', 'Республіка', 'Парламентська', 1.0, 'SK'),
(8,'Португалія', 'Європа', 'Південна Європа', 92212.00, 1143, 10295909, 81.1, 237.9, 'Portugal', 'Республіка', 'Парламентська', 1.0, 'PT'),
(9,'Еквадор', 'Південна Америка', 'Західна Південна Америка', 283561.00, 1822, 17643060, 76.5, 108.4, 'Ecuador', 'Республіка', 'Президентська', 1.0, 'EC'),
(10,'Швейцарія', 'Європа', 'Західна Європа', 41285.00, 1291, 8654622, 83.4, 703.8, 'Schweiz', 'Конфедерація', 'Директорська', 1.0, 'CH'),
(11, 'Південна Корея', 'Азія', 'Східна Азія', 100210.00, 1948, 51780579, 82.8, 1693200.00, 'string', 'Республіка', 'Президентська', 1.0, 'KR');

    -- 4.2) ============================================


INSERT INTO City 
(idCountry, NameCity, District, PopulationCity) VALUES
(1,'Осло', 'Осло1', 634293),
(1,'Осло', 'Осло12', 634293),
(1,'Осло', 'Осло2', 634293),
(1,'Осло', 'Осло3', 634293),
(1,'Осло', 'Осло2', 634293),
(1,'Осло', 'Осло435', 634293),
(1,'Осло', 'Осло756', 634293),
(1,'Осло', 'Осло234', 634293),
(1,'Осло', 'Осло678', 634293),
(1,'Осло', 'Осло245', 634293),
(1,'Осло', 'Ослоsdf', 634293),
(1,'Осло', 'Ослоdsf', 634293),
(1,'Осло', 'Осло32232', 634293),
(1,'Осло', 'Ослоdgg', 634293),
(1,'Осло', 'Ослоjkh', 634293),
(1,'Осло', 'Ослоasd', 634293),
(1,'Осло', 'Ослоlkk', 634293),

(2,'Стокгольм', 'Стокгольм', 975551),
(3,'Копенгаген', 'Ховедстаден', 602481),
(4,'Гельсінкі', 'Уусімаа', 656229),
(5,'Рейкявік', 'Столичний регіон', 131136),

(6,'Прага', 'Прага', 1309000),
(6,'Прага', 'Прага1', 1309000),

(7,'Братислава', 'Братислава', 437725),
(8,'Лісабон', 'Лісабон', 504718),
(9,'Кіто', 'Пічінча', 2011388),
(10,'Берн', 'Берн', 133798);



	-- 4.3) =================================================================
INSERT INTO CountryLanguage 
(idCountry, Language, IsOfficial, Percentage) VALUES
(1,'Норвезька', 'T', 100.0),
(1,'Шведська', 'T', 100.0),
(1,'Данська', 'F', 100.0),
(4,'Фінська', 'T', 90.0),
(5,'Ісландська', 'T', 100.0),
(6,'Чеська', 'T', 96.0),
(6,'Словацька', 'T', 78.6),
(7,'Словацька', 'T', 78.6),
(8,'Португальська', 'T', 98.0),
(9,'Іспанська', 'T', 93.0),
(10,'Німецька', 'T', 63.0),
(10,'Французька', 'T', 22.7),
(10,'Італійська', 'T', 8.4),
(10,'Румунська', 'T', 0.5),
(11,'Корейська', 'T', 95.5);


-- 5) ===========================================================================


-- 5.1) 
SELECT c.Name, cl.Language
FROM Country c
JOIN CountryLanguage cl ON c.idCountry = cl.idCountry
WHERE c.Region = 'Північна Європа' AND cl.IsOfficial = 'T';


-- 5.2)
SELECT c.Name
FROM Country c
WHERE c.idCountry IN (
    SELECT cl.idCountry
    FROM CountryLanguage cl
    WHERE cl.Language IN ('Чеська', 'Словацька') AND cl.IsOfficial = 'T'
);

-- 5.3) 
SELECT c.Name
FROM Country c
WHERE NOT EXISTS (
    SELECT 1
    FROM CountryLanguage cl
    WHERE c.idCountry = cl.idCountry
);

-- 5.4)
SELECT DISTINCT c.Region
FROM Country c
WHERE EXISTS (
    SELECT 1
    FROM CountryLanguage cl
    WHERE c.idCountry = cl.idCountry AND cl.Language = 'Португальська'
);


-- 5.5)
SELECT c.Name, COUNT(DISTINCT ci.District) AS NumAdministrativeUnits
FROM Country c
JOIN City ci ON c.idCountry = ci.idCountry
GROUP BY c.Name;


-- 5.6)
SELECT SUM(c.Population * (cl.Percentage / 100)) AS KoreanSpeakingPopulation
FROM Country c
JOIN CountryLanguage cl ON c.idCountry = cl.idCountry
WHERE cl.Language = 'Корейська';

-- 5.7)
SELECT c.Name AS Capital, cl.Language, c.Population * (cl.Percentage / 100) AS PopulationSpeaking
FROM Country c
JOIN City ci ON c.idCountry = ci.idCountry
JOIN CountryLanguage cl ON c.idCountry = cl.idCountry
WHERE c.Name = 'Еквадор' AND ci.District = 'Пічінча';

-- 5.8)
SELECT c.Name, COUNT(DISTINCT ci.District) AS NumAdministrativeUnits
FROM Country c
JOIN City ci ON c.idCountry = ci.idCountry
WHERE c.Region = 'Північна Європа'
GROUP BY c.Name
HAVING COUNT(DISTINCT ci.District) >= 15;


-- 5.9)
SELECT c.Name
FROM Country c
WHERE c.idCountry IN (
    SELECT cl.idCountry
    FROM CountryLanguage cl
    GROUP BY cl.idCountry
    HAVING COUNT(DISTINCT cl.Language) = 2
)

UNION

SELECT c.Name
FROM Country c
WHERE c.idCountry IN (
    SELECT ci.idCountry
    FROM City ci
    GROUP BY ci.idCountry
    HAVING COUNT(DISTINCT ci.District) = 2
);


-- 5.10)
SELECT cl.Language
FROM CountryLanguage cl
JOIN Country c ON cl.idCountry = c.idCountry
GROUP BY cl.Language
HAVING 
	SUM(c.Population * (cl.Percentage / 100)) > 
    ALL 
(
    SELECT SUM(c.Population * (cl.Percentage / 100))
    FROM CountryLanguage cl
    JOIN Country c ON cl.idCountry = c.idCountry
    WHERE cl.Language IN ('Данська', 'Англійська', 'Німецька')
    GROUP BY cl.Language
);


-- 5.11)
SELECT 
    c.Name, 
    c.Population, 
    ci.NameCity AS Capital, 
    COUNT(DISTINCT ci.District) AS NumAdministrativeUnits 
FROM Country c 
JOIN City ci 
ON c.idCountry = ci.IdCountry 
WHERE c.Population > 0 
GROUP BY 
	c.Name, 
	c.Population, 
    ci.NameCity;


-- 5.12)
SELECT c.Name
FROM Country c
WHERE NOT EXISTS (
    SELECT 1
    FROM CountryLanguage cl
    WHERE cl.idCountry = c.idCountry
    AND  cl.Language IN ('Німецька', 'Французька', 'Ітайлійська', 'Румунська')
    GROUP BY cl.idCountry
);


