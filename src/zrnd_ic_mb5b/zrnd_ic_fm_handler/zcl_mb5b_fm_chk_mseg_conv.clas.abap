CLASS zcl_mb5b_fm_chk_mseg_conv DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_chk_mseg_conv.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mv_conv TYPE char1.


ENDCLASS.



CLASS ZCL_MB5B_FM_CHK_MSEG_CONV IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.
    READ TABLE mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |CONV|.
    IF sy-subrc = 0.
      mv_conv = <ls_result>-field_value.
    ENDIF.

  ENDMETHOD.


  METHOD zif_mb5b_fm_chk_mseg_conv~get_results.
    ev_conv = mv_conv.
  ENDMETHOD.


  METHOD zif_mb5b_fm_chk_mseg_conv~set_input.

  ENDMETHOD.
ENDCLASS.
