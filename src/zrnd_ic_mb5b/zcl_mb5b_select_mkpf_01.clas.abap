CLASS zcl_mb5b_select_mkpf_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_select_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !iv_select_name   TYPE string
        !iv_package_size  TYPE int4 DEFAULT 100
        !iv_db_connection TYPE string OPTIONAL
        !it_select_opt    TYPE /iwbep/t_mgw_select_option OPTIONAL .


  PROTECTED SECTION.

    METHODS move_to_output
         REDEFINITION .
  PRIVATE SECTION.

    TYPES : BEGIN OF stype_mseg_lean,
              mblnr        TYPE zmkpf-mblnr,
              mjahr        TYPE zmkpf-mjahr,
              vgart        TYPE zmkpf-vgart,
              blart        TYPE zmkpf-blart,
              budat        TYPE zmkpf-budat,
              cpudt        TYPE zmkpf-cpudt,
              cputm        TYPE zmkpf-cputm,
              usnam        TYPE zmkpf-usnam,
* process 'goods receipt/issue slip' as hidden field        "n450596
              xabln        TYPE zmkpf-xabln,                "n450596

              lbbsa        TYPE zt156m-lbbsa,
              bwagr        TYPE zt156s-bwagr,
              bukrs        TYPE zt001-bukrs,

              belnr        TYPE zbkpf-belnr,
              gjahr        TYPE zbkpf-gjahr,
              buzei        TYPE zbseg-buzei,
              hkont        TYPE zbseg-hkont,

              waers        TYPE zmseg-waers,
              zeile        TYPE zmseg-zeile,
              bwart        TYPE zmseg-bwart,
              matnr        TYPE zmseg-matnr,
              werks        TYPE zmseg-werks,
              lgort        TYPE zmseg-lgort,
              charg        TYPE zmseg-charg,
              bwtar        TYPE zmseg-bwtar,
              kzvbr        TYPE zmseg-kzvbr,
              kzbew        TYPE zmseg-kzbew,
              sobkz        TYPE zmseg-sobkz,
              kzzug        TYPE zmseg-kzzug,
              bustm        TYPE zmseg-bustm,
              bustw        TYPE zmseg-bustw,
              mengu        TYPE zmseg-mengu,
              wertu        TYPE zmseg-wertu,
              shkzg        TYPE zmseg-shkzg,
              menge        TYPE zmseg-menge,
              meins        TYPE zmseg-meins,
              dmbtr        TYPE zmseg-dmbtr,
              dmbum        TYPE zmseg-dmbum,
              xauto        TYPE zmseg-xauto,
              kzbws        TYPE zmseg-kzbws,
              xobew        TYPE zmseg-xobew,
              "          special flag for retail                          "n497992
              retail(01)   TYPE c,                          "n497992

* define the fields for the IO-OIL specific functions       "n599218 A
*          mseg-oiglcalc     CHAR          1                "n599218 A
*          mseg-oiglsku      QUAN         13                "n599218 A
              oiglcalc(01) TYPE c,                          "n599218 A
              oiglsku(07)  TYPE p DECIMALS 3,               "n599218 A
              insmk        TYPE zmseg-insmk,                "n599218 A

* the following fields are used for the selection of
* the reversal movements
              smbln        TYPE zmseg-smbln,    " No. doc
              sjahr        TYPE zmseg-sjahr,    " Year          "n497992
              smblp        TYPE zmseg-smblp.    " Item in doc
*ENHANCEMENT-POINT ehp605_rm07mldd_18 SPOTS es_rm07mlbd STATIC .
* additional fields : the user has the possibility to activate
* these fields in the following include report
    "INCLUDE           TYPE      stype_mb5b_add.

    TYPES : END OF stype_mseg_lean.

    TYPES   ltt_output TYPE STANDARD TABLE OF stype_mseg_lean.

    DATA mt_output TYPE ltt_output.
ENDCLASS.



CLASS zcl_mb5b_select_mkpf_01 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_select_name = iv_select_name
    iv_package_size = iv_package_size
    iv_db_connection = iv_db_connection
    it_select_opt   = it_select_opt
     ).
  ENDMETHOD.


  METHOD move_to_output.

    FIELD-SYMBOLS <lv_field> TYPE any.
    DATA lt_row_ids TYPE TABLE OF zselect_generic_ui_s-row_id.

    LOOP AT mt_select_result ASSIGNING FIELD-SYMBOL(<ls_select_result>).
      INSERT <ls_select_result>-row_id INTO TABLE lt_row_ids.
    ENDLOOP.

    SORT  lt_row_ids.
    DELETE ADJACENT DUPLICATES FROM lt_row_ids.

    LOOP AT lt_row_ids ASSIGNING FIELD-SYMBOL(<lv_row_id>).

      INSERT INITIAL LINE INTO TABLE mt_output ASSIGNING FIELD-SYMBOL(<ls_output>).

      LOOP AT mt_select_result  ASSIGNING <ls_select_result> WHERE row_id = <lv_row_id>.

        ASSIGN COMPONENT <ls_select_result>-field_name OF STRUCTURE <ls_output> TO <lv_field>.
        IF sy-subrc = 0 AND <lv_field> IS ASSIGNED.
          <lv_field> = <ls_select_result>-field_value.
        ENDIF.

      ENDLOOP.

    ENDLOOP.

    et_output = mt_output.

  ENDMETHOD.
ENDCLASS.
