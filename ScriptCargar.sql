-- Cargar datos en la tabla REGION 
LOAD DATA INFILE '/datos/municipios.csv'
IGNORE INTO TABLE region 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS 
(nombre, @codigo_departamento, @nombre_departamento, @codigo_municipio, @nombre_municipio);

-- Cargar datos en la tabla DEPARTAMENTO
LOAD DATA INFILE '/datos/municipios.csv'
IGNORE INTO TABLE departamento 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS 
(@region, codigo, nombre, @codigo_municipio, @nombre_municipio) 
SET region_id = (SELECT id FROM region WHERE nombre = @region);

-- Cargar datos en la tabla MUNICIPIO
LOAD DATA INFILE '/datos/municipios.csv'
INTO TABLE municipio 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 ROWS 
(@region, @codigo_departamento, @nombre_departamento, codigo, nombre)
SET departamento_id = (SELECT id FROM departamento WHERE codigo = @codigo_departamento limit 1), region_id = (SELECT region_id FROM departamento WHERE codigo = @codigo_departamento limit 1); 