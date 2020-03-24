INTERFACE zif_mb5b_fm_func_exist_01
  PUBLIC .

  METHODS get_results
    EXPORTING
        !ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
        !iv_funcname TYPE funcname
    RAISING zcx_process_mb5b_select.



ENDINTERFACE.
