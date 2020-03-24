CLASS zcl_get_service_url DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_get_service_url.

    METHODS constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA gt_url TYPE TABLE OF zicrnd_servc.
ENDCLASS.



CLASS zcl_get_service_url IMPLEMENTATION.




  METHOD zif_get_service_url~get_service_url.

    DATA lt_url TYPE TABLE OF zicrnd_servc.

    IF gt_url IS INITIAL.
        RAISE EXCEPTION TYPE zcx_odata_call_uri.
      ELSE.
        LOOP AT gt_url ASSIGNING FIELD-SYMBOL(<ls_url>) WHERE service_id = iv_service_id.
            rv_url = rv_url && <ls_url>-service_url.
        ENDLOOP.
        IF rv_url IS INITIAL.
            RAISE EXCEPTION TYPE zcx_odata_call_uri.
        ENDIF.
      ENDIF.
    ENDMETHOD.

    METHOD constructor.
      IF gt_url IS INITIAL.
        SELECT *
           FROM zicrnd_servc
           INTO CORRESPONDING FIELDS OF TABLE @gt_url
           ORDER BY service_id, row_id ASCENDING.
      ENDIF.
    ENDMETHOD.

ENDCLASS.
