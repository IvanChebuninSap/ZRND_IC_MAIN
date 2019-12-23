*----------------------------------------------------------------------*
*
*   INCLUDE RM07MLDD for report RM07MLBD
*
*----------------------------------------------------------------------*


* Typen für Sonderbestände:
TYPES: BEGIN OF mslb_typ,
         werks LIKE zmslb-werks,
         matnr LIKE zmslb-matnr,
         sobkz LIKE zmslb-sobkz,
         lblab LIKE zmslb-lblab,
         lbins LIKE zmslb-lbins,
         lbein LIKE zmslb-lbein,
         lbuml LIKE zmslb-lbuml.                             "1421484
*ENHANCEMENT-POINT ehp605_rm07mldd_01 SPOTS es_rm07mlbd STATIC .
TYPES: END OF mslb_typ.

TYPES: BEGIN OF cmslb_typ.
        INCLUDE TYPE mslb_typ.
TYPES:   charg LIKE zmslb-charg.
TYPES: END OF cmslb_typ.

TYPES: BEGIN OF msku_typ,
         werks LIKE zmsku-werks,
         matnr LIKE zmsku-matnr,
         sobkz LIKE zmsku-sobkz,
         kulab LIKE zmsku-kulab,
         kuins LIKE zmsku-kuins,
         kuein LIKE zmsku-kuein,
         kuuml LIKE zmsku-kuuml.                             "1421484
*ENHANCEMENT-POINT ehp605_rm07mldd_02 SPOTS es_rm07mlbd STATIC .
TYPES: END OF msku_typ.

TYPES: BEGIN OF cmsku_typ.
        INCLUDE TYPE msku_typ.
TYPES:   charg LIKE zmsku-charg.
TYPES: END OF cmsku_typ.

TYPES: BEGIN OF mspr_typ,
         werks LIKE zmspr-werks,
         lgort LIKE zmspr-lgort,
         matnr LIKE zmspr-matnr,
         sobkz LIKE zmspr-sobkz,
         prlab LIKE zmspr-prlab,
         prins LIKE zmspr-prins,
         prspe LIKE zmspr-prspe,
         prein LIKE zmspr-prein.
*ENHANCEMENT-POINT ehp605_rm07mldd_03 SPOTS es_rm07mlbd STATIC .
TYPES: END OF mspr_typ.

TYPES: BEGIN OF cmspr_typ.
        INCLUDE TYPE mspr_typ.
TYPES:   charg LIKE zmspr-charg.
TYPES: END OF cmspr_typ.
*ENHANCEMENT-POINT rm07mldd_01 SPOTS es_rm07mlbd STATIC.

TYPES: BEGIN OF mkol_typ,
         werks LIKE zmkol-werks,
         lgort LIKE zmkol-lgort,
         matnr LIKE zmkol-matnr,
         sobkz LIKE zmkol-sobkz,
         slabs LIKE zmkol-slabs,
         sinsm LIKE zmkol-sinsm,
         seinm LIKE zmkol-seinm,
         sspem LIKE zmkol-sspem.
*ENHANCEMENT-POINT ehp605_rm07mldd_04 SPOTS es_rm07mlbd STATIC .
TYPES: END OF mkol_typ.

TYPES: BEGIN OF cmkol_typ.
        INCLUDE TYPE mkol_typ.
TYPES:   charg LIKE zmkol-charg.
TYPES: END OF cmkol_typ.

TYPES: BEGIN OF mska_typ,
         werks LIKE zmska-werks,
         lgort LIKE zmska-lgort,
         matnr LIKE zmska-matnr,
         sobkz LIKE zmska-sobkz,
         kalab LIKE zmska-kalab,
         kains LIKE zmska-kains,
         kaspe LIKE zmska-kaspe,
         kaein LIKE zmska-kaein.
*ENHANCEMENT-POINT ehp605_rm07mldd_05 SPOTS es_rm07mlbd STATIC .
TYPES: END OF mska_typ.

TYPES: BEGIN OF cmska_typ.
        INCLUDE TYPE mska_typ.
TYPES:   charg LIKE zmska-charg.
TYPES: END OF cmska_typ.

*------------------------- TABELLEN -----------------------------------*

*TABLES:
*         bkpf,                 "Buchhaltungsbelegkopf
*         bsim,                 "Buchhaltungsbelege
*         makt,                 "Materialkurztext
*         mara,                 "allg. zum Material
*         mard,                 "Materialbestände auf Lagerortebene
*         mchb,                 "Chargenbestände auf Lagerortebene
*         mcha,                                              "134317
*         mbew,                 "Bewertungssegment
*         ebew,                 "bewerteter Sonderbestand 'E'
*         qbew,                 "bewerteter Sonderbestand 'Q'
*        zmkol,                 "Sonderbestand Lieferantenkonsignation
*         mkpf,                 "Materialbelegköpfe
*         mseg,                 "Materialbelege
*         zmska,                 "Auftragsbestand
*         msku,                 "Sonderbestand Kundenkonsignation
*         mslb,                 "Sonderbestand Lohnbearbeitung
*         mspr,                 "Projektbestand
*         rpgri,                "Texttabelle Gruppierung Bewegungsarten
*         t001,                 "Prüftabelle Buchungskreise
*         t001k,                "Prüftabelle Bewertungskreise
*         t001w,                "Prüftabelle Werke
*         t001l,                "Prüftabelle Lagerorte
*         t134m,                "Prüftabelle Materialart
*         t156m,                "Mengenstrings
*         t156s,                "Bewegungsarten
*         tcurm,                "Bewertungskreisebene
*         bseg,
*         acchd
*.
*
** for checking the FI summarization                        "n497992
*TABLES : ttypv.     "customizing table FI summarization    "n497992
*
TABLES : sscrfields. "for the definition of pushbuttons    "n599218
*
**-------------------- DATENDEKLARATIONEN ------------------------------*
*
DATA: it001   TYPE zimre_t001_typ      OCCURS 0 WITH HEADER LINE.
DATA: it001k  TYPE zimre_t001k_typ     OCCURS 0 WITH HEADER LINE.
DATA: it001w  TYPE zimre_t001w_typ     OCCURS 0 WITH HEADER LINE.
DATA: it001l  TYPE zimre_t001l_typ     OCCURS 0 WITH HEADER LINE.
DATA: organ   TYPE zimre_organ_typ     OCCURS 0 WITH HEADER LINE.
DATA: header  TYPE zimre_matheader_typ OCCURS 0 WITH HEADER LINE.
*
**------------------------ Prüftabellen --------------------------------*
*
DATA: BEGIN OF it134m OCCURS 100,
        bwkey LIKE zt134m-bwkey,
        mtart LIKE zt134m-mtart,
        mengu LIKE zt134m-mengu,
        wertu LIKE zt134m-wertu,
      END OF it134m.

