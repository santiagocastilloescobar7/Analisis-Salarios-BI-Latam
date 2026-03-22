-- ============================================================
--  PROYECTO: ¿Cuánto gana un Analista BI en LATAM? (2025)
--  Herramienta: MySQL Workbench
--  Autor: [Santiago Castillo Escobar] | LinkedIn Project
-- ============================================================


-- ============================================================
--  PASO 1: BASE DE DATOS Y TABLAS
-- ============================================================

DROP DATABASE IF EXISTS proyecto_salarios_bi;
CREATE DATABASE proyecto_salarios_bi;
USE proyecto_salarios_bi;

CREATE TABLE paises (
    id_pais       INT PRIMARY KEY,
    nombre        VARCHAR(50)  NOT NULL,
    region        VARCHAR(30)  NOT NULL,
    moneda_local  VARCHAR(10)  NOT NULL
);

CREATE TABLE niveles (
    id_nivel      INT PRIMARY KEY,
    nombre        VARCHAR(20)  NOT NULL,
    anios_min     INT          NOT NULL,
    anios_max     INT          NOT NULL
);

CREATE TABLE habilidades (
    id_habilidad  INT PRIMARY KEY,
    nombre        VARCHAR(50)  NOT NULL,
    categoria     VARCHAR(30)  NOT NULL
);

CREATE TABLE salarios (
    id_salario        INT PRIMARY KEY,
    id_pais           INT           NOT NULL,
    id_nivel          INT           NOT NULL,
    salario_usd_mes   DECIMAL(10,2) NOT NULL,
    salario_usd_anio  DECIMAL(10,2) NOT NULL,
    modalidad         VARCHAR(20)   NOT NULL,
    sector            VARCHAR(40)   NOT NULL,
    anio_dato         INT           NOT NULL,
    fuente            VARCHAR(60),
    FOREIGN KEY (id_pais)  REFERENCES paises(id_pais),
    FOREIGN KEY (id_nivel) REFERENCES niveles(id_nivel)
);

CREATE TABLE impacto_habilidades (
    id              INT PRIMARY KEY,
    id_habilidad    INT           NOT NULL,
    id_nivel        INT           NOT NULL,
    incremento_pct  DECIMAL(5,2)  NOT NULL,
    FOREIGN KEY (id_habilidad) REFERENCES habilidades(id_habilidad),
    FOREIGN KEY (id_nivel)     REFERENCES niveles(id_nivel)
);


-- ============================================================
--  PASO 2: INSERTAR DATOS
-- ============================================================

INSERT INTO paises VALUES
(1, 'México',    'LATAM Norte', 'MXN'),
(2, 'Colombia',  'LATAM',       'COP'),
(3, 'Argentina', 'LATAM Sur',   'ARS'),
(4, 'Chile',     'LATAM Sur',   'CLP'),
(5, 'Perú',      'LATAM',       'PEN'),
(6, 'Brasil',    'LATAM',       'BRL');

INSERT INTO niveles VALUES
(1, 'Junior', 0, 2),
(2, 'Mid',    2, 5),
(3, 'Senior', 5, 99);

INSERT INTO habilidades VALUES
(1,  'Power BI',         'Herramienta'),
(2,  'SQL',              'Lenguaje'),
(3,  'Python',           'Lenguaje'),
(4,  'Tableau',          'Herramienta'),
(5,  'Azure',            'Herramienta'),
(6,  'dbt',              'Herramienta'),
(7,  'Inglés avanzado',  'Soft Skill'),
(8,  'Excel avanzado',   'Herramienta'),
(9,  'DAX',              'Lenguaje'),
(10, 'Spark/Databricks', 'Herramienta');

INSERT INTO salarios VALUES
(1,  1, 1,  530.00,   6360.00, 'Presencial', 'Retail',     2025, 'Glassdoor MX'),
(2,  1, 2, 1113.00,  13356.00, 'Híbrido',    'Tecnología', 2025, 'Glassdoor MX'),
(3,  1, 3, 2385.00,  28620.00, 'Remoto',     'Finanzas',   2025, 'Glassdoor MX'),
(4,  2, 1,  440.00,   5280.00, 'Presencial', 'Retail',     2025, 'Talently CO'),
(5,  2, 2,  880.00,  10560.00, 'Híbrido',    'Tecnología', 2025, 'Talently CO'),
(6,  2, 3, 1320.00,  15840.00, 'Remoto',     'Finanzas',   2025, 'Talently CO'),
(7,  3, 1,  424.00,   5088.00, 'Presencial', 'Retail',     2025, 'Coderhouse AR'),
(8,  3, 2,  795.00,   9540.00, 'Híbrido',    'Tecnología', 2025, 'Coderhouse AR'),
(9,  3, 3, 1367.00,  16404.00, 'Remoto',     'Finanzas',   2025, 'Coderhouse AR'),
(10, 4, 1,  700.00,   8400.00, 'Presencial', 'Retail',     2025, 'Glassdoor CL'),
(11, 4, 2, 1400.00,  16800.00, 'Híbrido',    'Tecnología', 2025, 'Glassdoor CL'),
(12, 4, 3, 2500.00,  30000.00, 'Remoto',     'Finanzas',   2025, 'Glassdoor CL'),
(13, 5, 1,  520.00,   6240.00, 'Presencial', 'Retail',     2025, 'Bumeran PE'),
(14, 5, 2, 1040.00,  12480.00, 'Híbrido',    'Tecnología', 2025, 'Bumeran PE'),
(15, 5, 3, 1820.00,  21840.00, 'Remoto',     'Finanzas',   2025, 'Bumeran PE'),
(16, 6, 1,  600.00,   7200.00, 'Presencial', 'Retail',     2025, 'Glassdoor BR'),
(17, 6, 2, 1250.00,  15000.00, 'Híbrido',    'Tecnología', 2025, 'Glassdoor BR'),
(18, 6, 3, 2200.00,  26400.00, 'Remoto',     'Finanzas',   2025, 'Glassdoor BR');

