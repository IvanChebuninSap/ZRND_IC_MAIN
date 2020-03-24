INTERFACE ZIF_MB5B_FM_NAMETAB_GET_01
  PUBLIC .

  METHODS get_results
    EXPORTING
              !ev_subrc TYPE sy-subrc
              !et_x031l  TYPE COMT_X031L_TAB
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_tabname TYPE TABNAME
              !it_x031l TYPE   COMT_X031L_TAB
    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