DATA: BEGIN OF it156 OCCURS 100,
        bwart LIKE Zt156s-bwart,
        wertu LIKE Zt156s-wertu,
        mengu LIKE Zt156s-mengu,
        sobkz LIKE Zt156s-sobkz,
        kzbew LIKE Zt156s-kzbew,
        kzzug LIKE Zt156s-kzzug,
        kzvbr LIKE Zt156s-kzvbr,
        bustm LIKE Zt156s-bustm,
        bustw LIKE Zt156s-bustw,                             "147374
        lbbsa LIKE zt156m-lbbsa,
        bwagr LIKE Zt156s-bwagr,
      END OF it156.

DATA: BEGIN OF it156w OCCURS 100,                           "149448
        bustw LIKE zt156w-bustw,                             "149448
        xbgbb LIKE zt156w-xbgbb,                             "149448
      END OF it156w.                                        "149448

DATA: BEGIN OF it156x OCCURS 100,
        bustm LIKE zt156s-bustm,
        lbbsa LIKE zt156m-lbbsa,
      END OF it156x.

*--------------- übergeordnete Materialtabellen -----------------------*

* working table with material short texts / contains only   "n451923
* the necessary fields                                      "n451923
TYPES : BEGIN OF stype_makt,                                "n451923
          matnr LIKE zmakt-matnr,                            "n451923
          maktx LIKE zmakt-maktx,                            "n451923
        END OF stype_makt,                                  "n451923
                                                            "n451923
        stab_makt TYPE STANDARD TABLE OF                    "n451923
      stype_makt WITH DEFAULT KEY.                          "n451923
                                                            "n451923
DATA : g_s_makt TYPE stype_makt,                            "n451923
       g_t_makt TYPE stab_makt.                             "n451923

DATA: BEGIN OF imara OCCURS 100,
        matnr LIKE zmara-matnr,
        meins LIKE zmara-meins,
        mtart LIKE zmara-mtart.
*ENHANCEMENT-POINT ehp605_rm07mldd_06 SPOTS es_rm07mlbd STATIC .
DATA: END OF imara.

* definition of working area for valuation tables improved  "n450764
TYPES : BEGIN OF stype_mbew,                                "n450764
          matnr     LIKE zmbew-matnr,                        "n450764
          bwkey     LIKE zmbew-bwkey,                        "n450764
          bwtar     LIKE zmbew-bwtar,                        "n450764
          lbkum(09) TYPE p DECIMALS 3,                      "n450764
          salk3(09) TYPE p DECIMALS 2,                      "n450764
          meins     LIKE zmara-meins,                        "n450764
          waers     LIKE zt001-waers,                        "n450764
          bwtty     LIKE zmbew-bwtty,                        "n1227439
        END OF stype_mbew,                                  "n450764
                                                            "n450764
        stab_mbew TYPE STANDARD TABLE OF                    "n450764
      stype_mbew WITH DEFAULT KEY.                          "n450764
                                                            "n450764
DATA: g_s_mbew TYPE stype_mbew,                             "n450764
      g_t_mbew TYPE stab_mbew.                              "n450764

DATA: BEGIN OF imcha OCCURS 100,                            "n1404822
        matnr LIKE zmcha-matnr,                              "n1404822
        werks LIKE zmcha-werks,                              "n1404822
        charg LIKE zmcha-charg,                              "n1404822
      END OF imcha.
*
TYPES : BEGIN OF stype_accdet,
          mblnr     LIKE zmseg-mblnr,
          mjahr     LIKE zmseg-mjahr,
          zeile     LIKE zmseg-zeile,
          matnr     LIKE zmseg-matnr,
          werks     LIKE zmseg-werks,
          bukrs     LIKE zmseg-bukrs,
          ktopl     LIKE zt001-ktopl,
          bwkey     LIKE zt001w-bwkey,
          bwmod     LIKE zt001k-bwmod,
          bwtar     LIKE zmseg-bwtar,
          sobkz     LIKE zmseg-sobkz,
          kzbws     LIKE zmseg-kzbws,
          xobew     LIKE zmseg-xobew,
          mat_pspnr LIKE zmseg-mat_pspnr,
          mat_kdauf LIKE zmseg-mat_kdauf,
          mat_kdpos LIKE zmseg-mat_kdpos,
          lifnr     LIKE zmseg-lifnr,
          bklas     LIKE zmbew-bklas,
          hkont     LIKE zbseg-hkont,
        END OF stype_accdet.

*--------------- Materialtabellen auf Lagerortebene -------------------*

DATA: BEGIN OF imard OCCURS 100,    "aktueller Materialbestand
        werks     LIKE zmard-werks,      "Werk
        matnr     LIKE zmard-matnr,      "Material
        lgort     LIKE zmard-lgort,      "Lagerort
        labst     LIKE zmard-labst,      "frei verwendbarer Bestand
        umlme     LIKE zmard-umlme,      "Umlagerungsbestand
        insme     LIKE zmard-insme,      "Qualitätsprüfbestand
        einme     LIKE zmard-einme,      "nicht frei verwendbarer Bestand
        speme     LIKE zmard-speme,      "gesperrter Bestand
        retme     LIKE zmard-retme,      "gesperrter Bestand
        klabs     LIKE zmard-klabs,      "frei verw. Konsignationsbestand
        lbkum     LIKE zmbew-lbkum,      "bewerteter Bestand
        salk3(09) TYPE p DECIMALS 2,                        "n497992
        waers     LIKE zt001-waers.      "Währungseinheit
*ENHANCEMENT-POINT ehp605_rm07mldd_07 SPOTS es_rm07mlbd STATIC .
DATA: END OF imard.

DATA: BEGIN OF imchb OCCURS 100,    "aktueller Chargenbestand
        werks LIKE zmchb-werks,
        matnr LIKE zmchb-matnr,
        lgort LIKE zmchb-lgort,
        charg LIKE zmchb-charg,
        clabs LIKE zmchb-clabs,      "frei verwendbarer Chargenbestand
        cumlm LIKE zmchb-cumlm,      "Umlagerungsbestand
        cinsm LIKE zmchb-cinsm,      "Qualitätsprüfbestand
        ceinm LIKE zmchb-ceinm,      "nicht frei verwendbarer Bestand
        cspem LIKE zmchb-cspem,      "gesperrter Bestand
        cretm LIKE zmchb-cretm.      "gesperrter Bestand
*ENHANCEMENT-POINT ehp605_rm07mldd_08 SPOTS es_rm07mlbd STATIC .
DATA: END OF imchb.
*
*-------------------------- Sonderbestände ----------------------------*

DATA: xmslb  TYPE cmslb_typ OCCURS 0 WITH HEADER LINE.
DATA: imslb  TYPE cmslb_typ OCCURS 0 WITH HEADER LINE.
DATA: imslbx TYPE mslb_typ  OCCURS 0 WITH HEADER LINE.

DATA: xmsku  TYPE cmsku_typ OCCURS 0 WITH HEADER LINE.
DATA: imsku  TYPE cmsku_typ OCCURS 0 WITH HEADER LINE.
DATA: imskux TYPE msku_typ  OCCURS 0 WITH HEADER LINE.

