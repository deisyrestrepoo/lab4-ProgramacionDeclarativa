SELECT * FROM Moneda;

SELECT * FROM CambioMoneda
ORDER BY IdMoneda, Fecha;

SELECT * FROM Pais;


CREATE OR REPLACE VIEW vCambioMoneda_Ultimos2Meses AS
SELECT m.sigla, m.moneda, cm.fecha, cm.cambio
FROM cambiomoneda cm
JOIN moneda m ON m.id = cm.idmoneda
WHERE cm.fecha >= CURRENT_DATE - INTERVAL '2 months';

SELECT * FROM vCambioMoneda_Ultimos2Meses
WHERE sigla IN ('COP','USD','EUR','CUP')
ORDER BY sigla, fecha;
