CLASS zcl_mb5b_select_mard_02 DEFINITION
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

    TYPES: BEGIN OF imard,    "aktueller Materialbestand
             werks     TYPE zmard-werks,      "Werk
             matnr     TYPE zmard-matnr,      "Material
             lgort     TYPE zmard-lgort,      "Lagerort
             labst     TYPE zmard-labst,      "frei verwendbarer Bestand
             umlme     TYPE zmard-umlme,      "Umlagerungsbestand
             insme     TYPE zmard-insme,      "Qualitätsprüfbestand
             einme     TYPE zmard-einme,      "nicht frei verwendbarer Bestand
             speme     TYPE zmard-speme,      "gesperrter Bestand
             retme     TYPE zmard-retme,      "gesperrter Bestand
             klabs     TYPE zmard-klabs,      "frei verw. Konsignationsbestand
             lbkum     TYPE zmbew-lbkum,      "bewerteter Bestand
             salk3(09) TYPE p DECIMALS 2,                   "n497992
             waers     TYPE zt001-waers.      "Währungseinheit
*ENHANCEMENT-POINT ehp605_rm07mldd_07 SPOTS es_rm07mlbd STATIC .
    TYPES: END OF imard.



    TYPES ltt_output TYPE STANDARD TABLE OF imard WITH DEFAULT KEY.
    DATA mt_output TYPE ltt_output.

ENDCLASS.



CLASS zcl_mb5b_select_mard_02 IMPLEMENTATION.


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
