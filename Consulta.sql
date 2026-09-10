use municipios;

SELECT 
    m.nombre AS municipio,
    d.nombre AS departamento,
    r.nombre AS region
FROM municipio m
INNER JOIN departamento d ON m.departamento_id = d.id
INNER JOIN region r ON d.region_id = r.id
WHERE m.nombre IN (
    SELECT nombre 
    FROM municipio 
    GROUP BY nombre 
    HAVING COUNT(*) > 1
)
ORDER BY m.nombre, d.nombre;
