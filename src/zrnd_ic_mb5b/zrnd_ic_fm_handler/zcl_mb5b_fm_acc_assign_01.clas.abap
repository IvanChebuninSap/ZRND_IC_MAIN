CLASS ZCL_MB5B_FM_ACC_ASSIGN_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES ZIF_MB5B_FM_ACC_ASSIGN_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mv_konto TYPE zt030-konth.
    DATA mv_subrc TYPE sy-subrc.


ENDCLASS.



CLASS ZCL_MB5B_FM_ACC_ASSIGN_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.
    READ TABLE mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |KONTO|.
    IF sy-subrc = 0.
      mv_konto = <ls_result>-field_value.
    ENDIF.

    READ TABLE mt_result ASSIGNING <ls_result> WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |SY-SUBRC|.
    IF sy-subrc = 0.
      mv_subrc = <ls_result>-field_value.
    ENDIF.


  ENDMETHOD.


  METHOD zif_mb5b_fm_acc_assign_01~get_results.
    ev_konto = mv_konto.
    ev_subrc = mv_subrc.
  ENDMETHOD.


  METHOD zif_mb5b_fm_acc_assign_01~set_input.
    INSERT VALUE #( structure_name = 'X' field_name = 'SHKZG'  field_value = iv_shkzg  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'BKLAS'  field_value = iv_bklas  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'KTOPL'  field_value = iv_ktopl  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'KTOSL'  field_value = iv_ktosl  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'BWMOD'  field_value = iv_bwmod  ) INTO TABLE ms_deep_input-tosinglefield.
  ENDMETHOD.
ENDCLASS.
