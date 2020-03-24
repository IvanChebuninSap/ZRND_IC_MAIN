INTERFACE zif_mb5b_fm_acc_assign_01
  PUBLIC .

  METHODS get_results
    EXPORTING
              !ev_konto TYPE zt030-konth
              !ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_bklas TYPE zt030-bklas
              !iv_bwmod TYPE zt030-bwmod
              !iv_ktopl TYPE zt030-ktopl
              !iv_shkzg TYPE char1
              !iv_ktosl TYPE zt030r-ktosl
    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
