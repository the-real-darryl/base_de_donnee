SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER TRIGGERVENTECLIENT
AFTER UPDATE OF NUMCLIENT ON DD_CLIENT
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('MISE A JOUR EN CASCAE DE : '||:NEW.NUMCLIENT);
    UPDATE DD_VENTECLIENT SET NUMCLIENT =:NEW.NUMCLIENT WHERE NUMCLIENT =:OLD.NUMCLIENT;
END;
/