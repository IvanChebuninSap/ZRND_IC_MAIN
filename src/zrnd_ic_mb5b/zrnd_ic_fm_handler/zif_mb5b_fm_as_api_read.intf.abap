INTERFACE ZIF_MB5B_FM_AS_API_READ
  PUBLIC .

TYPES : BEGIN OF stab_frange,                                 "n1481757
          fieldname TYPE fieldname,                         "n1481757
          selopt_t  TYPE STANDARD TABLE OF                  "n1481757
                    rsdsselopt                              "n1481757
                    WITH DEFAULT KEY,                       "n1481757
        END OF stab_frange.                                   "n1481757

TYPES: BEGIN OF stype_as_key,                               "n1481757
         archivekey TYPE zmkpf_aridx-arkey,                 "n1481757
         archiveofs TYPE zmkpf_aridx-archoffset,            "n1481757
         mblnr      TYPE zmkpf-mblnr,                       "n1481757
         mjahr      TYPE zmkpf-mjahr,                       "n1481757
       END OF stype_as_key,                                 "n1481757
                                                            "n1481757
       stab_as_key TYPE STANDARD TABLE OF                   "n1481757
        stype_as_key.                                                "n1481757



TYPES tt_frange TYPE TABLE OF  stab_frange.

  METHODS get_results
    EXPORTING
              !et_as_key TYPE stab_as_key
              !ev_subrc   TYPE sy-subrc
    RAISING   zcx_process_mb5b_select.

  METHODS set_input
    IMPORTING
              !iv_fieldcat TYPE aind_str1-skey
              !it_selections TYPE tt_frange
              !it_as_key   TYPE stab_as_key OPTIONAL


    RAISING   zcx_process_mb5b_select.



ENDINTERFACE.
