CLASS zcl_mb5b_fm_func_exist_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_func_exist_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mv_subrc TYPE sy-subrc.


ENDCLASS.



CLASS zcl_mb5b_fm_func_exist_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.
    READ TABLE mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |SY-SUBRC|.
    IF sy-subrc = 0.
      mv_subrc = <ls_result>-field_value.
    ENDIF.

  ENDMETHOD.


  METHOD zif_mb5b_fm_func_exist_01~get_results.
    ev_subrc = mv_subrc.
  ENDMETHOD.


  METHOD zif_mb5b_fm_func_exist_01~set_input.
    INSERT VALUE #( structure_name = 'X' field_name = 'FUNCNAME'  field_value = iv_funcname  ) INTO TABLE ms_deep_input-tosinglefield.
  ENDMETHOD.
ENDCLASS.
