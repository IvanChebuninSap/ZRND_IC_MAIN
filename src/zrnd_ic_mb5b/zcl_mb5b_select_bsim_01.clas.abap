CLASS zcl_mb5b_select_bsim_01 DEFINITION
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
    TYPES : BEGIN OF lty_output,
              bukrs    TYPE zbkpf-bukrs,                    "n443935
              bwkey    TYPE zbsim-bwkey,                    "n443935
              matnr    TYPE zbsim-matnr,                    "n443935
              bwtar    TYPE zbsim-bwtar,                    "n443935
              shkzg    TYPE zbsim-shkzg,                    "n443935
              meins    TYPE zbsim-meins,                    "n443935
              budat    TYPE zbsim-budat,                    "n443935
              blart    TYPE zbsim-blart,                    "n443935
              buzei    TYPE zbsim-buzei,                    "n497992
                                                            "n443935
              awkey    TYPE zbkpf-awkey,                    "n443935
              belnr    TYPE zbsim-belnr,                    "n443935
              gjahr    TYPE zbsim-gjahr,                    "n443935
              menge    TYPE zbsim-menge,                    "n443935
              dmbtr    TYPE zbsim-dmbtr,                    "n443935
              accessed TYPE c LENGTH 1,                     "n443935
              tabix    TYPE sy-tabix,                       "n443935
            END OF lty_output,                              "n450764

            ltt_output TYPE STANDARD TABLE OF lty_output WITH DEFAULT KEY. "n450764

    DATA mt_output TYPE ltt_output.
ENDCLASS.



CLASS zcl_mb5b_select_bsim_01 IMPLEMENTATION.


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
