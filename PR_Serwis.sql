CREATE OR REPLACE PROCEDURE PR_SERWIS
IS    

    v_serwis NUMBER;
    v_przebieg FLOAT;
    v_przeglad FLOAT;

    CURSOR v_kursor IS
        SELECT * 
        FROM  Pojazd;
		
    l_pojazd pojazd%rowtype;
	
BEGIN 
    v_serwis:=0;
	
    OPEN v_kursor;
	
        LOOP

            FETCH v_kursor INTO l_pojazd;
            
            EXIT WHEN v_kursor%NOTFOUND;

            UPDATE pojazd
            SET stan = 'S'
            WHERE id_Pojazdu = l_pojazd.id_Pojazdu
            AND (Aktualny_Przebieg-Ostatni_Przeglad) >= 15000;

            SELECT Aktualny_Przebieg INTO v_przebieg  FROM Pojazd
            WHERE id_Pojazdu = l_pojazd.id_Pojazdu;

            SELECT ostatni_przeglad INTO v_przeglad  FROM Pojazd
            WHERE id_Pojazdu = l_pojazd.id_Pojazdu;

            IF (v_przebieg-v_przeglad) >= 15000 THEN

               SELECT v_serwis+1 INTO v_serwis  FROM dual;
			   
            END IF;

        END LOOP;

            dbms_output.put_line('Ilosc pojazdow ktore wymagaja serwisu: ' || v_serwis || ' tabela pojazd zostala zmodyfikowana.');

     CLOSE v_kursor;   
END;

--set serveroutput on;