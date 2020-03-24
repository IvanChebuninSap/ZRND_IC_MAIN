INTERFACE zif_mb5b_fm_fi_chk_date_01
  PUBLIC .

  METHODS get_results
    EXPORTING
              !ev_tpcuser TYPE char1
              !ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_bukrs   TYPE bukrs
              !iv_uname   TYPE sy-uname
              !iv_repid   TYPE program
              !iv_from_date TYPE datum OPTIONAL
              !iv_to_date TYPE datum OPTIONAL

    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
