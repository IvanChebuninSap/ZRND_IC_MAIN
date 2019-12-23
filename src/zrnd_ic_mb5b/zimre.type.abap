TYPE-POOL ZIMRE .

*-------------- Deklarationen zur Unternehmensstruktur ----------------*

TYPES: BEGIN OF zIMRE_ORGAN_TYP,
         MANDT LIKE zT001-MANDT,
         BUKRS LIKE zT001-BUKRS,
         BUTXT LIKE zT001-BUTXT,
         WAERS LIKE zT001-WAERS,
         KTOPL LIKE zT001-KTOPL,
         LFGJA LIKE zMARV-LFGJA,
         LFMON LIKE zMARV-LFMON,
         VMGJA LIKE zMARV-VMGJA,
         VMMON LIKE zMARV-VMMON,
         VJGJA LIKE zMARV-VJGJA,
         VJMON LIKE zMARV-VJMON,
         BWKEY LIKE zT001K-BWKEY,
         BWMOD LIKE zT001K-BWMOD,
         XVKBW LIKE zT001K-XVKBW,  " Kennzeichen: Verkaufspreisbew. aktiv
         WERKS LIKE zT001W-WERKS,
         NAME1 LIKE zT001W-NAME1,
         LGORT LIKE zT001L-LGORT,
         LGOBE LIKE zT001L-LGOBE,
       END OF zIMRE_ORGAN_TYP.

TYPES: BEGIN OF zIMRE_T001_TYP,
         BUKRS LIKE zT001-BUKRS,
         WAERS LIKE zT001-WAERS,
       END OF zIMRE_T001_TYP.

TYPES: BEGIN OF zIMRE_T001K_TYP,
         BWKEY LIKE zT001K-BWKEY,
         BUKRS LIKE zT001K-BUKRS,
         WAERS LIKE zT001-WAERS,
       END OF zIMRE_T001K_TYP.

TYPES: BEGIN OF zIMRE_T001W_TYP,
         WERKS LIKE zT001W-WERKS,
         BWKEY LIKE zT001W-BWKEY,
         NAME1 LIKE zT001W-NAME1,
       END OF zIMRE_T001W_TYP.

TYPES: BEGIN OF zIMRE_T001L_TYP,
         WERKS LIKE zT001L-WERKS,
         LGORT LIKE zT001L-LGORT,
       END OF zIMRE_T001L_TYP.


*---------------- Datendeklarationen Materialbelege -------------------*

"TYPES: zIMRE_MATBELEG_TYP TYPE zIMRE_MSEG.    "note 816702

TYPES: BEGIN OF zIMRE_MATHEADER_TYP,
         MATNR LIKE zMSEG-MATNR,
         MAKTX LIKE zMAKT-MAKTX,
         MAKTG LIKE zMAKT-MAKTG,
         WERKS LIKE zMSEG-WERKS,
         NAME1 LIKE zT001W-NAME1.
TYPES: END OF zIMRE_MATHEADER_TYP.


*----------------- Datendeklaration Materialstamm ---------------------*

*TYPES: BEGIN OF zIMRE_MATSTAMM_TYP.
         "INCLUDE STRUCTURE zIMRE_MATST.
*TYPES: END OF zIMRE_MATSTAMM_TYP.


*------------ Datendeklarationen für Sonderbestände -------------------*

* Lieferantenkonsignation:
*TYPES: BEGIN OF zIMRE_LIEFKONSI_TYP.
*         INCLUDE STRUCTURE zIMRE_KONS.
*TYPES: END OF zIMRE_LIEFKONSI_TYP.
