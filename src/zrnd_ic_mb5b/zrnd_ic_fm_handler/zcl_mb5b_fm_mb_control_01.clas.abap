CLASS zcl_mb5b_fm_mb_control_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_mb_control_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mt_s156ts TYPE zif_mb5b_fm_mb_control_01=>tt_zs156s.
    DATA mt_s156ts_temp TYPE zif_mb5b_fm_mb_control_01=>tt_zs156s.
    DATA mv_subrc TYPE sy-subrc.
ENDCLASS.



CLASS zcl_mb5b_fm_mb_control_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.

    FIELD-SYMBOLS <lv_field> TYPE any.
    DATA lt_row_ids TYPE TABLE OF zselect_generic_ui_s-row_id.


    TRY.
        mv_subrc = mt_result[ structure_name = 'X' field_name = 'SY-SUBRC' ]-field_value.
      CATCH cx_sy_itab_line_not_found.
        mv_subrc = 1.
    ENDTRY.

    IF mv_subrc <> 0.
      mt_s156ts = mt_s156ts_temp.
    ELSE.
      LOOP AT mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WHERE structure_name = 'S156TS'.
        INSERT <ls_result>-row_id INTO TABLE lt_row_ids.
      ENDLOOP.

      SORT  lt_row_ids.
      DELETE ADJACENT DUPLICATES FROM lt_row_ids.

      LOOP AT lt_row_ids ASSIGNING FIELD-SYMBOL(<lv_row_id>).

        INSERT INITIAL LINE INTO TABLE mt_s156ts ASSIGNING FIELD-SYMBOL(<ls_output>).

        LOOP AT mt_result  ASSIGNING <ls_result> WHERE row_id = <lv_row_id> AND structure_name = 'S156TS'.

          ASSIGN COMPONENT <ls_result>-field_name OF STRUCTURE <ls_output> TO <lv_field>.
          IF sy-subrc = 0 AND <lv_field> IS ASSIGNED.
            <lv_field> = <ls_result>-field_value.
          ENDIF.

        ENDLOOP.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD zif_mb5b_fm_mb_control_01~get_results.
    et_s156s = mt_s156ts.
    ev_subrc = mv_subrc.
  ENDMETHOD.


  METHOD zif_mb5b_fm_mb_control_01~set_input.

    DATA lo_descr TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS <lv_value> TYPE any.

    DATA lt_prop_sel_opt TYPE zrndic_deep_prop_sel_opt_tt.
    DATA lt_sel_opt TYPE zrndic_deep_sel_opt_tt.

    DATA lt_to_table TYPE zrndic_deep_add_tab_tt.
    DATA lt_to_table_content TYPE zrndic_deep_name_value_tt.

    INSERT VALUE #( structure_name = 'X' field_name = 'BWART'  field_value = iv_bwart ) INTO TABLE ms_deep_input-tosinglefield.

    IF it_s156s IS NOT INITIAL.
      lo_descr ?= cl_abap_typedescr=>describe_by_data( it_s156s[ 1 ] ).

      LOOP AT it_s156s ASSIGNING FIELD-SYMBOL(<ls_s156ts>).
        DATA(lv_tabix) = sy-tabix.
        LOOP AT lo_descr->components INTO DATA(ls_comp).

          ASSIGN COMPONENT  ls_comp-name OF STRUCTURE <ls_s156ts>  TO <lv_value>.
          IF sy-subrc = 0 AND <lv_value> IS ASSIGNED AND <lv_value> IS NOT INITIAL.
            INSERT INITIAL LINE INTO TABLE lt_to_table_content ASSIGNING FIELD-SYMBOL(<ls_table_content>).
            <ls_table_content>-row_id = lv_tabix.
            <ls_table_content>-structure_name = 'S156TS'.
            <ls_table_content>-field_name = ls_comp-name.
            <ls_table_content>-field_value = <lv_value>.
            UNASSIGN <lv_value>.
          ENDIF.

        ENDLOOP.
      ENDLOOP.

      INSERT VALUE #(  table_name = 'S156TS'  addtablecontent = lt_to_table_content ) INTO TABLE lt_to_table.
      ms_deep_input-totable = lt_to_table.


    ENDIF.

    mt_s156ts_temp = it_s156s.

  ENDMETHOD.
ENDCLASS.
