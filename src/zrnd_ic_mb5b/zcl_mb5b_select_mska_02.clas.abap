CLASS zcl_mb5b_select_mska_02 DEFINITION
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

    TYPES: BEGIN OF mska_typ,
             werks TYPE zmska-werks,
             lgort TYPE zmska-lgort,
             matnr TYPE zmska-matnr,
             sobkz TYPE zmska-sobkz,
             kalab TYPE zmska-kalab,
             kains TYPE zmska-kains,
             kaspe TYPE zmska-kaspe,
             kaein TYPE zmska-kaein.
*ENHANCEMENT-POINT ehp605_rm07mldd_05 SPOTS es_rm07mlbd STATIC .
    TYPES: END OF mska_typ.

    TYPES   ltt_output TYPE STANDARD TABLE OF mska_typ.

    DATA mt_output TYPE ltt_output.
ENDCLASS.



CLASS ZCL_MB5B_SELECT_MSKA_02 IMPLEMENTATION.


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
