CLEAR SCREEN
PROMPT MENU INSERTION
PROMPT 1: Inserer dans la table client
PROMPT 2: Inserer dans la table produit
PROMPT 3: Inserer dans la table venteclient
PROMPT 4: Retourner au menu principal
ACCEPT ENTRE PROMPT " Entrer une option entre 1 et 4: "
SET TERM OFF
COLUMN SCRIPT NEW_VALUE V_SCRIPT
SELECT CASE '&ENTRE'
WHEN '1' THEN 'CLIENT.sql'
WHEN '2' THEN 'PRODUIT.sql'
WHEN '3' THEN 'VENTECLIENT.sql'
WHEN '4' THEN 'MENU.sql'
ELSE 'MENUINSERTION.sql'
END AS SCRIPT
FROM DUAL;
SET TERM ON
@C:\Users\usager\Desktop\base\PROJET_FINAL2\&V_SCRIPT