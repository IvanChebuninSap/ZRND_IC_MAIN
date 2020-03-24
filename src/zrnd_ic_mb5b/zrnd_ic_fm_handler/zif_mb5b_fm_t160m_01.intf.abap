INTERFACE zif_mb5b_fm_t160m_01
  PUBLIC .

  METHODS get_results
    EXPORTING
              ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
        !iv_arbgb TYPE arbgb
        !iv_msgnr TYPE msgnr
    RAISING zcx_process_mb5b_select.



ENDINTERFACE.
