
DO $$
DECLARE
    nuevoIdMoneda INTEGER;nuevoIdCambio INTEGER;
    idCOP INTEGER;idUSD INTEGER;idEUR INTEGER;idCUP INTEGER;
    fechaInicio DATE := CURRENT_DATE - INTERVAL '2 months';
    fechaA DATE;
    valor FLOAT;
BEGIN
  
    SELECT COALESCE(MAX(id),0) + 1 INTO nuevoIdMoneda FROM moneda;

    SELECT id INTO idCOP FROM moneda WHERE sigla = 'COP';
    IF idCOP IS NULL THEN --si la moneda no existe se agrega
        INSERT INTO moneda(id, moneda, sigla)
        VALUES (nuevoIdMoneda, 'MonedaCOP', 'COP');
        idCOP := nuevoIdMoneda;
        nuevoIdMoneda := nuevoIdMoneda + 1;
        RAISE NOTICE 'Se crea la moneda COP con id %', idCOP;
    END IF;

    fechaA := fechaInicio;

    WHILE fechaA <= CURRENT_DATE LOOP
        valor := ROUND((random() * (6000 - 1000) + 1000)::numeric, 2);

        SELECT id INTO nuevoIdCambio -- si el cambio existe, cambiar el valor
        FROM cambiomoneda
        WHERE idmoneda = idCOP AND fecha = fechaA;

        IF nuevoIdCambio IS NULL THEN
            INSERT INTO cambiomoneda(idmoneda, fecha, cambio)
            VALUES (idCOP, fechaA, valor);
        ELSE
            UPDATE cambiomoneda -- actualizarlo si ya existe
            SET cambio = valor
            WHERE id = nuevoIdCambio;
        END IF;

        fechaA:=fechaA + INTERVAL '1 day';
    END LOOP;


    SELECT id INTO idUSD FROM moneda WHERE sigla = 'USD';

    IF idUSD IS NULL THEN
        INSERT INTO moneda(id, moneda, sigla)
        VALUES (nuevoIdMoneda, 'MonedaUSD', 'USD');
        idUSD := nuevoIdMoneda;
        nuevoIdMoneda := nuevoIdMoneda + 1;
        RAISE NOTICE 'Se crea la moneda USD con id %', idUSD;
    END IF;

    fechaA := fechaInicio;

    WHILE fechaA <= CURRENT_DATE LOOP
        valor:= ROUND((random() * (6000 - 1000) + 1000)::numeric, 2);
		
        SELECT id INTO nuevoIdCambio
        FROM cambiomoneda
        WHERE idmoneda = idUSD AND fecha = fechaA;

        IF nuevoIdCambio IS NULL THEN
            INSERT INTO cambiomoneda(idmoneda, fecha, cambio)
            VALUES (idUSD, fechaA, valor);
        ELSE
            UPDATE cambiomoneda
            SET cambio = valor
            WHERE id = nuevoIdCambio;
        END IF;

        fechaA:= fechaA + INTERVAL '1 day';
    END LOOP;

    SELECT id INTO idEUR FROM moneda WHERE sigla = 'EUR';

    IF idEUR IS NULL THEN
        INSERT INTO moneda(id, moneda, sigla)
        VALUES (nuevoIdMoneda, 'MonedaEUR', 'EUR');
        idEUR := nuevoIdMoneda;
        nuevoIdMoneda := nuevoIdMoneda + 1;
        RAISE NOTICE 'Se crea la moneda EUR con id %', idEUR;
    END IF;

    fechaA:= fechaInicio;

    WHILE fechaA <= CURRENT_DATE LOOP
        valor := ROUND((random() * (6000 - 1000) + 1000)::numeric, 2);

        SELECT id INTO nuevoIdCambio
        FROM cambiomoneda
        WHERE idmoneda = idEUR AND fecha = fechaA;

        IF nuevoIdCambio IS NULL THEN
            INSERT INTO cambiomoneda(idmoneda, fecha, cambio)
            VALUES (idEUR, fechaA, valor);
        ELSE
            UPDATE cambiomoneda
            SET cambio = valor
            WHERE id = nuevoIdCambio;
        END IF;

        fechaA := fechaA + INTERVAL '1 day';
    END LOOP;

    SELECT id INTO idCUP FROM moneda WHERE sigla = 'CUP';

    IF idCUP IS NULL THEN
        INSERT INTO moneda(id, moneda, sigla)
        VALUES (nuevoIdMoneda, 'MonedaCUP', 'CUP');
        idCUP := nuevoIdMoneda;
        nuevoIdMoneda := nuevoIdMoneda + 1;
        RAISE NOTICE 'Se crea la moneda CUP con id %', idCUP;
    END IF;

    fechaA := fechaInicio;

    WHILE fechaA <= CURRENT_DATE LOOP
        valor := ROUND((random() * (6000 - 1000) + 1000)::numeric, 2);

        SELECT id INTO nuevoIdCambio
        FROM cambiomoneda
        WHERE idmoneda = idCUP AND fecha = fechaA;

        IF nuevoIdCambio IS NULL THEN
            INSERT INTO cambiomoneda(idmoneda, fecha, cambio)
            VALUES (idCUP, fechaA, valor);
        ELSE
            UPDATE cambiomoneda
            SET cambio = valor
            WHERE id = nuevoIdCambio;
        END IF;

        fechaA := fechaA + INTERVAL '1 day';
    END LOOP;

END $$;
