interface ZIF_CALL_ODATA_SEL_GENERIC
  public .

  METHODS call_generic_select
    IMPORTING
      !iv_where_clause  TYPE string OPTIONAL
      !iv_table_name    TYPE text255
      !iv_field_list    TYPE text255 OPTIONAL
      !iv_structure_name    TYPE text255
      !iv_db_connection TYPE text255 OPTIONAL
      !iv_paging_top       TYPE numc4 OPTIONAL
      !iv_paging_skip      TYPE numc4 OPTIONAL
      !iv_distinct              TYPE boole_d DEFAULT abap_false
    EXPORTING
      !et_output TYPE any .


endinterface.
