-- Activar la carga local esté activa
SET global local_infile = 1;

-- Crear las tablas si no existen
CREATE TABLE IF NOT EXISTS region (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    nombre VARCHAR(120) UNIQUE
);

CREATE TABLE IF NOT EXISTS departamento (
    id INT AUTO_INCREMENT, 
    codigo VARCHAR(10) UNIQUE, 
    nombre VARCHAR(120),
    region_id INT,
    PRIMARY KEY (id, region_id), 
    FOREIGN KEY (region_id) REFERENCES region(id)
);

CREATE TABLE IF NOT EXISTS municipio (
    id INT AUTO_INCREMENT, 
    codigo VARCHAR(10), 
    nombre VARCHAR(120),
    departamento_id INT,
    region_id INT,
    PRIMARY KEY (id, departamento_id, region_id), 
    FOREIGN KEY (departamento_id,region_id) REFERENCES departamento(id,region_id)
);