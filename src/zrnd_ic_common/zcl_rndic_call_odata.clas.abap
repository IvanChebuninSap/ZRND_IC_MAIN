CLASS zcl_rndic_call_odata DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS call_odata_test.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_RNDIC_CALL_ODATA IMPLEMENTATION.


  METHOD call_odata_test.


*    /iwfnd/cl_sutil_client_proxy=>get_instance( )->web_request(
*
*         EXPORTING
*
*            it_request_header = VALUE /iwfnd/sutil_property_t( ( name  = if_http_header_fields_sap=>request_method
*                                                                                                    value = if_http_entity=>co_request_method_get
*                                                                                                  ) (
*                                                                                                   name  = if_http_header_fields_sap=>request_uri
*                                                                                                   value = | https://services.odata.org/V2/OData/OData.svc/ |
*                                                                                             )  )
*         IMPORTING
*                ev_status_code    = DATA(lv_status_code)
*                ev_response_body  = DATA(rv_xbody)
*                ev_error_text     = DATA(lv_error_text)
*   ).

DATA: client TYPE REF TO if_http_client,
      url TYPE string,
      xml TYPE xstring,
      c_xml TYPE string.



url =
    | http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/zgw100_xx_so_srv/?sap-client=182 |
      .



***Create the HTTP client
  TRY.
      CALL METHOD cl_http_client=>create_by_url
        EXPORTING
          url    = url
        IMPORTING
          client = client
        EXCEPTIONS
          OTHERS = 1.

      client->send( ).
      client->receive( ).

      xml = client->response->get_data( ).
      client->response->GET_STATUS( IMPORTING code = DATA(lv_code)
                                              reason = DATA(lv_reason) ).
      WRITE: / 'HTTP Status: ', lv_code, lv_reason.

      client->close( ).
    CATCH cx_root.
      WRITE: / 'HTTP Connection error: '.
  ENDTRY.




    BREAK-POINT.

  ENDMETHOD.
ENDCLASS.
