INTERFACE zif_get_service_url
  PUBLIC .

  METHODS get_service_url
    IMPORTING
              !iv_service_id TYPE char40
    RETURNING VALUE(rv_url)  TYPE string
    RAISING   zcx_odata_call_uri.

ENDINTERFACE.
