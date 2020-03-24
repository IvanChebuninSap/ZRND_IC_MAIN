CLASS zcl_mb5b_fm_mm_check_01 DEFINITION
  PUBLIC
  INHERITING FROM zcl_mb5b_fm_base
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_mb5b_fm_mm_check_01.

    METHODS constructor
      IMPORTING
        !iv_fm_name      TYPE string
        !iv_package_size TYPE int4 OPTIONAL.

  PROTECTED SECTION.
    METHODS move_to_output REDEFINITION.

  PRIVATE SECTION.
    DATA mr_matnr TYPE zrange_matnr.
    DATA mr_lgort TYPE zrange_lgort.
    DATA mr_werks TYPE zrange_werks.
    DATA mr_bwart TYPE zrange_bwart.
    DATA mr_bukrs TYPE zrange_bukrs.

ENDCLASS.



CLASS zcl_mb5b_fm_mm_check_01 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( iv_package_size = iv_package_size iv_fm_name = iv_fm_name ).

  ENDMETHOD.


  METHOD move_to_output.

    LOOP AT mt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
      CASE <ls_result>-structure_name.
        WHEN 'MATNR'.
          READ TABLE mr_matnr ASSIGNING FIELD-SYMBOL(<ls_matnr>) INDEX <ls_result>-row_id.
          IF sy-subrc = 0.
            APPEND INITIAL LINE TO mr_matnr ASSIGNING <ls_matnr>.
          ENDIF.
          IF <ls_matnr> IS ASSIGNED.
            CASE <ls_result>-field_name.
              WHEN cv_sign.
                <ls_matnr>-sign = <ls_result>-field_value.
              WHEN cv_option.
                <ls_matnr>-option = <ls_result>-field_value.
              WHEN cv_low.
                <ls_matnr>-low = <ls_result>-field_value.
              WHEN  cv_high.
                <ls_matnr>-high = <ls_result>-field_value.
            ENDCASE.
          ENDIF.
          UNASSIGN <ls_matnr>.
        WHEN 'LGORT'.
          READ TABLE mr_lgort ASSIGNING FIELD-SYMBOL(<ls_lgort>) INDEX <ls_result>-row_id.
          IF sy-subrc = 0.
            APPEND INITIAL LINE TO mr_lgort ASSIGNING <ls_lgort>.
          ENDIF.
          IF <ls_lgort> IS ASSIGNED.
            CASE <ls_result>-field_name.
              WHEN cv_sign.
                <ls_lgort>-sign = <ls_result>-field_value.
              WHEN cv_option.
                <ls_lgort>-option = <ls_result>-field_value.
              WHEN cv_low.
                <ls_lgort>-low = <ls_result>-field_value.
              WHEN  cv_high.
                <ls_lgort>-high = <ls_result>-field_value.
            ENDCASE.
          ENDIF.
          UNASSIGN <ls_lgort>.
        WHEN 'WERKS'.
          READ TABLE mr_werks ASSIGNING FIELD-SYMBOL(<ls_werks>) INDEX <ls_result>-row_id.
          IF sy-subrc = 0.
            APPEND INITIAL LINE TO mr_werks ASSIGNING <ls_werks>.
          ENDIF.
          IF <ls_werks> IS ASSIGNED.
            CASE <ls_result>-field_name.
              WHEN cv_sign.
                <ls_werks>-sign = <ls_result>-field_value.
              WHEN cv_option.
                <ls_werks>-option = <ls_result>-field_value.
              WHEN cv_low.
                <ls_werks>-low = <ls_result>-field_value.
              WHEN  cv_high.
                <ls_werks>-high = <ls_result>-field_value.
            ENDCASE.
          ENDIF.
          UNASSIGN <ls_werks>.
        WHEN 'BWART'.
          READ TABLE mr_bwart ASSIGNING FIELD-SYMBOL(<ls_bwart>) INDEX <ls_result>-row_id.
          IF sy-subrc = 0.
            APPEND INITIAL LINE TO mr_bwart ASSIGNING <ls_bwart>.
          ENDIF.
          IF <ls_bwart> IS ASSIGNED.
            CASE <ls_result>-field_name.
              WHEN cv_sign.
                <ls_bwart>-sign = <ls_result>-field_value.
              WHEN cv_option.
                <ls_bwart>-option = <ls_result>-field_value.
              WHEN cv_low.
                <ls_bwart>-low = <ls_result>-field_value.
              WHEN  cv_high.
                <ls_bwart>-high = <ls_result>-field_value.
            ENDCASE.
          ENDIF.
          UNASSIGN <ls_bwart>.
        WHEN 'BUKRS'.
          READ TABLE mr_bukrs ASSIGNING FIELD-SYMBOL(<ls_bukrs>) INDEX <ls_result>-row_id.
          IF sy-subrc = 0.
            APPEND INITIAL LINE TO mr_bukrs ASSIGNING <ls_bukrs>.
          ENDIF.
          IF <ls_bukrs> IS ASSIGNED.
            CASE <ls_result>-field_name.
              WHEN cv_sign.
                <ls_bukrs>-sign = <ls_result>-field_value.
              WHEN cv_option.
                <ls_bukrs>-option = <ls_result>-field_value.
              WHEN cv_low.
                <ls_bukrs>-low = <ls_result>-field_value.
              WHEN  cv_high.
                <ls_bukrs>-high = <ls_result>-field_value.
            ENDCASE.
          ENDIF.
          UNASSIGN <ls_bukrs>.
      ENDCASE.
    ENDLOOP.


  ENDMETHOD.


  METHOD zif_mb5b_fm_mm_check_01~get_results.
    er_matnr = mr_matnr.
    er_lgort = mr_lgort.
    er_werks = mr_werks.
    er_bwart = mr_bwart.
    er_bukrs = mr_bukrs.
  ENDMETHOD.


  METHOD zif_mb5b_fm_mm_check_01~set_input.

    DATA lt_prop_sel_opt TYPE zrndic_deep_prop_sel_opt_tt.
    DATA lt_sel_opt TYPE zrndic_deep_sel_opt_tt.

    CLEAR lt_sel_opt.
    MOVE-CORRESPONDING ir_matnr[] TO lt_sel_opt.
    INSERT VALUE #(  property = 'MATNR' selectoptions = lt_sel_opt )  INTO TABLE lt_prop_sel_opt.

    CLEAR lt_sel_opt.
    MOVE-CORRESPONDING ir_lgort[] TO lt_sel_opt.
    INSERT VALUE #(  property = 'LGORT' selectoptions = lt_sel_opt )  INTO TABLE lt_prop_sel_opt.

    CLEAR lt_sel_opt.
    MOVE-CORRESPONDING ir_werks[] TO lt_sel_opt.
    INSERT VALUE #(  property = 'WERKS' selectoptions = lt_sel_opt )  INTO TABLE lt_prop_sel_opt.

    CLEAR lt_sel_opt.
    MOVE-CORRESPONDING ir_bwart[] TO lt_sel_opt.
    INSERT VALUE #(  property = 'BWART' selectoptions = lt_sel_opt )  INTO TABLE lt_prop_sel_opt.

    CLEAR lt_sel_opt.
    MOVE-CORRESPONDING ir_bukrs[] TO lt_sel_opt.
    INSERT VALUE #(  property = 'BUKRS' selectoptions = lt_sel_opt )  INTO TABLE lt_prop_sel_opt.


  ENDMETHOD.
ENDCLASS.
