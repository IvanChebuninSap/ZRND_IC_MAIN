INTERFACE ZIF_MB5B_FM_MATBEL_READ
  PUBLIC .

  TYPES tt_mkpf TYPE TABLE of zmkpf.
  TYPES tt_mseg TYPE TABLE of zmseg..

  METHODS get_results
    EXPORTING
             !et_mkpf TYPE tt_mkpf
             !et_mseg TYPE tt_mseg
             !ev_subrc TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_archivekey TYPE zmkpf_aridx-arkey
              !iv_offset TYPE zmkpf_aridx-archoffset
              !it_mkpf TYPE tt_mkpf OPTIONAL
              !it_mseg TYPE tt_mseg OPTIONAL

    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
