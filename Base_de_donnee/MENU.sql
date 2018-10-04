CLEAR SCREEN
PROMPT MENU PRINCIPAL
PROMPT 1: Insertion dans des tables
PROMPT 2: Application de rabais
PROMPT 3: Afficher une facture
PROMPT 4: Modification (Mise a jour et supression)
PROMPT 5: Quitter
ACCEPT ENTRE PROMPT " Entrer une option entre 1 et 5: "
SET TERM OFF
COLUMN SCRIPT NEW_VALUE V_SCRIPT
SELECT CASE '&ENTRE'
WHEN '1' THEN 'MENUINSERTION.sql'
WHEN '2' THEN 'RABAIS_EXECUTABLE.sql'
WHEN '3' THEN 'FACTURE.sql'
WHEN '4' THEN 'MENUMODIFICATION.sql'
WHEN '5' THEN 'QUITTER.sql'
ELSE 'MENU.sql'
END AS SCRIPT
FROM DUAL;
SET TERM ON
@C:\Users\usager\Desktop\base\PROJET_FINAL2\&V_SCRIPT
PROMPT Appuyer sut une touche ...
PAUSE