DATA: xmspr  TYPE cmspr_typ OCCURS 0 WITH HEADER LINE.
DATA: imspr  TYPE cmspr_typ OCCURS 0 WITH HEADER LINE.
DATA: imsprx TYPE mspr_typ  OCCURS 0 WITH HEADER LINE.

DATA: xmkol  TYPE cmkol_typ OCCURS 0 WITH HEADER LINE.
DATA: imkol  TYPE cmkol_typ OCCURS 0 WITH HEADER LINE.
DATA: imkolx TYPE mkol_typ  OCCURS 0 WITH HEADER LINE.

DATA: xmska  TYPE cmska_typ OCCURS 0 WITH HEADER LINE.
DATA: imska  TYPE cmska_typ OCCURS 0 WITH HEADER LINE.
DATA: imskax TYPE mska_typ  OCCURS 0 WITH HEADER LINE.

* global working table for the FI doc headers BKPF          "n856424
TYPES : BEGIN OF stype_bkpf,                                "n856424
          bukrs LIKE zbkpf-bukrs,                            "n856424
          belnr LIKE zbkpf-belnr,                            "n856424
          gjahr LIKE zbkpf-gjahr,                            "n856424
          blart LIKE zbkpf-blart,                            "n856424
          budat LIKE zbkpf-budat,                            "n856424
          awkey LIKE zbkpf-awkey,                            "n856424
          cpudt LIKE zbkpf-cpudt,                            "n856424
          cputm LIKE zbkpf-cputm,                            "n856424
          usnam LIKE zbkpf-usnam,                            "n856424
          awtyp LIKE zbkpf-awtyp,                            "n856424
        END OF stype_bkpf.                                  "n856424
                                                            "n856424
* global working table for the FI doc items BSEG
TYPES : BEGIN OF stype_bseg,
          bukrs LIKE zbseg-bukrs,
          belnr LIKE zbseg-belnr,
          gjahr LIKE zbseg-gjahr,
          buzei LIKE zbseg-buzei,
          hkont LIKE zbseg-hkont,
        END OF stype_bseg.

FIELD-SYMBOLS : <g_fs_bkpf>  TYPE  stype_bkpf.              "n856424
                                                            "n856424
DATA : g_t_bkpf    TYPE  HASHED TABLE OF stype_bkpf         "n856424
                         WITH UNIQUE KEY bukrs belnr gjahr. "n856424
DATA : g_t_bseg    TYPE  HASHED TABLE OF stype_bseg
                         WITH UNIQUE KEY bukrs belnr gjahr buzei.

*--------------- Summations- und Bestandstabellen ---------------------*

DATA: BEGIN OF bestand OCCURS 100,
        bwkey         LIKE zmbew-bwkey,
        werks         LIKE zmseg-werks,
        matnr         LIKE zmseg-matnr,
        charg         LIKE zmseg-charg,
*(DEL)  endmenge like mard-labst,          "Bestand zu 'datum-high' XJD
        endmenge(09)  TYPE p DECIMALS 3,    "Bestand zu 'datum-high' XJD
*(DEL)  anfmenge like mard-labst,          "Bestand zu 'datum-low'  XJD
        anfmenge(09)  TYPE p DECIMALS 3,   "Bestand zu 'datum-low'   XJD
        meins         LIKE zmara-meins,             "Mengeneinheit
*       values at date-low and date-high                    "n497992
        endwert(09)   TYPE p DECIMALS 2,                    "n497992
        anfwert(09)   TYPE p DECIMALS 2,                    "n497992

*(DEL)  soll  like mseg-menge,                                     "XJD
        soll(09)      TYPE p DECIMALS 3,                                "XJD
*(DEL)  haben like mseg-menge,                                     "XJD
        haben(09)     TYPE p DECIMALS 3,                               "XJD
        sollwert(09)  TYPE p DECIMALS 2,                    "n497992
        habenwert(09) TYPE p DECIMALS 2,                    "n497992
        waers         LIKE zt001-waers.             "Währungsschlüssel
*ENHANCEMENT-POINT rm07mldd_02 SPOTS es_rm07mlbd STATIC.
DATA:
      END OF bestand.

DATA: BEGIN OF bestand1 OCCURS 100,
        bwkey         LIKE zmbew-bwkey,
        werks         LIKE zmseg-werks,
        matnr         LIKE zmseg-matnr,
        charg         LIKE zmseg-charg,
*(DEL)  endmenge like mard-labst,          "Bestand zu 'datum-high' XJD
        endmenge(09)  TYPE p DECIMALS 3,    "Bestand zu 'datum-high' XJD
*(DEL)  anfmenge like mard-labst,          "Bestand zu 'datum-low'  XJD
        anfmenge(09)  TYPE p DECIMALS 3,    "Bestand zu 'datum-low'  XJD
        meins         LIKE zmara-meins,             "Mengeneinheit
        endwert(09)   TYPE p DECIMALS 2,                    "n497992
        anfwert(09)   TYPE p DECIMALS 2,                    "n497992
*(DEL)  soll  like mseg-menge,                                     "XJD
        soll(09)      TYPE p DECIMALS 3,                                "XJD
*(DEL)  haben like mseg-menge,                                     "XJD
        haben(09)     TYPE p DECIMALS 3,                               "XJD
        sollwert(09)  TYPE p DECIMALS 2,                    "n497992
        habenwert(09) TYPE p DECIMALS 2,                    "n497992
        waers         LIKE zt001-waers.             "Währungsschlüssel
*ENHANCEMENT-POINT ehp605_rm07mldd_09 SPOTS es_rm07mlbd STATIC .
DATA: END OF bestand1.

DATA: BEGIN OF sum_mat OCCURS 100,
        werks     LIKE zmseg-werks,
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3.                               "XJD
*ENHANCEMENT-POINT ehp605_rm07mldd_10 SPOTS es_rm07mlbd STATIC .
DATA: END OF sum_mat.

DATA: BEGIN OF sum_char OCCURS 100,
        werks     LIKE zmseg-werks,
        matnr     LIKE zmseg-matnr,
        charg     LIKE zmseg-charg,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3.                               "XJD
*ENHANCEMENT-POINT ehp605_rm07mldd_11 SPOTS es_rm07mlbd STATIC .
DATA: END OF sum_char.

DATA: BEGIN OF weg_mat OCCURS 100,
        werks     LIKE zmseg-werks,
        lgort     LIKE zmseg-lgort,                             " P30K140665
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3.                               "XJD
*ENHANCEMENT-POINT ehp605_rm07mldd_12 SPOTS es_rm07mlbd STATIC .
DATA: END OF weg_mat.

DATA: BEGIN OF weg_char OCCURS 100,
        werks     LIKE zmseg-werks,
        matnr     LIKE zmseg-matnr,
        lgort     LIKE zmseg-lgort,                             " P30K140665
        charg     LIKE zmseg-charg,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3.                               "XJD
