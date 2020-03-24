INTERFACE zif_mb5b_fm_mb_control_01
  PUBLIC .

  TYPES tt_zs156s TYPE TABLE OF zst156s.

  METHODS get_results
    EXPORTING
              !et_s156s TYPE tt_zs156s
              !ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_bwart TYPE bwart
              !it_s156s TYPE tt_zs156s

    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
