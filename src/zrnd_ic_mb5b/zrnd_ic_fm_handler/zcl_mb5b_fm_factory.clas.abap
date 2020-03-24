CLASS zcl_mb5b_fm_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_instance
      IMPORTING
                !iv_fm_name          TYPE string
                !iv_package_size  TYPE int4 OPTIONAL
      RETURNING
                VALUE(ro_instace) TYPE REF TO zif_mb5b_fm_base
      RAISING   zcx_process_mb5b_select.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MB5B_FM_FACTORY IMPLEMENTATION.


  METHOD get_instance.
    CASE iv_fm_name.
      WHEN 'ME_CHECK_T160M'.
        ro_instace = NEW zcl_mb5b_fm_t160m_01( iv_fm_name =  iv_fm_name iv_package_size = iv_package_size  ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_process_mb5b_select.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
