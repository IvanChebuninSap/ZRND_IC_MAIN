INTERFACE zif_call_odata_url
  PUBLIC .

  METHODS call_odata_by_url
    IMPORTING
      !iv_url TYPE string
    EXPORTING
      ev_xml TYPE xstring
    RAISING ZCX_ODATA_CALL_URI  .

  METHODS call_odata_by_url_post
    IMPORTING
      !iv_url TYPE string
      !iv_payload TYPE xstring OPTIONAL
    EXPORTING
      ev_xml TYPE xstring
    RAISING ZCX_ODATA_CALL_URI  .


ENDINTERFACE.