*ENHANCEMENT-POINT ehp605_rm07mldd_13 SPOTS es_rm07mlbd STATIC .
DATA: END OF weg_char.

DATA: BEGIN OF mat_sum OCCURS 100,
        bwkey     LIKE zmbew-bwkey,
        werks     LIKE zmseg-werks,
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3,                               "XJD
        dmbtr(09) TYPE p DECIMALS 3.                        "n497992
*ENHANCEMENT-POINT ehp605_rm07mldd_14 SPOTS es_rm07mlbd STATIC .
DATA: END OF mat_sum.

DATA: BEGIN OF mat_sum_buk OCCURS 100,
        bwkey     LIKE zmbew-bwkey,
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3,                               "XJD
        dmbtr(09) TYPE p DECIMALS 3.                        "n497992
*ENHANCEMENT-POINT ehp605_rm07mldd_15 SPOTS es_rm07mlbd STATIC .
DATA: END OF mat_sum_buk.

DATA: BEGIN OF mat_weg OCCURS 100,
        bwkey     LIKE zmbew-bwkey,
        werks     LIKE zmseg-werks,
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3,                               "XJD
        dmbtr(09) TYPE p DECIMALS 3.                        "n497992
*ENHANCEMENT-POINT ehp605_rm07mldd_16 SPOTS es_rm07mlbd STATIC .
DATA: END OF mat_weg.

DATA: BEGIN OF mat_weg_buk OCCURS 100,
        bwkey     LIKE zmbew-bwkey,
        matnr     LIKE zmseg-matnr,
        shkzg     LIKE zmseg-shkzg,
        menge(09) TYPE p DECIMALS 3,                               "XJD
        dmbtr(09) TYPE p DECIMALS 3.                        "n497992
*ENHANCEMENT-POINT ehp605_rm07mldd_17 SPOTS es_rm07mlbd STATIC .
DATA: END OF mat_weg_buk.

*----------------------- Feldleisten ----------------------------------*

DATA: BEGIN OF leiste,
        werks LIKE zmseg-werks,
        bwkey LIKE zmbew-bwkey,
        matnr LIKE zmseg-matnr,
        charg LIKE zmseg-charg,
      END OF leiste.

*------------------------ Hilfsfelder ---------------------------------*

DATA:
       curm          LIKE ztcurm-bwkrs_cus,
      bukr          LIKE zt001-bukrs,
      bwkr          LIKE zt001k-bwkey,
      werk          LIKE zt001w-werks,
      name          LIKE zt001w-name1,
      lort          LIKE zt001l-lgort,
      waer          LIKE zt001-waers,
      index_0       LIKE sy-tabix,
      index_1       LIKE sy-tabix,
      index_2       LIKE sy-tabix,
      index_3       LIKE sy-tabix,
      index_4       LIKE sy-tabix,
      aktdat        LIKE sy-datlo,
      sortfield(30),
      material(30),

      new_bwagr     LIKE zt156s-bwagr,
      old_bwagr     LIKE zt156s-bwagr,
      leer(1)       TYPE c,
      counter       LIKE sy-tabix,
      inhalt(10)    TYPE n.

DATA: jahrlow(4)   TYPE c,
      monatlow(2)  TYPE c,
      taglow(2)    TYPE c,
      jahrhigh(4)  TYPE c,
      monathigh(2) TYPE c,
      taghigh(2)   TYPE c.

* zur Berechtigungsprüfung:
DATA actvt03 LIKE tact-actvt VALUE '03'.         "anzeigen

*-------------------- FELDER FÜR LISTVIEWER ---------------------------*

DATA: repid      LIKE sy-repid.
DATA: fieldcat   TYPE slis_t_fieldcat_alv.
DATA: xheader    TYPE slis_t_listheader WITH HEADER LINE.
DATA: keyinfo    TYPE slis_keyinfo_alv.
DATA: color      TYPE slis_t_specialcol_alv WITH HEADER LINE.
DATA: layout     TYPE slis_layout_alv.
DATA: events     TYPE slis_t_event WITH HEADER LINE.
DATA: event_exit TYPE slis_t_event_exit WITH HEADER LINE.
DATA: sorttab    TYPE slis_t_sortinfo_alv WITH HEADER LINE.
DATA: filttab    TYPE slis_t_filter_alv WITH HEADER LINE.
*data: extab      type slis_t_extab with header line.              "XJD

* Listanzeigevarianten
DATA: variante        LIKE disvariant,                " Anzeigevariante
      def_variante    LIKE disvariant,                " Defaultvariante
      variant_exit(1) TYPE c,
      variant_save(1) TYPE c,
      variant_def(1)  TYPE c.

* save the name of the default display variant              "n599218
DATA: alv_default_variant    LIKE  disvariant-variant.      "n599218

* Gruppen Positionsfelder
DATA: gruppen TYPE slis_t_sp_group_alv WITH HEADER LINE.

* structure for print ALV print parameters
DATA: g_s_print              TYPE      slis_print_alv.

*----------------------------------------------------------------------*

* working area : get the field names of a structure
TYPE-POOLS : sydes.

DATA : g_t_td       TYPE sydes_desc,
       g_s_typeinfo TYPE sydes_typeinfo,
       g_s_nameinfo TYPE sydes_nameinfo.

* new definitions for table organ
TYPES : BEGIN OF stype_organ,
          keytype(01) TYPE c,
          keyfield    LIKE zt001w-werks,
          bwkey       LIKE zt001k-bwkey,
          werks       LIKE zt001w-werks,
          bukrs       LIKE zt001-bukrs,
          ktopl       LIKE zt001-ktopl,
          bwmod       LIKE zt001k-bwmod,
          waers       LIKE zt001-waers,
        END OF stype_organ,

        stab_organ TYPE STANDARD TABLE OF stype_organ
       WITH KEY keytype keyfield bwkey werks.

DATA : g_s_organ TYPE stype_organ,
       g_t_organ TYPE stab_organ
                           WITH HEADER LINE.

* buffer table for check authority for plants
TYPES : BEGIN OF stype_auth_plant,
          werks  LIKE zmseg-werks,
          ok(01) TYPE c,
        END OF stype_auth_plant.

TYPES : stab_auth_plant      TYPE STANDARD TABLE OF
                             stype_auth_plant WITH KEY werks.
DATA : g_t_auth_plant        TYPE stab_auth_plant WITH HEADER LINE.

