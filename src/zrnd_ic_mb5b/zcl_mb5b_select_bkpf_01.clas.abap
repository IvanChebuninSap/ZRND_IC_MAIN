CLASS zcl_mb5b_select_bkpf_01 DEFINITION
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
        !it_select_opt    TYPE /iwbep/t_mgw_select_option OPTIONAL
        !it_add_table     TYPE zrndic_deep_add_tab_tt OPTIONAL.


  PROTECTED SECTION.

    METHODS move_to_output
         REDEFINITION .
  PRIVATE SECTION.

    TYPES : BEGIN OF stype_bkpf,                            "n856424
              bukrs TYPE zbkpf-bukrs,                       "n856424
              belnr TYPE zbkpf-belnr,                       "n856424
              gjahr TYPE zbkpf-gjahr,                       "n856424
              blart TYPE zbkpf-blart,                       "n856424
              budat TYPE zbkpf-budat,                       "n856424
              awkey TYPE zbkpf-awkey,                       "n856424
              cpudt TYPE zbkpf-cpudt,                       "n856424
              cputm TYPE zbkpf-cputm,                       "n856424
              usnam TYPE zbkpf-usnam,                       "n856424
              awtyp TYPE zbkpf-awtyp,                       "n856424
            END OF stype_bkpf.                              "n856424

    TYPES   ltt_output TYPE STANDARD TABLE OF stype_bkpf.

    DATA mt_output TYPE ltt_output.
ENDCLASS.



CLASS zcl_mb5b_select_bkpf_01 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_select_name = iv_select_name
    iv_package_size = iv_package_size
    iv_db_connection = iv_db_connection
    it_select_opt   = it_select_opt
    it_add_table = it_add_table
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
