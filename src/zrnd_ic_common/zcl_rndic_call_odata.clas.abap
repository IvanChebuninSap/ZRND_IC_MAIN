CLASS zcl_rndic_call_odata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_call_odata_sel_single.

  PROTECTED SECTION.
  PRIVATE SECTION.
        METHODS call_odata
            IMPORTING
                iv_url type string
            EXPORTING
                ev_xml TYPE xstring.
ENDCLASS.


CLASS ZCL_RNDIC_CALL_ODATA IMPLEMENTATION.

  METHOD call_odata.

DATA: lo_client TYPE REF TO if_http_client.

***Create the HTTP client
  TRY.
      CALL METHOD cl_http_client=>create_by_url
        EXPORTING
          url    = iv_url
        IMPORTING
          client = lo_client
        EXCEPTIONS
          OTHERS = 1.

      lo_client->send( ).
      lo_client->receive( ).

      ev_xml = lo_client->response->get_data( ).
*      lo_client->response->GET_STATUS( IMPORTING code = DATA(lv_code)
*                                              reason = DATA(lv_reason) ).
      lo_client->close( ).
    CATCH cx_root.
      CLEAR  ev_xml.

  ENDTRY.

  ENDMETHOD.

  METHOD zif_call_odata_sel_single~call_single_select.

        DATA lv_url TYPE string.

        lv_url =  zif_call_odata_sel_single=>gc_select_single_srv &&
                      zif_call_odata_sel_single=>gc_param_table_name && |'| && iv_table_name && |'| && |&| &&
                      zif_call_odata_sel_single=>gc_param_field_list && |'| && iv_field_list && |'| && |&| &&
                      zif_call_odata_sel_single=>gc_param_where_condition && |'| && iv_where_clause && |'|.

       me->call_odata(  EXPORTING iv_url = lv_url
                                     IMPORTING ev_xml = DATA(lv_xml) ).

  ENDMETHOD.

ENDCLASS.
