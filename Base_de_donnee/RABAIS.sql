SET SERVEROUTPUT ON
SET VERIFY OFF


CREATE OR REPLACE PROCEDURE RABAIS(NUMCLIENT_ in VARCHAR2, DATE_ in VARCHAR2) IS
TOTAL NUMBER(8,2) := 0;
TOTAL_TAXE NUMBER(8,2) := 0;
PRIX_AVANT_TAXE NUMBER(8,2);
DEDUCTION NUMBER(6,3) := 0;
NB NUMBER(1);

BEGIN
	SELECT COUNT(NUMCLIENT) INTO NB FROM DD_VENTECLIENT WHERE NUMCLIENT = NUMCLIENT_ AND DATEVENTE = TO_DATE(DATE_,'YY/MM/DD');
	IF NB > 0 THEN
		FOR ITEM IN(SELECT * FROM DD_VENTECLIENT 
				WHERE NUMCLIENT_ = NUMCLIENT AND DATEVENTE = TO_DATE(DATE_,'dd-MM-yyyy')) LOOP
				PRIX_AVANT_TAXE := TAXEPACKAGE.COUTVENTE(ITEM.QUANTITEVENDUE,ITEM.PRIXVENTE);
			    TOTAL := TOTAL + PRIX_AVANT_TAXE;
			    TOTAL_TAXE := TOTAL_TAXE + TAXEPACKAGE.TAXE(PRIX_AVANT_TAXE);
		END LOOP;

		IF TOTAL <= 100 THEN
			DEDUCTION := 0.95;
		ELSIF TOTAL <= 500 THEN
			DEDUCTION := 0.90;
		ELSIF TOTAL > 500 THEN
			DEDUCTION := 0.85;
		END IF;
		UPDATE DD_VENTECLIENT SET PRIXVENTE = PRIXVENTE*DEDUCTION WHERE NUMCLIENT = NUMCLIENT_ AND DATEVENTE = TO_DATE(DATE_,'YY/MM/DD');
		COMMIT;
		TOTAL := 0;
		TOTAL_TAXE := 0;
		FOR ITEM IN(SELECT * FROM DD_VENTECLIENT 
				WHERE NUMCLIENT = NUMCLIENT_ AND DATEVENTE = TO_DATE(DATE_,'YY/MM/DD')) LOOP
				PRIX_AVANT_TAXE := TAXEPACKAGE.COUTVENTE(ITEM.QUANTITEVENDUE,ITEM.PRIXVENTE);
			    TOTAL := TOTAL + PRIX_AVANT_TAXE;
			    TOTAL_TAXE := TOTAL_TAXE + TAXEPACKAGE.TAXE(PRIX_AVANT_TAXE);
			DBMS_OUTPUT.PUT_LINE('Numero de client: '||ITEM.NUMCLIENT||' Total '||(TOTAL+TOTAL_TAXE)||' RABAIS '||DEDUCTION||' PRIX RECALCULER '||(TOTAL+TOTAL_TAXE));
		END LOOP;
	ELSE
		FOR ITEM IN(SELECT * FROM DD_VENTECLIENT) LOOP
			TOTAL := TAXEPACKAGE.COUTVENTE(ITEM.QUANTITEVENDUE,ITEM.PRIXVENTE);
			TOTAL_TAXE := TAXEPACKAGE.TAXE(TOTAL);
			DBMS_OUTPUT.PUT_LINE('-------------------------------------');
			DBMS_OUTPUT.PUT_LINE('Numero de client: '||ITEM.NUMCLIENT||' Total '||(TOTAL+TOTAL_TAXE)||' RABAIS '||DEDUCTION||' PRIX RECALCULER '||(TOTAL+TOTAL_TAXE));
		END LOOP;
	END IF;
END;
/
SET VERIFY ON