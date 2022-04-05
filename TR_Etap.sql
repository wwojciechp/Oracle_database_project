create or replace TRIGGER TR_ETAP
    BEFORE INSERT OR UPDATE ON Etap
    FOR EACH ROW
        DECLARE hm_etaps integer;
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        IF INSERTING THEN
                SELECT count(*) INTO hm_etaps
                    FROM Etap
                        WHERE Nazwa_Etapu = :NEW.Nazwa_Etapu;
                    IF hm_etaps > 0 THEN
                        raise_application_error(-20001, 'Etap '||:NEW.Nazwa_Etapu||'już istnieje');
                    END IF;  
        END IF;
        IF UPDATING THEN
                IF :OLD.Nazwa_Etapu <> :NEW.Nazwa_Etapu THEN
                SELECT count(*) INTO hm_etaps
                    FROM Etap
                        WHERE Nazwa_Etapu = :NEW.Nazwa_Etapu;
                    IF hm_etaps = 1 THEN
                        raise_application_error(-20001, 'Etap '||:NEW.Nazwa_Etapu||'już istnieje');  
                    END IF;
                END IF;
        END IF;
    END;