* for the assignment of the MM and FI documents             "n443935
TYPES : BEGIN OF stype_bsim_lean,                           "n443935
          bukrs    LIKE zbkpf-bukrs,                         "n443935
          bwkey    LIKE zbsim-bwkey,                         "n443935
          matnr    LIKE zbsim-matnr,                         "n443935
          bwtar    LIKE zbsim-bwtar,                         "n443935
          shkzg    LIKE zbsim-shkzg,                         "n443935
          meins    LIKE zbsim-meins,                         "n443935
          budat    LIKE zbsim-budat,                         "n443935
          blart    LIKE zbsim-blart,                         "n443935
          buzei    LIKE zbsim-buzei,                         "n497992
                                                            "n443935
          awkey    LIKE zbkpf-awkey,                         "n443935
          belnr    LIKE zbsim-belnr,                         "n443935
          gjahr    LIKE zbsim-gjahr,                         "n443935
          menge    LIKE zbsim-menge,                         "n443935
          dmbtr    LIKE zbsim-dmbtr,                         "n443935
          accessed TYPE c,                                  "n443935
          tabix    LIKE sy-tabix,                           "n443935
        END OF stype_bsim_lean,                             "n443935
                                                            "n443935
        stab_bsim_lean TYPE STANDARD TABLE OF               "n443935
           stype_bsim_lean                                  "n443935
           WITH DEFAULT KEY.                                "n443935

DATA : g_t_bsim_lean TYPE stab_bsim_lean,                   "n443935
       g_s_bsim_lean TYPE stype_bsim_lean,                  "n443935
       g_t_bsim_work TYPE stab_bsim_lean,                   "n443935
       g_s_bsim_work TYPE stype_bsim_lean.                  "n443935

* for the control break                                     "n443935
TYPES : BEGIN OF stype_mseg_group,                          "n443935
          mblnr LIKE zmkpf-mblnr,                            "n443935
          mjahr LIKE zmkpf-mjahr,                            "n443935
          bukrs LIKE zbkpf-bukrs,                            "n443935
          bwkey LIKE zbsim-bwkey,                            "n443935
          matnr LIKE zmseg-matnr,                            "n443935
          bwtar LIKE zmseg-bwtar,                            "n443935
          shkzg LIKE zmseg-shkzg,                            "n443935
          meins LIKE zmseg-meins,                            "n443935
          budat LIKE zmkpf-budat,                            "n443935
          blart LIKE zmkpf-blart,                            "n443935
        END OF stype_mseg_group.                            "n443935
                                                            "n443935
DATA : g_s_mseg_old TYPE stype_mseg_group,                  "n443935
       g_s_mseg_new TYPE stype_mseg_group.                  "n443935
                                                            "n443935
* Structure to separate AWKEY into MBLNR/MJAHR in a         "n443935
* clean way.                                                "n443935
DATA: BEGIN OF matkey,                                      "n443935
        mblnr LIKE zmkpf-mblnr,                              "n443935
        mjahr LIKE zmkpf-mjahr,                              "n443935
      END OF matkey.                                        "n443935

* global contants
CONSTANTS : c_space(01)      TYPE c VALUE ' ',
            c_bwkey(01)      TYPE c VALUE 'B',
            c_error(01)      TYPE c VALUE 'E',
            c_no_error(01)   TYPE c VALUE 'N',
            c_werks(01)      TYPE c VALUE 'W',
            c_no_space(01)   TYPE c VALUE 'N',
            c_space_only(01) TYPE c VALUE 'S',
            c_tilde(01)      TYPE c VALUE '~',
            c_check(01)      TYPE c VALUE 'C',
            c_take(01)       TYPE c VALUE 'T',
            c_out(01)        TYPE c VALUE c_space,
            c_no_out(01)     TYPE c VALUE 'X'.

* for the use of the pushbutton                             "n599218
CONSTANTS : c_show(01) TYPE c VALUE 'S',                    "n599218
            c_hide(01) TYPE c VALUE 'H'.                    "n599218

* for the field catalog
DATA : g_s_fieldcat TYPE slis_fieldcat_alv,
       g_f_tabname  TYPE slis_tabname,
       g_f_col_pos  TYPE i.

* global used fields
DATA : g_flag_delete(01)    TYPE c,
       g_flag_authority(01) TYPE c,
       g_f_cnt_lines        TYPE i,
       g_f_cnt_lines_bukrs  TYPE i,
       g_f_cnt_lines_werks  TYPE i,
       g_f_cnt_before       TYPE i,
       g_f_cnt_after        TYPE i.

* working fields for the headlines and page numbers         "n599218
DATA : g_f_cnt_bestand_total TYPE i,                        "n599218
       g_f_cnt_bestand_curr  TYPE i.                        "n599218
                                                            "n599218
DATA : BEGIN OF g_s_header_77,                              "n599218
         date(10)      TYPE c,                              "n599218
         filler_01(01) TYPE c,                              "n599218
         title(59)     TYPE c,                              "n599218
         filler_02(01) TYPE c,                              "n599218
         page(06)      TYPE c,                              "n599218
       END OF g_s_header_77,                                "n599218
                                                            "n599218
       BEGIN OF g_s_header_91,                              "n599218
         date(10)      TYPE c,                              "n599218
         filler_01(01) TYPE c,                              "n599218
         title(73)     TYPE c,                              "n599218
         filler_02(01) TYPE c,                              "n599218
         page(06)      TYPE c,                              "n599218
       END OF g_s_header_91.                                "n599218
                                                            "n599218
DATA : g_end_line_77(77) TYPE c,                            "n599218
       g_end_line_91(91) TYPE c.                            "n599218
                                                            "n599218
* for the scope of list                                     "n599218
DATA : g_cnt_empty_parameter TYPE i.                        "n599218
DATA : g_flag_status_liu(01) TYPE c    VALUE 'H'.           "n599218
                                                            "n599218
* flag to be set when INITIALIZATION was processed          "n599218
DATA g_flag_initialization(01) TYPE c.                      "n599218
                                                            "n599218
* flag for activate ALV ivterface check                     "n599218
DATA g_flag_i_check(01)      TYPE c.                        "n599218

DATA :
       g_f_bwkey          LIKE zmbew-bwkey,                  "n443935
       g_f_tabix          LIKE sy-tabix,                    "n443935
       g_f_tabix_start    LIKE sy-tabix,                    "n443935
       g_cnt_loop         LIKE sy-tabix,                    "n443935
       g_cnt_mseg_entries LIKE sy-tabix,                    "n443935
       g_cnt_bsim_entries LIKE sy-tabix,                    "n443935
       g_cnt_mseg_done    LIKE sy-tabix.                    "n443935

* for the processing of tied empties                        "n497992
DATA : g_f_werks_retail      LIKE      zt001w-werks.         "n497992

* reference procedures for checking FI summarization        "n497992
RANGES : g_ra_awtyp          FOR  zttypv-awtyp.              "n497992

* global range tables for the database selection
RANGES : g_ra_bwkey          FOR zt001k-bwkey,    "valuation area
         g_ra_werks          FOR zt001w-werks,    "plant
         g_ra_sobkz          FOR zmseg-sobkz,     "special st. ind.
         g_ra_lgort          FOR zmseg-lgort.     "storage location

* global range tables for the creation of table g_t_organ
RANGES : g_0000_ra_bwkey     FOR zt001k-bwkey,    "valuation area
         g_0000_ra_werks     FOR zt001w-werks,    "plant
         g_0000_ra_bukrs     FOR zt001-bukrs.     "company code

