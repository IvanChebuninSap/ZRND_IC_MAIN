INTERFACE zif_call_odata_sel_single
  PUBLIC .

  METHODS call_single_select
    IMPORTING
      !iv_where_clause  TYPE string OPTIONAL
      !iv_table_name    TYPE text255
      !iv_field_list    TYPE text255 OPTIONAL
      !iv_structure_name    TYPE text255
      !iv_db_connection TYPE text255 OPTIONAL
    EXPORTING
      !es_output TYPE any .
ENDINTERFACE.
