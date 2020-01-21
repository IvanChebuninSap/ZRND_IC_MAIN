CLASS zcl_mb5b_select_base DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_select_base .

    METHODS constructor
      IMPORTING
        !iv_select_name   TYPE string
        !iv_package_size  TYPE int4 DEFAULT 1000
        !iv_db_connection TYPE string
        !it_select_opt    TYPE /iwbep/t_mgw_select_option OPTIONAL
        !it_add_table     TYPE zrndic_deep_add_tab_tt OPTIONAL.
  PROTECTED SECTION.


    DATA mv_package_size TYPE int4.
    DATA mv_loop_from TYPE int4.
    DATA mv_loop_to TYPE int4.
    DATA mv_select_name TYPE string.
    DATA mt_select_options TYPE /iwbep/t_mgw_select_option.
    DATA mv_payload TYPE string.
    DATA mt_select_result TYPE zselect_generic_ui_tt.
    DATA mt_output_data TYPE REF TO data.
    DATA mv_db_connection TYPE string.
    DATA mt_add_table     TYPE zrndic_deep_add_tab_tt.
    DATA ms_deep_input TYPE zrndic_select_deep_s.


    METHODS move_to_output
      EXPORTING
                !et_output TYPE any
      RAISING   zcx_process_mb5b_select.

  PRIVATE SECTION.


    METHODS call_odata_uri RAISING zcx_process_mb5b_select.

    METHODS move_input_to_json_payload RAISING zcx_process_mb5b_select.

    METHODS parse_xml
      IMPORTING
        !iv_xml           TYPE xstring
      EXPORTING
        !et_select_result TYPE zselect_generic_ui_tt .

    METHODS convert_payload_to_xstring
      IMPORTING
        iv_paload_s  TYPE string
      EXPORTING
        ev_payload_x TYPE xstring.

    METHODS modify_skip_top
      CHANGING
        cv_payload_s TYPE string.

    METHODS replace_names_in_json
      CHANGING
        cv_json TYPE string.

ENDCLASS.