* internal range for valuation class restriction
RANGES : ibklas     FOR zmbew-bklas.

* global table with the material numbers as key for reading MAKT
TYPES : BEGIN OF stype_mat_key,
          matnr LIKE zmara-matnr,
        END OF   stype_mat_key.

TYPES : stab_mat_key         TYPE STANDARD TABLE OF stype_mat_key
                             WITH KEY matnr.

DATA: g_t_mat_key            TYPE      stab_mat_key
                             WITH HEADER LINE.

* global table with the key for the FI documents BKPF
TYPES : BEGIN OF stype_bkpf_key,
          bukrs LIKE zbkpf-bukrs,
          belnr LIKE zbkpf-belnr,
          gjahr LIKE zbkpf-gjahr,
        END OF   stype_bkpf_key.

* global table with the key for the FI documents BSEG
TYPES : BEGIN OF stype_bseg_key,
          bukrs LIKE zbseg-bukrs,
          belnr LIKE zbseg-belnr,
          gjahr LIKE zbseg-gjahr,
          buzei LIKE zbseg-buzei,
        END OF   stype_bseg_key.

TYPES : stab_bkpf_key        TYPE STANDARD TABLE OF stype_bkpf_key
                             WITH KEY bukrs belnr gjahr.
TYPES : stab_bseg_key        TYPE STANDARD TABLE OF stype_bseg_key
                             WITH KEY bukrs belnr gjahr buzei.

DATA: g_t_bkpf_key           TYPE      stab_bkpf_key
                             WITH HEADER LINE.
DATA: g_t_bseg_key           TYPE      stab_bseg_key
                             WITH HEADER LINE.

* separate time depending authorization for tax auditor     "n486477
* define working areas for time depending authority check   "n486477
DATA : g_f_budat      LIKE zbsim-budat,                      "n486477
       g_f_budat_work LIKE zbsim-budat.                      "n486477
                                                            "n486477
TYPES : BEGIN OF stype_bukrs,                               "n486477
          bukrs LIKE zt001-bukrs,                            "n486477
        END OF stype_bukrs,                                 "n486477
                                                            "n486477
        stab_bukrs TYPE STANDARD TABLE OF                   "n486477
       stype_bukrs WITH DEFAULT KEY.                        "n486477
                                                            "n486477
DATA : g_t_bukrs TYPE stab_bukrs,                           "n486477
       g_s_bukrs TYPE stype_bukrs.                          "n486477
                                                            "n486477
TYPES : BEGIN OF stype_work,                                "n486477
          werks LIKE zt001w-werks,                           "n486477
          bwkey LIKE zt001k-bwkey,                           "n486477
          bukrs LIKE zt001-bukrs,                            "n486477
        END OF stype_work.                                  "n486477
                                                            "n486477
DATA : g_s_t001w TYPE stype_work,                           "n486477
       g_t_t001w TYPE stype_work OCCURS 0,                  "n486477
       g_s_t001k TYPE stype_work,                           "n486477
       g_t_t001k TYPE stype_work OCCURS 0.                  "n486477
                                                            "n486477
DATA : g_flag_tpcuser(01) TYPE c,                           "n486477
*      1 = carry out the special checks for this user       "n486477
       g_f_repid          LIKE sy-repid.                    "n497992

* for the representation of tied empties                    "n547170
* range table for special indicators of field MSEG-XAUTO    "n547170
RANGES : g_ra_xauto          FOR  zmseg-xauto.               "n547170
                                                            "n547170
DATA   : g_f_zeile           LIKE  zmseg-zeile.              "n547170
                                                            "n547170
TYPES : BEGIN OF stype_mseg_xauto,                          "n547170
          mblnr LIKE zmseg-mblnr,                            "n547170
          mjahr LIKE zmseg-mjahr,                            "n547170
          zeile LIKE zmseg-zeile,                            "n547170
          matnr LIKE zmseg-matnr,                            "n547170
          xauto LIKE zmseg-xauto,                            "n547170
        END OF stype_mseg_xauto,                            "n547170
                                                            "n547170
        stab_mseg_xauto TYPE STANDARD TABLE OF              "n547170
            stype_mseg_xauto                                "n547170
            WITH DEFAULT KEY.                               "n547170
                                                            "n547170
* working area for the previous entry                       "n547170
DATA : g_s_mseg_pr  TYPE stype_mseg_xauto,                  "n547170
                                                            "n547170
* table for the original MM doc posting lines               "n547170
       g_s_mseg_or  TYPE stype_mseg_xauto,                  "n547170
       g_t_mseg_or  TYPE stab_mseg_xauto,                   "n547170
                                                            "n547170
* table for the keys of the original MM doc lines           "n547170
       g_s_mseg_key TYPE stype_mseg_xauto,                  "n547170
       g_t_mseg_key TYPE stab_mseg_xauto.                   "n547170

*----------------------------------------------------------------------*
* new data definitions
*----------------------------------------------------------------------*

*   for the selection of the reversal movements only in release >=45B
DATA: BEGIN OF storno OCCURS 0,
        mblnr LIKE zmseg-mblnr,
        mjahr LIKE zmseg-mjahr,
        zeile LIKE zmseg-zeile,
        smbln LIKE zmseg-smbln,
        sjahr LIKE zmseg-sjahr,
        smblp LIKE zmseg-smblp,
      END OF storno.

* working fields for reading structures from DDIC           "n599218 A
* and check whether IS-OIL is active                        "n599218 A
TYPES : stab_x031l           TYPE STANDARD TABLE OF x031l   "n599218 A
                             WITH DEFAULT KEY.              "n599218 A
*                                                            "n599218 A
DATA : g_s_x031l TYPE x031l,                                "n599218 A
       g_t_x031l TYPE stab_x031l.                           "n599218 A
                                                            "n599218 A
DATA : g_f_dcobjdef_name        LIKE dcobjdef-name,         "n599218 A
       g_flag_is_oil_active(01) TYPE c,                     "n599218 A
       g_cnt_is_oil             TYPE i.                     "n599218 A

DATA : g_flag_found(01)      TYPE c.

DATA : g_f_butxt          LIKE zt001-butxt,
       g_f_tabname_totals LIKE dcobjdef-name,
       g_f_tabname_belege LIKE dcobjdef-name.

DATA : BEGIN OF g_save_params,
         werks LIKE zmseg-werks,
         matnr LIKE zmseg-matnr,
         charg LIKE zmseg-charg,
         belnr LIKE zbseg-belnr,
         bukrs LIKE zbseg-bukrs,
         gjahr LIKE zbseg-gjahr,
       END OF g_save_params.

DATA: g_t_events_totals_flat TYPE slis_t_event WITH HEADER LINE.
DATA: events_hierseq         TYPE slis_t_event WITH HEADER LINE.

