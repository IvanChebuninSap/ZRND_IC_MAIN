CLASS zcl_rndic_call_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_call_odata_sel_single.
    INTERFACES zif_call_odata_sel_generic.

    CONSTANTS cv_generic_select_top TYPE numc4 VALUE 100.
    CONSTANTS cv_generic_select_skip TYPE numc4 VALUE 0.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS parse_xml
      IMPORTING
        !iv_xml           TYPE xstring
      EXPORTING
        !et_select_result TYPE zselect_generic_ui_tt .

    METHODS move_to_output
      IMPORTING
        !iv_structure_name TYPE text255
        !it_select_result  TYPE zselect_generic_ui_tt
      EXPORTING
        !es_output         TYPE any .

    METHODS move_to_output_table
      IMPORTING
        !iv_structure_name TYPE text255
        !it_select_result  TYPE zselect_generic_ui_tt
      EXPORTING
        !et_output         TYPE any .


ENDCLASS.

CLASS zcl_rndic_call_select IMPLEMENTATION.


  METHOD zif_call_odata_sel_single~call_single_select.

    DATA lv_url TYPE string.
    DATA lt_select_result TYPE zselect_generic_ui_tt.

    lv_url = |http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/zrndic_select_single_srv/SelectSingleSet?| &&
             |$filter=( TableName eq '%table_name%' and FieldList eq '%field_list%' and WhereCondition eq '%where_condtion%'  and PackageSize eq 1 and DbConnection eq '%db_connection%')|. "%format=json&
    REPLACE '%table_name%' IN lv_url WITH iv_table_name.
    IF iv_field_list IS INITIAL.
      REPLACE |and FieldList eq '%field_list%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%field_list%' IN lv_url WITH iv_field_list.
    ENDIF.
    IF iv_where_clause IS INITIAL.
      REPLACE |and WhereCondition eq '%where_condtion%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%where_condtion%' IN lv_url WITH iv_where_clause.
    ENDIF.

    IF iv_db_connection IS INITIAL.
      REPLACE |and DbConnection eq '%db_connection%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%db_connection%' IN lv_url WITH iv_db_connection.
    ENDIF.



    TRY.
        NEW zcl_rndic_call_odata_url( )->zif_call_odata_url~call_odata_by_url(  EXPORTING iv_url = lv_url
                                                                                                                                       IMPORTING ev_xml = DATA(lv_xml) ).

        me->parse_xml(  EXPORTING iv_xml = lv_xml
                                     IMPORTING et_select_result = lt_select_result  ).

        IF lt_select_result IS NOT INITIAL.
          me->move_to_output(  EXPORTING    iv_structure_name = iv_structure_name
                                                                        it_select_result =    lt_select_result
                                                  IMPORTING   es_output =  es_output ).
        ENDIF.
      CATCH zcx_odata_call_uri.
        CLEAR es_output.
    ENDTRY.

  ENDMETHOD.

  METHOD zif_call_odata_sel_generic~call_generic_select.

    DATA lv_url TYPE string.
    DATA lt_select_result TYPE zselect_generic_ui_tt.
    DATA lv_skip TYPE i.
    DATA lv_top TYPE i.
    DATA lv_skip_str TYPE char10.
    DATA lv_top_str TYPE char10.

    DATA lo_table TYPE REF TO data.
    DATA lo_output_table TYPE REF TO data.
    DATA lo_structdescr TYPE REF TO cl_abap_structdescr.
    DATA lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS <lt_table> TYPE STANDARD TABLE.
    FIELD-SYMBOLS <lt_output_table> TYPE STANDARD TABLE.

    lo_structdescr ?= cl_abap_typedescr=>describe_by_name( iv_structure_name ).
    lo_tabledescr ?= cl_abap_tabledescr=>create( p_line_type = lo_structdescr ).
    CREATE DATA lo_table TYPE HANDLE lo_tabledescr.
    ASSIGN lo_table->* TO <lt_table>.
    CREATE DATA lo_output_table TYPE HANDLE lo_tabledescr.
    ASSIGN lo_output_table->* TO <lt_output_table>.


    lv_url = |http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/ZRNDIC_SELECT_GENERIC2_SRV/SelectGenericSet?| &&
             |$top=%paging_top%&$skip=%paging_skip%&$filter=( TableName eq '%table_name%' and FieldList eq '%field_list%' and WhereCondition eq '%where_condtion%' and DbConnection eq '%db_connection%' and Distinct eq '%distinct%')|.
    REPLACE '%table_name%' IN lv_url WITH iv_table_name.
    IF iv_field_list IS INITIAL.
      REPLACE |and FieldList eq '%field_list%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%field_list%' IN lv_url WITH iv_field_list.
    ENDIF.
    IF iv_where_clause IS INITIAL.
      REPLACE |and WhereCondition eq '%where_condtion%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%where_condtion%' IN lv_url WITH iv_where_clause.
    ENDIF.

    IF iv_db_connection IS INITIAL.
      REPLACE |and DbConnection eq '%db_connection%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%db_connection%' IN lv_url WITH iv_db_connection.
    ENDIF.

    IF iv_distinct IS INITIAL.
      REPLACE |and Distinct eq '%distinct%'| IN lv_url WITH ''.
    ELSE.
      REPLACE '%distinct%' IN lv_url WITH iv_distinct.
    ENDIF.

    IF iv_paging_top IS INITIAL.
      lv_top = me->cv_generic_select_top .
    ELSE.
      lv_top = iv_paging_top.
    ENDIF.
    lv_top_str = lv_top.
    CONDENSE lv_top_str.
    REPLACE '%paging_top%' IN lv_url WITH lv_top_str.

    IF iv_paging_skip IS INITIAL.
      lv_skip =   me->cv_generic_select_skip.
    ELSE.
      lv_skip =   iv_paging_skip.
    ENDIF.
    lv_skip_str = lv_skip.
    CONDENSE lv_skip_str.
    REPLACE '%paging_skip%' IN lv_url WITH lv_skip_str.

    TRY.

        DATA(lv_rows_exist) = abap_true.


        WHILE lv_rows_exist = abap_true.
          CLEAR lt_select_result.
          NEW zcl_rndic_call_odata_url( )->zif_call_odata_url~call_odata_by_url(  EXPORTING iv_url = lv_url
                                                                                                                                         IMPORTING ev_xml = DATA(lv_xml) ).

          me->parse_xml(  EXPORTING iv_xml = lv_xml
                                       IMPORTING et_select_result = lt_select_result  ).

          IF lines( lt_select_result ) IS INITIAL.
            lv_rows_exist = abap_false.
          ELSE.
              SORT lt_select_result BY row_id DESCENDING.

              IF  lt_select_result[ 1 ]-row_id <  lv_top.
                lv_rows_exist = abap_false.
              ELSE.
                lv_skip_str = |$skip=| && lv_skip && ||.
                lv_skip = lv_skip + lv_top.
                DATA(lv_new_skip_str) = |$skip=| && lv_skip && ||.
                REPLACE lv_skip_str IN lv_url WITH  lv_new_skip_str.
              ENDIF.


            me->move_to_output_table(  EXPORTING    iv_structure_name = iv_structure_name
                                                                          it_select_result =    lt_select_result
                                                    IMPORTING   et_output =  <lt_table> ).
            APPEND LINES OF <lt_table> TO <lt_output_table>.
          ENDIF.

        ENDWHILE.

        et_output = <lt_output_table>.

      CATCH zcx_odata_call_uri.
        CLEAR et_output.
    ENDTRY.

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
          DATA(lv_hier) = lt_xml[ cname = 'TableName' ]-hier - 1.



          LOOP AT lt_xml INTO   DATA(ls_xml) WHERE hier EQ lv_hier.

            DATA(lv_tabix) = sy-tabix + 1.
            INSERT INITIAL LINE INTO TABLE et_select_result ASSIGNING FIELD-SYMBOL(<ls_tab>).
            DO 8 TIMES.

              CASE lt_xml[ lv_tabix  ]-cname.

                WHEN 'DbConnection'.
                WHEN 'PackageSize'.
                WHEN 'FieldValue'.
                  <ls_tab>-field_value = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'FieldName'.
                  <ls_tab>-field_name = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'RowId'.
                  <ls_tab>-row_id = lt_xml[ lv_tabix  ]-cvalue.
                WHEN 'WhereCondition'.
                WHEN 'FieldList'.
                WHEN 'TableName'.
                  <ls_tab>-table_name = lt_xml[ lv_tabix  ]-cvalue.
              ENDCASE.
              lv_tabix = lv_tabix  + 1.
            ENDDO.
          ENDLOOP.
        CATCH cx_sy_itab_line_not_found.
          CLEAR lt_xml.
      ENDTRY.

    ENDIF.


  ENDMETHOD.

  METHOD move_to_output.

    DATA lo_data TYPE REF TO data.

    FIELD-SYMBOLS <ls_data> TYPE any.
    FIELD-SYMBOLS <lv_field> TYPE any.

    CREATE DATA lo_data TYPE (iv_structure_name).

    ASSIGN lo_data->* TO <ls_data>.

    LOOP AT it_select_result ASSIGNING FIELD-SYMBOL(<ls_select_result>) WHERE row_id = 1 AND field_value IS NOT INITIAL.

      ASSIGN COMPONENT <ls_select_result>-field_name OF STRUCTURE <ls_data> TO <lv_field>.
      IF sy-subrc = 0 AND <lv_field> IS ASSIGNED.
        <lv_field> = <ls_select_result>-field_value.
      ENDIF.

    ENDLOOP.

    es_output = <ls_data>.

  ENDMETHOD.

  METHOD move_to_output_table.

    DATA lt_row_ids TYPE TABLE OF zselect_generic_ui_s-row_id.

    DATA lo_table TYPE REF TO data.
    DATA lo_structure TYPE REF TO data.
    DATA lo_structdescr TYPE REF TO cl_abap_structdescr.
    DATA lo_tabledescr TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS <lt_table> TYPE STANDARD TABLE.
    FIELD-SYMBOLS <lv_field> TYPE any.

    lo_structdescr ?= cl_abap_typedescr=>describe_by_name( iv_structure_name ).

    lo_tabledescr ?= cl_abap_tabledescr=>create( p_line_type = lo_structdescr ).
    CREATE DATA lo_table TYPE HANDLE lo_tabledescr.
    ASSIGN lo_table->* TO <lt_table>.
    CREATE DATA lo_structure TYPE HANDLE lo_structdescr.
    ASSIGN lo_structure->* TO FIELD-SYMBOL(<ls_table>).

    IF <lt_table> IS NOT ASSIGNED OR <ls_table> IS NOT ASSIGNED.
      EXIT.
    ENDIF.

    LOOP AT it_select_result ASSIGNING FIELD-SYMBOL(<ls_select_result>).
      INSERT <ls_select_result>-row_id INTO TABLE lt_row_ids.
    ENDLOOP.

    SORT  lt_row_ids.
    DELETE ADJACENT DUPLICATES FROM lt_row_ids.

    LOOP AT lt_row_ids ASSIGNING FIELD-SYMBOL(<lv_row_id>).

      INSERT INITIAL LINE INTO TABLE <lt_table> ASSIGNING <ls_table>.

      LOOP AT it_select_result  ASSIGNING <ls_select_result> WHERE row_id = <lv_row_id>.

        ASSIGN COMPONENT <ls_select_result>-field_name OF STRUCTURE <ls_table> TO <lv_field>.
        IF sy-subrc = 0 AND <lv_field> IS ASSIGNED.
          <lv_field> = <ls_select_result>-field_value.
        ENDIF.

      ENDLOOP.

    ENDLOOP.

    et_output = <lt_table>.

  ENDMETHOD.

ENDCLASS.
