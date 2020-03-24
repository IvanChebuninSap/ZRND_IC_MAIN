INTERFACE ZIF_MB5B_FM_DBCON_GET_01
  PUBLIC .

  METHODS get_results
    EXPORTING
        !ev_dbcon TYPE dbcon_name
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
        !iv_subappl TYPE program
        !iv_act_check TYPE boole_d OPTIONAL
        !it_req_tab TYPE TYP_T_TABLENAME OPTIONAL
    RAISING zcx_process_mb5b_select.



ENDINTERFACE.