CLASS zcl_mb5b_select_base IMPLEMENTATION.


  METHOD call_odata_uri.

    DATA lv_url TYPE string.
    DATA lt_select_result TYPE zselect_generic_ui_tt.

    DATA lv_payload_s TYPE string.
    DATA lv_payload_x TYPE xstring.

    mv_loop_from = 0. "i.e. 0
    mv_loop_to =  mv_package_size - 1. "i.t 100-1=99

    lv_payload_s = mv_payload.

    lv_url = |http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/ZRNDIC_MB5B_SELECT_SRV/SelectHeaderSet|.

    TRY.

        DATA(lv_rows_exist) = abap_true.

        me->convert_payload_to_xstring( EXPORTING iv_paload_s = lv_payload_s
                                                                IMPORTING ev_payload_x = lv_payload_x ).

        WHILE lv_rows_exist = abap_true.
          CLEAR lt_select_result.
          NEW zcl_rndic_call_odata_url( )->zif_call_odata_url~call_odata_by_url_post(  EXPORTING iv_url = lv_url
                                                                                                                                                   iv_payload = lv_payload_x
                                                                                                                                         IMPORTING ev_xml = DATA(lv_xml) ).
          me->parse_xml(  EXPORTING iv_xml = lv_xml
                                       IMPORTING et_select_result = lt_select_result  ).

          IF lines( lt_select_result ) IS INITIAL.
            lv_rows_exist = abap_false.
          ELSE.
            SORT lt_select_result BY row_id DESCENDING.

            IF  lt_select_result[ 1 ]-row_id <  ( mv_package_size - 1 ).
              lv_rows_exist = abap_false.
            ELSE.

              me->modify_skip_top(  CHANGING cv_payload_s  = lv_payload_s ).
              me->convert_payload_to_xstring( EXPORTING iv_paload_s = lv_payload_s
                                                                            IMPORTING ev_payload_x = lv_payload_x ).

            ENDIF.

            INSERT LINES OF lt_select_result INTO TABLE mt_select_result.

          ENDIF.
        ENDWHILE.
      CATCH zcx_odata_call_uri.
        CLEAR mt_select_result.
    ENDTRY.


  ENDMETHOD.


  METHOD constructor.

    mv_select_name = iv_select_name.

    IF iv_package_size IS INITIAL.
      mv_package_size = 1000.
    ELSE.
      mv_package_size = iv_package_size.
    ENDIF.
    mt_select_options = it_select_opt.
    mv_db_connection = iv_db_connection.
    mt_add_table = it_add_table.

  ENDMETHOD.


  METHOD convert_payload_to_xstring.
    CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
      EXPORTING
        text   = iv_paload_s
      IMPORTING
        buffer = ev_payload_x.

  ENDMETHOD.


  METHOD modify_skip_top.

    DATA lv_skip_str TYPE string.
    DATA lv_top_str TYPE string.


    lv_skip_str = |"Skip":| && mv_loop_from && |,|.
    mv_loop_from = mv_loop_from + mv_package_size. "i.e. 0 + 100 = 100
    DATA(lv_new_skip_str) = |"Skip":| && mv_loop_from && |,|.
    REPLACE lv_skip_str IN cv_payload_s WITH  lv_new_skip_str.

    lv_top_str = |"Top":| && mv_loop_to && |,|.
    mv_loop_to = mv_loop_to + mv_package_size. "i.e. 99 + 100 = 199
    DATA(lv_new_top_str) = |"Top":| && mv_loop_to && |,|.
    REPLACE lv_top_str IN cv_payload_s WITH  lv_new_top_str.
  ENDMETHOD.


  METHOD move_input_to_json_payload.

    ms_deep_input-select_name = mv_select_name.
    DATA(lv_skip) =  CONV string( 0 ).
    CONDENSE lv_skip.
    ms_deep_input-skip = lv_skip.
    DATA(lv_top) =  CONV string(  mv_package_size - 1 ).
    CONDENSE lv_top.
    ms_deep_input-top = lv_top.
    ms_deep_input-db_connection = mv_db_connection.

    LOOP AT mt_select_options ASSIGNING FIELD-SYMBOL(<ls_prop_sel_opt>).
      INSERT INITIAL LINE INTO TABLE ms_deep_input-seloptproperties ASSIGNING FIELD-SYMBOL(<ls_deep_sel_prop_opt>).
      <ls_deep_sel_prop_opt>-property = <ls_prop_sel_opt>-property.
      LOOP AT <ls_prop_sel_opt>-select_options ASSIGNING FIELD-SYMBOL(<ls_sel_opt>).
        DATA(lv_tabix) = sy-tabix.
        INSERT INITIAL LINE INTO TABLE <ls_deep_sel_prop_opt>-selectoptions ASSIGNING FIELD-SYMBOL(<ls_deep_sel_opt>).
        MOVE-CORRESPONDING <ls_sel_opt> TO <ls_deep_sel_opt>.
        <ls_deep_sel_opt>-sel_opt_id = lv_tabix.
      ENDLOOP.
    ENDLOOP.

    MOVE-CORRESPONDING mt_add_table TO ms_deep_input-addtable.


    DATA(lo_typdesct) = cl_abap_typedescr=>describe_by_data( ms_deep_input ).

    mv_payload = /ui2/cl_json=>serialize( EXPORTING data = ms_deep_input
                                                       type_descr = lo_typdesct ).

    me->replace_names_in_json( CHANGING cv_json = mv_payload ).


  ENDMETHOD.


  METHOD move_to_output.
    RAISE EXCEPTION TYPE zcx_process_mb5b_select.

  ENDMETHOD.


  METHOD parse_xml.

    DATA lt_xml TYPE TABLE OF smum_xmltb.
    DATA:  lt_return TYPE STANDARD TABLE OF bapiret2.

    CALL FUNCTION 'SMUM_XML_PARSE'
      EXPORTING
        xml_input = iv_xml
      TABLES
        xml_table = lt_xml
        return    = lt_return
      EXCEPTIONS
        OTHERS    = 0.

    IF NOT lt_xml IS INITIAL.

      TRY.
          DATA(lv_hier) = 7."  lt_xml[ cname = 'TableName' ]-hier - 1.

          LOOP AT lt_xml INTO   DATA(ls_xml) WHERE hier EQ lv_hier.

            DATA(lv_tabix) = sy-tabix + 1.
            INSERT INITIAL LINE INTO TABLE et_select_result ASSIGNING FIELD-SYMBOL(<ls_tab>).
            DO 3 TIMES.

              CASE lt_xml[ lv_tabix  ]-cname.

                WHEN 'FieldValue'.
                  <ls_tab>-field_value = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'FieldName'.
                  <ls_tab>-field_name = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'RowId'.
                  <ls_tab>-row_id = lt_xml[ lv_tabix  ]-cvalue.

              ENDCASE.
              lv_tabix = lv_tabix  + 1.
            ENDDO.
          ENDLOOP.
        CATCH cx_sy_itab_line_not_found.
          CLEAR lt_xml.
      ENDTRY.

    ENDIF.
  ENDMETHOD.


  METHOD replace_names_in_json.

    REPLACE ALL OCCURRENCES OF |"SELECT_NAME"| IN cv_json WITH |"SelectName"|.
    REPLACE ALL OCCURRENCES OF |"SKIP"| IN cv_json WITH |"Skip"|.
    REPLACE ALL OCCURRENCES OF |"TOP"| IN cv_json WITH |"Top"|.
    REPLACE ALL OCCURRENCES OF |"DB_CONNECTION"| IN cv_json WITH |"DbConnection"|.
    REPLACE ALL OCCURRENCES OF |"SELOPTPROPERTIES"| IN cv_json WITH |"SelOptProperties"|.
    REPLACE ALL OCCURRENCES OF |"PROPERTY"| IN cv_json WITH |"Property"|.
    REPLACE ALL OCCURRENCES OF |"SELECTOPTIONS"| IN cv_json WITH |"SelectOptions"|.
    REPLACE ALL OCCURRENCES OF |"SEL_OPT_ID"| IN cv_json WITH |"SelOptId"|.
    REPLACE ALL OCCURRENCES OF |"SIGN"| IN cv_json WITH |"Sign"|.
    REPLACE ALL OCCURRENCES OF |"OPTION"| IN cv_json WITH |"Option"|.
    REPLACE ALL OCCURRENCES OF |"LOW"| IN cv_json WITH |"Low"|.
    REPLACE ALL OCCURRENCES OF |"HIGH"| IN cv_json WITH |"High"|.

    REPLACE |"SELECTBODY":| IN cv_json WITH  |"SelectBody":|.

    REPLACE ALL OCCURRENCES OF |"High":""| IN cv_json WITH |"High":null|.

    REPLACE ALL OCCURRENCES OF |"ADDTABLE"| IN cv_json WITH |"AddTable"|.
    REPLACE ALL OCCURRENCES OF |"ADDTABLECONTENT"| IN cv_json WITH |"AddTableContent"|.


    REPLACE ALL OCCURRENCES OF |"TABLE_NAME"| IN cv_json WITH |"TableName"|.
    REPLACE ALL OCCURRENCES OF |"ROW_ID"| IN cv_json WITH |"RowId"|.
    REPLACE ALL OCCURRENCES OF |"FIELD_NAME"| IN cv_json WITH |"FieldName"|.
    REPLACE ALL OCCURRENCES OF |"FIELD_VALUE"| IN cv_json WITH |"FieldValue"|.
  ENDMETHOD.


  METHOD zif_mb5b_select_base~process.
    me->move_input_to_json_payload(  ).
    me->call_odata_uri(  ).
    me->move_to_output( IMPORTING et_output = et_output ).

  ENDMETHOD.
ENDCLASS.
