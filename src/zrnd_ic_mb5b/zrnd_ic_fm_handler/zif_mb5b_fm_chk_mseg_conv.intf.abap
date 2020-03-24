INTERFACE ZIF_MB5B_FM_CHK_MSEG_CONV
  PUBLIC .

  METHODS get_results
    EXPORTING
        !ev_conv TYPE char1
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    RAISING zcx_process_mb5b_select.



ENDINTERFACE.