DATA: g_t_fieldcat_totals_hq   TYPE slis_t_fieldcat_alv,
      g_t_fieldcat_totals_flat TYPE slis_t_fieldcat_alv.

DATA: fieldcat_hierseq       TYPE slis_t_fieldcat_alv.

DATA: g_s_keyinfo_totals_hq  TYPE slis_keyinfo_alv.

DATA: g_s_sorttab TYPE slis_sortinfo_alv,
      g_t_sorttab TYPE slis_t_sortinfo_alv.

DATA: g_s_sort_totals_hq TYPE slis_sortinfo_alv,
      g_t_sort_totals_hq TYPE slis_t_sortinfo_alv.

DATA: g_s_vari_sumhq     LIKE disvariant,
      g_s_vari_sumhq_def LIKE disvariant,
      g_s_vari_sumfl     LIKE disvariant,
      g_s_vari_sumfl_def LIKE disvariant.

* contains the a structure with the max. number of fields of
* the database table MSEG, but those lines are comment lines
* with a '*'. The customer can achtivate those lines.
* The activated fields will be selected from the database table
* and are hidden in the list. With the settings in the display
* variant the can be shown.
INCLUDE                      zrm07mlbd_cust_fields.

* common types structure for working tables
* a) g_t_mseg_lean   results form database selection
* b) g_t_beleg       data table for ALV
TYPES : BEGIN OF stype_mseg_lean,
          mblnr        LIKE zmkpf-mblnr,
          mjahr        LIKE zmkpf-mjahr,
          vgart        LIKE zmkpf-vgart,
          blart        LIKE zmkpf-blart,
          budat        LIKE zmkpf-budat,
          cpudt        LIKE zmkpf-cpudt,
          cputm        LIKE zmkpf-cputm,
          usnam        LIKE zmkpf-usnam,
* process 'goods receipt/issue slip' as hidden field        "n450596
          xabln        LIKE zmkpf-xabln,                     "n450596

          lbbsa        LIKE zt156m-lbbsa,
          bwagr        LIKE zt156s-bwagr,
          bukrs        LIKE zt001-bukrs,

          belnr        LIKE zbkpf-belnr,
          gjahr        LIKE zbkpf-gjahr,
          buzei        LIKE zbseg-buzei,
          hkont        LIKE zbseg-hkont,

          waers        LIKE zmseg-waers,
          zeile        LIKE zmseg-zeile,
          bwart        LIKE zmseg-bwart,
          matnr        LIKE zmseg-matnr,
          werks        LIKE zmseg-werks,
          lgort        LIKE zmseg-lgort,
          charg        LIKE zmseg-charg,
          bwtar        LIKE zmseg-bwtar,
          kzvbr        LIKE zmseg-kzvbr,
          kzbew        LIKE zmseg-kzbew,
          sobkz        LIKE zmseg-sobkz,
          kzzug        LIKE zmseg-kzzug,
          bustm        LIKE zmseg-bustm,
          bustw        LIKE zmseg-bustw,
          mengu        LIKE zmseg-mengu,
          wertu        LIKE zmseg-wertu,
          shkzg        LIKE zmseg-shkzg,
          menge        LIKE zmseg-menge,
          meins        LIKE zmseg-meins,
          dmbtr        LIKE zmseg-dmbtr,
          dmbum        LIKE zmseg-dmbum,
          xauto        LIKE zmseg-xauto,
          kzbws        LIKE zmseg-kzbws,
          xobew        LIKE zmseg-xobew,
"          special flag for retail                          "n497992
          retail(01)   TYPE c,                              "n497992

* define the fields for the IO-OIL specific functions       "n599218 A
*          mseg-oiglcalc     CHAR          1                "n599218 A
*          mseg-oiglsku      QUAN         13                "n599218 A
          oiglcalc(01) TYPE c,                              "n599218 A
          oiglsku(07)  TYPE p DECIMALS 3,                   "n599218 A
          insmk        LIKE zmseg-insmk,                     "n599218 A

* the following fields are used for the selection of
* the reversal movements
          smbln        LIKE zmseg-smbln,    " No. doc
          sjahr        LIKE zmseg-sjahr,    " Year          "n497992
          smblp        LIKE zmseg-smblp.    " Item in doc
*ENHANCEMENT-POINT ehp605_rm07mldd_18 SPOTS es_rm07mlbd STATIC .
* additional fields : the user has the possibility to activate
* these fields in the following include report



        "INCLUDE           TYPE      stype_mb5b_add.




TYPES : END OF stype_mseg_lean.

TYPES: stab_mseg_lean        TYPE STANDARD TABLE OF stype_mseg_lean
                             WITH KEY mblnr mjahr.

TYPES : BEGIN OF stype_bestand_key,
          matnr LIKE zmseg-matnr,
          werks LIKE zmseg-werks,
          bwkey LIKE zmbew-bwkey,
          charg LIKE zmseg-charg,
        END OF stype_bestand_key.

DATA : g_s_bestand_key       TYPE  stype_bestand_key.

* data tables with the results for the ALV
TYPES : BEGIN OF stype_belege,
          bwkey LIKE zmbew-bwkey.
        INCLUDE            TYPE      stype_mseg_lean.
TYPES :   farbe_pro_feld      TYPE slis_t_specialcol_alv,
          farbe_pro_zeile(03) TYPE c.
TYPES : END OF stype_belege.

TYPES : stab_belege          TYPE STANDARD TABLE OF stype_belege
                             WITH KEY  budat mblnr zeile.

DATA : g_t_belege    TYPE stab_belege WITH HEADER LINE,
       g_t_belege1   TYPE stab_belege WITH HEADER LINE,
       g_t_belege_uc TYPE stab_belege WITH HEADER LINE.

* new output tables for to list in total mode
TYPES : BEGIN OF stype_totals_header,
          bwkey LIKE zmbew-bwkey,
          werks LIKE zmseg-werks,
          matnr LIKE zmbew-matnr,
          charg LIKE zmseg-charg,
          sobkz LIKE zmslb-sobkz,

          name1 LIKE zt001w-name1,
          maktx LIKE zmakt-maktx,
        END OF stype_totals_header.

TYPES:  BEGIN OF stype_totals_item,
          bwkey          LIKE zmbew-bwkey,
          werks          LIKE zmseg-werks,
          matnr          LIKE zmbew-matnr,
          charg          LIKE zmseg-charg,

          counter        TYPE i,
          stock_type(40) TYPE c,
          menge(09)      TYPE p DECIMALS 3,
          meins          LIKE zmara-meins,
          wert(09)       TYPE p DECIMALS 2.
"ENHANCEMENT-POINT ehp605_rm07mldd_19 SPOTS es_rm07mlbd STATIC .
TYPES:    waers LIKE zt001-waers,             "Währungsschlüssel
          color TYPE slis_t_specialcol_alv,
          END OF stype_totals_item.

TYPES:  stab_totals_header TYPE STANDARD TABLE OF
                           stype_totals_header
                           WITH DEFAULT KEY,

        stab_totals_item   TYPE STANDARD TABLE OF
                           stype_totals_item
                           WITH DEFAULT KEY.

