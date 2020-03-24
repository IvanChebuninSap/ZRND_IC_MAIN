INTERFACE zif_mb5b_fm_aind_nametab_get
  PUBLIC .

  TYPES:  BEGIN OF aind_st_nametab,                         "n1481757
            tabname   TYPE dd02d-tabname,                   "n1481757
            fieldname TYPE dd03d-fieldname,                 "n1481757
            keyflag   TYPE dd03d-keyflag,                   "n1481757
            scr_tab   TYPE dd02d-tabname,                   "n1481757
            scr_field TYPE dd03d-fieldname,                 "n1481757
            key_oblig TYPE c LENGTH 1,                      "n1481757
          END OF aind_st_nametab.                           "n1481757
  TYPES:        aind_tt_nametab TYPE TABLE OF aind_st_nametab. "n1481757

  METHODS get_results
    EXPORTING
              !et_tabname TYPE aind_tt_nametab
              !ev_subrc   TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_archindex TYPE aind_str1-archindex
              !iv_reffields TYPE boole_d
              !it_tabname   TYPE aind_tt_nametab OPTIONAL


    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
