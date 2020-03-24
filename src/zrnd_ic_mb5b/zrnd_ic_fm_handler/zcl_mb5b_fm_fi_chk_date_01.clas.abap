CLASS zcl_mb5b_fm_fi_chk_date_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_fi_chk_date_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mv_tpcuser TYPE char1.
    DATA mv_subrc TYPE sy-subrc.


ENDCLASS.



CLASS zcl_mb5b_fm_fi_chk_date_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.
    READ TABLE mt_result ASSIGNING FIELD-SYMBOL(<ls_result>) WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |TPCUSER|.
    IF sy-subrc = 0.
      mv_tpcuser = <ls_result>-field_value.
    ENDIF.

    READ TABLE mt_result ASSIGNING <ls_result> WITH KEY structure_name = 'X'
                                                                                                                                 field_name = |SY-SUBRC|.
    IF sy-subrc = 0.
      mv_subrc = <ls_result>-field_value.
    ENDIF.


  ENDMETHOD.


  METHOD zif_mb5b_fm_fi_chk_date_01~get_results.
    ev_tpcuser = mv_tpcuser.
    ev_subrc = mv_subrc.
  ENDMETHOD.


  METHOD zif_mb5b_fm_fi_chk_date_01~set_input.
    INSERT VALUE #( structure_name = 'X' field_name = 'BUKRS'  field_value = iv_bukrs  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'REPID'  field_value = iv_repid  ) INTO TABLE ms_deep_input-tosinglefield.
    INSERT VALUE #( structure_name = 'X' field_name = 'UNAME'  field_value = iv_uname  ) INTO TABLE ms_deep_input-tosinglefield.
    IF iv_from_date IS SUPPLIED.
      INSERT VALUE #( structure_name = 'X' field_name = 'FROM_DATE'  field_value = iv_from_date  ) INTO TABLE ms_deep_input-tosinglefield.
    ENDIF.
    IF iv_to_date IS SUPPLIED.
      INSERT VALUE #( structure_name = 'X' field_name = 'TO_DATE'  field_value = iv_to_date  ) INTO TABLE ms_deep_input-tosinglefield.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
