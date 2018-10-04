SET VERIFY OFF
ACCEPT NUMCLIENT PROMPT "Enter le numero de client: "
ACCEPT DATE_ PROMPT "Enter la date en format 'YY/MM/DD': "
BEGIN
	RABAIS('&NUMCLIENT' ,'&DATE_' );
END;
/

SET VERIFY ON

PROMPT Appuyer sut une touche ...
PAUSE
@C:\Users\usager\Desktop\base\PROJET_FINAL2\menu.sql