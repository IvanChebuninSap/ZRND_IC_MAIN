CLASS zcl_mb5b_fm_base DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_base .

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4.

  PROTECTED SECTION.


    CONSTANTS cv_package_size TYPE int4 VALUE 1000.

    CONSTANTS cv_sign TYPE string VALUE 'Sign'.
    CONSTANTS cv_option TYPE string VALUE 'Option'.
    CONSTANTS cv_low TYPE string VALUE 'Low'.
    CONSTANTS cv_high TYPE string VALUE 'High'.

    CONSTANTS cv_service_id TYPE char40 VALUE 'MB5B_FM'.



    DATA mt_result TYPE zselect_generic_ui_tt.
    DATA mt_output_data TYPE REF TO data.
    DATA ms_deep_input TYPE zrndic_fm_generic_deep_s.
    DATA mv_package_size TYPE int4.

    METHODS move_to_output
      EXPORTING
                !et_output TYPE any
      RAISING   zcx_process_mb5b_select.

  PRIVATE SECTION.


    DATA mv_loop_from TYPE int4.
    DATA mv_loop_to TYPE int4.
    DATA mv_payload TYPE string.




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



    METHODS replace_names_in_json
      CHANGING
        cv_json TYPE string.

ENDCLASS.



CLASS zcl_mb5b_fm_base IMPLEMENTATION.


  METHOD call_odata_uri.

    DATA lv_url TYPE string.
    DATA lt_result TYPE zselect_generic_ui_tt.

    DATA lv_payload_s TYPE string.
    DATA lv_payload_x TYPE xstring.

    lv_payload_s = mv_payload.

    "lv_url = |http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/ZRNDIC_MB5B_FM_SRV/HeaderSet|.
    lv_url = NEW zcl_get_service_url( )->zif_get_service_url~get_service_url(  EXPORTING iv_service_id = cv_service_id ).

    TRY.

        DATA(lv_rows_exist) = abap_true.

        me->convert_payload_to_xstring( EXPORTING iv_paload_s = lv_payload_s
                                                                IMPORTING ev_payload_x = lv_payload_x ).


        CLEAR lt_result.
        NEW zcl_rndic_call_odata_url( )->zif_call_odata_url~call_odata_by_url_post(  EXPORTING iv_url = lv_url
                                                                                                                                                 iv_payload = lv_payload_x
                                                                                                                                       IMPORTING ev_xml = DATA(lv_xml) ).
        me->parse_xml(  EXPORTING iv_xml = lv_xml
                                     IMPORTING et_select_result = lt_result  ).


        SORT lt_result BY row_id DESCENDING.



        INSERT LINES OF lt_result INTO TABLE mt_result.


      CATCH zcx_odata_call_uri.
        CLEAR mt_result.
    ENDTRY.


  ENDMETHOD.


  METHOD constructor.

    IF iv_package_size IS INITIAL.
      mv_package_size = cv_package_size.
    ELSE.
      mv_package_size = iv_package_size.
    ENDIF.

    ms_deep_input-fm_name = iv_fm_name.

  ENDMETHOD.


  METHOD convert_payload_to_xstring.
    CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
      EXPORTING
        text   = iv_paload_s
      IMPORTING
        buffer = ev_payload_x.

  ENDMETHOD.


  METHOD move_input_to_json_payload.

    LOOP AT ms_deep_input-tosinglefield ASSIGNING FIELD-SYMBOL(<ls_single_field>).
      IF <ls_single_field>-row_id IS INITIAL.
        <ls_single_field>-row_id = 1.
      ENDIF.
      IF <ls_single_field>-structure_name IS INITIAL.
        <ls_single_field>-structure_name = |X|.
      ENDIF.
    ENDLOOP.

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
    DATA ls_result TYPE zselect_generic_ui_s.

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
          DATA(lv_sel_body_hier) = 7."  lt_xml[ cname = 'TableName' ]-hier - 1.
          DATA(lv_add_table_hier) = 11."  lt_xml[ cname = 'TableName' ]-hier - 1.

          LOOP AT lt_xml INTO   DATA(ls_xml) WHERE hier EQ lv_sel_body_hier OR
                                                                                     hier EQ lv_add_table_hier.

            DATA(lv_tabix) = sy-tabix + 1.
            CLEAR ls_result.
            DO 4 TIMES.

              CASE lt_xml[ lv_tabix  ]-cname.

                WHEN 'FieldValue'.
                  ls_result-field_value = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'FieldName'.
                  ls_result-field_name = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'RowId'.
                  ls_result-row_id = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'StructureName'.
                  ls_result-structure_name = lt_xml[ lv_tabix  ]-cvalue.
              ENDCASE.
              lv_tabix = lv_tabix  + 1.
            ENDDO.
            IF ls_result IS NOT INITIAL.
              APPEND ls_result TO et_select_result.
            ENDIF.
          ENDLOOP.



        CATCH cx_sy_itab_line_not_found.
          CLEAR lt_xml.
      ENDTRY.

    ENDIF.
  ENDMETHOD.


  METHOD replace_names_in_json.

    REPLACE ALL OCCURRENCES OF |"FM_NAME"| IN cv_json WITH |"FmName"|.
    REPLACE ALL OCCURRENCES OF |"DB_CONNECTION"| IN cv_json WITH |"DbConnection"|.
    REPLACE ALL OCCURRENCES OF |"RFC_DESTINATION"| IN cv_json WITH |"RfcDestination"|.

    REPLACE ALL OCCURRENCES OF |"TOSELOPTPROPERTY"| IN cv_json WITH |"ToSelOptProperty"|.
    REPLACE ALL OCCURRENCES OF |"PROPERTY"| IN cv_json WITH |"Property"|.

    REPLACE ALL OCCURRENCES OF |"SELECTOPTIONS"| IN cv_json WITH |"ToSelOptions"|.
    REPLACE ALL OCCURRENCES OF |"SEL_OPT_ID"| IN cv_json WITH |"SelOptId"|.
    REPLACE ALL OCCURRENCES OF |"SIGN"| IN cv_json WITH |"Sign"|.
    REPLACE ALL OCCURRENCES OF |"OPTION"| IN cv_json WITH |"Option"|.
    REPLACE ALL OCCURRENCES OF |"LOW"| IN cv_json WITH |"Low"|.
    REPLACE ALL OCCURRENCES OF |"HIGH"| IN cv_json WITH |"High"|.

    REPLACE ALL OCCURRENCES OF |"TOSINGLEFIELD":| IN cv_json WITH  |"ToSingleField":|.

    REPLACE ALL OCCURRENCES OF |"TORESULT":| IN cv_json WITH  |"ToResult":|.



    REPLACE ALL OCCURRENCES OF |"TOTABLE"| IN cv_json WITH |"ToTable"|.
    REPLACE ALL OCCURRENCES OF |"ADDTABLECONTENT"| IN cv_json WITH |"ToTableContent"|.

    REPLACE ALL OCCURRENCES OF |"STRUCTURE_NAME":"",| IN cv_json WITH ||.
    REPLACE ALL OCCURRENCES OF |"STRUCTURE_NAME"| IN cv_json WITH |"StructureName"|.

    REPLACE ALL OCCURRENCES OF |"TABLE_NAME"| IN cv_json WITH |"TableName"|.
    REPLACE ALL OCCURRENCES OF |"ROW_ID"| IN cv_json WITH |"RowId"|.
    REPLACE ALL OCCURRENCES OF |"FIELD_NAME"| IN cv_json WITH |"FieldName"|.
    REPLACE ALL OCCURRENCES OF |"FIELD_VALUE"| IN cv_json WITH |"FieldValue"|.


    REPLACE ALL OCCURRENCES OF |"High":""| IN cv_json WITH |"High":null|.


  ENDMETHOD.


  METHOD zif_mb5b_fm_base~process.
    me->move_input_to_json_payload(  ).
    me->call_odata_uri(  ).
    me->move_to_output(  ).

  ENDMETHOD.
ENDCLASS.