INSERT INTO impacto_habilidades VALUES
(1,  1, 1, 18.00), (2,  1, 2, 22.00), (3,  1, 3, 20.00),
(4,  2, 1, 15.00), (5,  2, 2, 18.00), (6,  2, 3, 16.00),
(7,  3, 1, 20.00), (8,  3, 2, 25.00), (9,  3, 3, 28.00),
(10, 7, 1, 30.00), (11, 7, 2, 35.00), (12, 7, 3, 40.00),
(13, 5, 2, 22.00), (14, 5, 3, 30.00),
(15, 6, 2, 18.00), (16, 6, 3, 25.00);


-- ============================================================
--  PASO 3: CONSULTAS DE ANÁLISIS
-- ============================================================

-- CONSULTA 1: ¿Cuánto gana en promedio un BI Analyst por país?
SELECT
    p.nombre                         AS pais,
    ROUND(AVG(s.salario_usd_mes), 0) AS promedio_usd_mes,
    ROUND(MIN(s.salario_usd_mes), 0) AS minimo_usd_mes,
    ROUND(MAX(s.salario_usd_mes), 0) AS maximo_usd_mes
FROM salarios s
JOIN paises p ON s.id_pais = p.id_pais
GROUP BY p.nombre
ORDER BY promedio_usd_mes DESC;


-- CONSULTA 2: ¿Cuánto crece el salario de Junior a Senior?
SELECT
    p.nombre AS pais,
    MAX(CASE WHEN n.nombre = 'Junior' THEN s.salario_usd_mes END) AS junior_usd,
    MAX(CASE WHEN n.nombre = 'Mid'    THEN s.salario_usd_mes END) AS mid_usd,
    MAX(CASE WHEN n.nombre = 'Senior' THEN s.salario_usd_mes END) AS senior_usd,
    ROUND(
        (MAX(CASE WHEN n.nombre = 'Senior' THEN s.salario_usd_mes END) /
         MAX(CASE WHEN n.nombre = 'Junior' THEN s.salario_usd_mes END) - 1) * 100, 1
    ) AS crecimiento_pct
FROM salarios s
JOIN paises  p ON s.id_pais  = p.id_pais
JOIN niveles n ON s.id_nivel = n.id_nivel
GROUP BY p.nombre
ORDER BY crecimiento_pct DESC;


-- CONSULTA 3: Ranking por país en cada nivel
SELECT
    n.nombre          AS nivel,
    p.nombre          AS pais,
    s.salario_usd_mes AS salario_usd_mes,
    RANK() OVER (
        PARTITION BY n.nombre
        ORDER BY s.salario_usd_mes DESC
    ) AS ranking
FROM salarios s
JOIN paises  p ON s.id_pais  = p.id_pais
JOIN niveles n ON s.id_nivel = n.id_nivel
ORDER BY n.id_nivel, ranking;


-- CONSULTA 4: ¿Remoto vs presencial, cuánto paga?
SELECT
    modalidad,
    ROUND(AVG(salario_usd_mes), 0) AS promedio_usd_mes,
    ROUND(MAX(salario_usd_mes), 0) AS maximo_usd_mes,
    COUNT(*)                       AS registros
FROM salarios
GROUP BY modalidad
ORDER BY promedio_usd_mes DESC;


-- CONSULTA 5: ¿Qué habilidad sube más el salario?
SELECT
    h.nombre                         AS habilidad,
    h.categoria,
    ROUND(AVG(ih.incremento_pct), 1) AS impacto_promedio_pct,
    ROUND(MAX(ih.incremento_pct), 1) AS impacto_maximo_pct
FROM impacto_habilidades ih
JOIN habilidades h ON ih.id_habilidad = h.id_habilidad
GROUP BY h.nombre, h.categoria
ORDER BY impacto_promedio_pct DESC;


-- VISTA FINAL PARA POWER BI
CREATE OR REPLACE VIEW v_resumen_power_bi AS
SELECT
    s.id_salario,
    p.nombre          AS pais,
    p.region,
    n.nombre          AS nivel,
    n.anios_min       AS experiencia_min,
    n.anios_max       AS experiencia_max,
    s.salario_usd_mes,
    s.salario_usd_anio,
    s.modalidad,
    s.sector,
    s.anio_dato,
    s.fuente
FROM salarios s
JOIN paises  p ON s.id_pais  = p.id_pais
JOIN niveles n ON s.id_nivel = n.id_nivel;

SELECT * FROM v_resumen_power_bi ORDER BY pais, nivel;
