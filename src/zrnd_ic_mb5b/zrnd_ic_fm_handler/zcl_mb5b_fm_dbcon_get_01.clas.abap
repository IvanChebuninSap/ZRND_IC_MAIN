CLASS zcl_mb5b_fm_dbcon_get_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_dbcon_get_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mv_dbcon TYPE dbcon_name.


ENDCLASS.



CLASS zcl_mb5b_fm_dbcon_get_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.
    READ TABLE mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |DBCON|.
    IF sy-subrc = 0.
      mv_dbcon = <ls_result>-field_value.
    ENDIF.

  ENDMETHOD.


  METHOD zif_mb5b_fm_dbcon_get_01~get_results.
    ev_dbcon = mv_dbcon.
  ENDMETHOD.


  METHOD zif_mb5b_fm_dbcon_get_01~set_input.

    DATA lo_descr TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS <lv_value> TYPE any.

    DATA lt_to_table TYPE zrndic_deep_add_tab_tt.
    DATA lt_to_table_content TYPE zrndic_deep_name_value_tt.


    INSERT VALUE #( structure_name = 'X' field_name = 'SUBAPPL'  field_value = iv_subappl  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'ACT_CHECK'  field_value = iv_act_check  ) INTO TABLE ms_deep_input-tosinglefield.

    IF it_req_tab IS NOT INITIAL.
      lo_descr ?= cl_abap_typedescr=>describe_by_data( it_req_tab[ 1 ] ).

      LOOP AT it_req_tab ASSIGNING FIELD-SYMBOL(<ls_req_tab>).
        DATA(lv_tabix) = sy-tabix.
        LOOP AT lo_descr->components INTO DATA(ls_comp).

          ASSIGN COMPONENT  ls_comp-name OF STRUCTURE <ls_req_tab>  TO <lv_value>.
          IF sy-subrc = 0 AND <lv_value> IS ASSIGNED AND <lv_value> IS NOT INITIAL.
            INSERT INITIAL LINE INTO TABLE lt_to_table_content ASSIGNING FIELD-SYMBOL(<ls_table_content>).
            <ls_table_content>-row_id = lv_tabix.
            <ls_table_content>-structure_name = 'REQ_TAB'.
            <ls_table_content>-field_name = ls_comp-name.
            <ls_table_content>-field_value = <lv_value>.
            UNASSIGN <lv_value>.
          ENDIF.

        ENDLOOP.
      ENDLOOP.

      INSERT VALUE #(  table_name = 'REQ_TAB'  addtablecontent = lt_to_table_content ) INTO TABLE lt_to_table.
      ms_deep_input-totable = lt_to_table.


    ENDIF.


  ENDMETHOD.
ENDCLASS.