DATA : g_s_totals_header TYPE stype_totals_header,
       g_t_totals_header TYPE stab_totals_header.

DATA : g_s_totals_item TYPE stype_totals_item,
       g_t_totals_item TYPE stab_totals_item.

* new output table for flat list in total mode
TYPES : BEGIN OF stype_totals_flat,
          matnr        LIKE zmbew-matnr,
          maktx        LIKE zmakt-maktx,
          bwkey        LIKE zmbew-bwkey,
          werks        LIKE zmseg-werks,
          charg        LIKE zmseg-charg,
          sobkz        LIKE zmslb-sobkz,
          name1        LIKE zt001w-name1,                    "n999530

          start_date   LIKE sy-datlo,
          end_date     LIKE sy-datlo,

          anfmenge(09) TYPE p DECIMALS 3,
          meins        LIKE zmara-meins,
          soll(09)     TYPE p DECIMALS 3,
          haben(09)    TYPE p DECIMALS 3,
          endmenge(09) TYPE p DECIMALS 3.
"ENHANCEMENT-POINT ehp605_rm07mldd_20 SPOTS es_rm07mlbd STATIC .
TYPES:    anfwert(09)   TYPE p DECIMALS 2,
          waers         LIKE zt001-waers,             "Währungsschlüssel
          sollwert(09)  TYPE p DECIMALS 2,
          habenwert(09) TYPE p DECIMALS 2,
          endwert(09)   TYPE p DECIMALS 2,
          color         TYPE slis_t_specialcol_alv,
          END OF stype_totals_flat,

          stab_totals_flat TYPE STANDARD TABLE OF stype_totals_flat
           WITH DEFAULT KEY.

DATA : g_s_totals_flat TYPE stype_totals_flat,
       g_t_totals_flat TYPE stab_totals_flat.
*
* for the colorizing of the numeric fields
DATA : g_s_color TYPE slis_specialcol_alv,
       g_t_color TYPE slis_t_specialcol_alv.

DATA : g_s_layout_totals_hq   TYPE slis_layout_alv,
       g_s_layout_totals_flat TYPE slis_layout_alv.

DATA : g_f_length     TYPE i,
       g_f_length_max TYPE i.

DATA : g_offset_header TYPE i,
       g_offset_qty    TYPE i,
       g_offset_unit   TYPE i,
       g_offset_value  TYPE i,
       g_offset_curr   TYPE i.

TYPES : BEGIN OF stype_date_line,
          text(133) TYPE c,
          datum(10) TYPE c,
        END OF stype_date_line.

DATA : g_date_line_from TYPE stype_date_line,
       g_date_line_to   TYPE stype_date_line.

DATA : BEGIN OF g_text_line,
         filler(02) TYPE c,
         text(133)  TYPE c,
       END OF g_text_line.

* interface structure for new TOP_OF_PAGE and the detail list
TYPES : BEGIN OF stype_bestand.
        INCLUDE STRUCTURE  bestand.
TYPES : END OF stype_bestand.

TYPES : stab_bestand         TYPE STANDARD TABLE OF stype_bestand
                             WITH DEFAULT KEY.

DATA : g_s_bestand        TYPE stype_bestand,
       g_s_bestand_detail TYPE stype_bestand,
       g_t_bestand_detail TYPE stab_bestand.

DATA : l_f_meins_external       TYPE  zmara-meins.           "n1018717


* global working areas data from MSEG and MKPF
FIELD-SYMBOLS : <g_fs_mseg_lean>       TYPE stype_mseg_lean.
DATA : g_s_mseg_lean   TYPE stype_mseg_lean,
       g_s_mseg_update TYPE stype_mseg_lean,                "n443935
       g_t_mseg_lean   TYPE stab_mseg_lean.

* working table for the control break                       "n451923
TYPES : BEGIN OF stype_mseg_work.                           "n451923
        INCLUDE            TYPE      stype_mseg_lean.       "n451923
TYPES :    tabix LIKE sy-tabix,                             "n451923
           END OF stype_mseg_work,                          "n451923
                                                            "n451923
           stab_mseg_work TYPE STANDARD TABLE OF            "n451923
        stype_mseg_work                                     "n451923
        WITH DEFAULT KEY.                                   "n451923
                                                            "n451923
DATA : g_t_mseg_work TYPE stab_mseg_work,                   "n443935
       g_s_mseg_work TYPE stype_mseg_work.                  "n443935

* working table for the requested field name from MSEG and MKPF
TYPES: BEGIN OF stype_fields,
         fieldname TYPE name_feld,
       END OF stype_fields.

TYPES: stab_fields           TYPE STANDARD TABLE OF stype_fields
                             WITH KEY fieldname.

DATA: g_t_mseg_fields TYPE stab_fields,
      g_s_mseg_fields TYPE stype_fields.

* working table for the requested numeric fields of MSEG
TYPES : BEGIN OF stype_color_fields,
          fieldname TYPE name_feld,
          type(01)  TYPE c,
        END OF stype_color_fields,

        stab_color_fields TYPE STANDARD TABLE OF
              stype_color_fields
              WITH DEFAULT KEY.

DATA: g_t_color_fields       TYPE      stab_color_fields
                             WITH HEADER LINE.

DATA: BEGIN OF imsweg OCCURS 1000,
        mblnr        LIKE zmseg-mblnr,
        mjahr        LIKE zmseg-mjahr,
        zeile        LIKE zmseg-zeile,
        matnr        LIKE zmseg-matnr,
        charg        LIKE zmseg-charg,
        bwtar        LIKE zmseg-bwtar,
        werks        LIKE zmseg-werks,
        lgort        LIKE zmseg-lgort,
        sobkz        LIKE zmseg-sobkz,
        bwart        LIKE zmseg-bwart,
        shkzg        LIKE zmseg-shkzg,
        xauto        LIKE zmseg-xauto,
        menge        LIKE zmseg-menge,
        meins        LIKE zmseg-meins,
        dmbtr        LIKE zmseg-dmbtr,
        dmbum        LIKE zmseg-dmbum,
        bustm        LIKE zmseg-bustm,
        bustw        LIKE zmseg-bustw,                       "147374

* define the fields for the IO-OIL specific functions       "n599218 A
*       mseg-oiglcalc        CHAR          1                "n599218 A
*       mseg-oiglsku         QUAN         13                "n599218 A
        oiglcalc(01) TYPE c,                                "n599218 A
        oiglsku(07)  TYPE p DECIMALS 3,                     "n599218 A
        insmk        LIKE zmseg-insmk.                       "n599218 A
"ENHANCEMENT-POINT ehp605_rm07mldd_21 SPOTS es_rm07mlbd STATIC .
DATA:
      END OF imsweg.
*
** User settings for the checkboxes                          "n547170
DATA: oref_settings TYPE REF TO zcl_mmim_userdefaults.       "n547170
