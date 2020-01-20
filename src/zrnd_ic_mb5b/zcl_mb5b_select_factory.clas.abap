CLASS zcl_mb5b_select_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_instance
      IMPORTING
                !iv_select_name   TYPE string

                !iv_package_size  TYPE int4 OPTIONAL
                !it_select_opt    TYPE /iwbep/t_mgw_select_option OPTIONAL
                !it_add_table     TYPE zrndic_deep_add_tab_tt OPTIONAL
                !iv_db_connection TYPE string OPTIONAL
      RETURNING
                VALUE(ro_instace) TYPE REF TO zif_mb5b_select_base
      RAISING   zcx_process_mb5b_select.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mb5b_select_factory IMPLEMENTATION.


  METHOD get_instance.
    CASE iv_select_name.
      WHEN 'MBEW_01'.
        ro_instace = NEW zcl_mb5b_select_mbew_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'EBEW_01'.
        ro_instace = NEW zcl_mb5b_select_ebew_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'QBEW_01'.
        ro_instace = NEW zcl_mb5b_select_qbew_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'OBEW_01'.
        ro_instace = NEW zcl_mb5b_select_obew_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'BSIM_01'.
        ro_instace = NEW zcl_mb5b_select_bsim_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MARD_01'.
        ro_instace = NEW zcl_mb5b_select_mard_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MCHA_01'.
        ro_instace = NEW zcl_mb5b_select_mcha_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSLB_01'.
        ro_instace = NEW zcl_mb5b_select_mslb_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSKU_01'.
        ro_instace = NEW zcl_mb5b_select_msku_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MKOL_01'.
        ro_instace = NEW zcl_mb5b_select_mkol_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSPR_01'.
        ro_instace = NEW zcl_mb5b_select_mspr_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSKA_01'.
        ro_instace = NEW zcl_mb5b_select_mska_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSKA_02'.
        ro_instace = NEW zcl_mb5b_select_mska_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MARA_01'.
        ro_instace = NEW zcl_mb5b_select_mara_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MAKT_01'.
        ro_instace = NEW zcl_mb5b_select_makt_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'T134M_01'.
        ro_instace = NEW zcl_mb5b_select_t134m_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MCSD_01'.
        ro_instace = NEW zcl_mb5b_select_mcsd_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MARD_02'.
        ro_instace = NEW zcl_mb5b_select_mard_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MCHB_01'.
        ro_instace = NEW zcl_mb5b_select_mchb_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSLB_02'.
        ro_instace = NEW zcl_mb5b_select_mslb_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSKU_02'.
        ro_instace = NEW zcl_mb5b_select_msku_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MSPR_02'.
        ro_instace = NEW zcl_mb5b_select_mspr_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'MCHA_02'.
        ro_instace = NEW zcl_mb5b_select_mcha_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
       WHEN 'T030R_01'.
        ro_instace = NEW zcl_mb5b_select_t030r_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
       WHEN 'T030_01'.
        ro_instace = NEW zcl_mb5b_select_t030_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).

       WHEN 'MKPF_01' OR 'MKPF_02' OR 'MKPF_03' OR 'MKPF_04'  OR 'MKPF_05'.
        "We have the same structure for this pack of selects on this side
        ro_instace = NEW zcl_mb5b_select_MKPF_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
       WHEN 'T001_01'.
        ro_instace = NEW zcl_mb5b_select_t001_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'T001W_01'.
        ro_instace = NEW zcl_mb5b_select_t001w_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'T001K_01'.
        ro_instace = NEW zcl_mb5b_select_t001k_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'AIND_01'.
        ro_instace = NEW zcl_mb5b_select_aind_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'TTYPV_01'.
        ro_instace = NEW zcl_mb5b_select_ttypv_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'ESDUS_01'.
        ro_instace = NEW zcl_mb5b_select_esdus_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'ESDUS_02'.
        ro_instace = NEW zcl_mb5b_select_esdus_02( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt ).
      WHEN 'BKPF_01'.
        ro_instace = NEW zcl_mb5b_select_bkpf_01( iv_select_name = iv_select_name
                                                                                    iv_package_size = iv_package_size
                                                                                    it_select_opt   = it_select_opt
                                                                                    it_add_table = it_add_table ).
      WHEN OTHERS.
        RAISE EXCEPTION TYPE zcx_process_mb5b_select.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
