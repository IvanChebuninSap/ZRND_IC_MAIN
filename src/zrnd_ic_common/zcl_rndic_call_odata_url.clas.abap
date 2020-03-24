CLASS zcl_rndic_call_odata_url DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_call_odata_url.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_rndic_call_odata_url IMPLEMENTATION.


  METHOD zif_call_odata_url~call_odata_by_url.

    DATA: lo_client TYPE REF TO if_http_client.
    DATA lt_fields TYPE tihttpnvp.

***Create the HTTP client
    TRY.
        CALL METHOD cl_http_client=>create_by_url
          EXPORTING
            url    = iv_url
          IMPORTING
            client = lo_client
          EXCEPTIONS
            OTHERS = 1.

        lo_client->authenticate( EXPORTING username = 'developer3'
                                           password = 'Client@1' ).


        lo_client->send(    EXCEPTIONS http_communication_failure  = 1
               http_invalid_state          = 2
               http_processing_failed      = 3
               OTHERS                      = 4 ).

        IF sy-subrc <> 0.
          CALL METHOD lo_client->get_last_error
            IMPORTING
              code    = DATA(lv_error_code)
              message = DATA(lv_errortext).
          CLEAR  ev_xml.
          RAISE EXCEPTION TYPE zcx_odata_call_uri.
        ENDIF.

        lo_client->receive(   EXCEPTIONS http_communication_failure  = 1
               http_invalid_state          = 2
               http_processing_failed      = 3
               OTHERS                      = 4 ).

        IF sy-subrc <> 0.
          lo_client->response->get_status(
              IMPORTING
                code   = lv_error_code
                reason = lv_errortext
                   ).
          CLEAR  ev_xml.
          RAISE EXCEPTION TYPE zcx_odata_call_uri.
        ENDIF.

        ev_xml = lo_client->response->get_data( ).

        lo_client->close( ).
      CATCH cx_root.
        RAISE EXCEPTION TYPE zcx_odata_call_uri.

    ENDTRY.

  ENDMETHOD.

  METHOD zif_call_odata_url~call_odata_by_url_post.

    DATA: lo_client TYPE REF TO if_http_client.
    DATA lt_fields TYPE tihttpnvp.

***Create the HTTP client
    TRY.
        CALL METHOD cl_http_client=>create_by_url
          EXPORTING
            url    = iv_url
          IMPORTING
            client = lo_client
          EXCEPTIONS
            OTHERS = 1.

        lo_client->propertytype_accept_cookie = if_http_client=>co_enabled.
        lo_client->request->set_content_type( if_rest_media_type=>gc_appl_json ).
        lo_client->authenticate( EXPORTING username = 'developer3'
                                                                    password = 'Client@1' ).
        lo_client->request->set_header_field( name =  'X-CSRF-Token' value = 'Fetch' ).
        lo_client->send(    EXCEPTIONS http_communication_failure  = 1
               http_invalid_state          = 2
               http_processing_failed      = 3
               OTHERS                      = 4 ).
        lo_client->receive(   EXCEPTIONS http_communication_failure  = 1
               http_invalid_state          = 2
               http_processing_failed      = 3
               OTHERS                      = 4 ).

        DATA(lv_token) = lo_client->response->get_header_field( /iwfnd/if_oci_common=>gc_xcsrf_token ).
        lo_client->request->set_header_field( name = /iwfnd/if_oci_common=>gc_xcsrf_token value = lv_token ).
        lo_client->request->set_method( 'POST' ).
        lo_client->request->set_data( iv_payload ).
        lo_client->request->set_content_type( if_rest_media_type=>gc_appl_json ).
        lo_client->send(    EXCEPTIONS http_communication_failure  = 1
             http_invalid_state          = 2
             http_processing_failed      = 3
             OTHERS                      = 4 ).
        IF sy-subrc <> 0.
          CALL METHOD lo_client->get_last_error
            IMPORTING
              code    = DATA(lv_error_code)
              message = DATA(lv_errortext).
          CLEAR  ev_xml.
          RAISE EXCEPTION TYPE zcx_odata_call_uri.
        ENDIF.
        lo_client->receive(   EXCEPTIONS http_communication_failure  = 1
               http_invalid_state          = 2
               http_processing_failed      = 3
               OTHERS                      = 4 ).
        IF sy-subrc <> 0.
          lo_client->response->get_status(
              IMPORTING
                code   = lv_error_code
                reason = lv_errortext
                   ).
          CLEAR  ev_xml.
          RAISE EXCEPTION TYPE zcx_odata_call_uri.
        ENDIF.
        ev_xml = lo_client->response->get_data( ).
        lo_client->close( ).
      CATCH cx_root.
        RAISE EXCEPTION TYPE zcx_odata_call_uri.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
