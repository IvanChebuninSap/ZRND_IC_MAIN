INTERFACE zif_mb5b_fm_mm_check_01
  PUBLIC .

  METHODS get_results
    EXPORTING
              !er_matnr TYPE zrange_matnr
              !er_werks TYPE zrange_werks
              !er_lgort TYPE zrange_lgort
              !er_bwart TYPE zrange_bwart
              !er_bukrs TYPE zrange_bukrs
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !ir_matnr TYPE zrange_matnr
              !ir_werks TYPE zrange_werks
              !ir_lgort TYPE zrange_lgort
              !ir_bwart TYPE zrange_bwart
              !ir_bukrs TYPE zrange_bukrs
    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
