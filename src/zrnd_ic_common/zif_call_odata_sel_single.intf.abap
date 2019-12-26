interface ZIF_CALL_ODATA_SEL_SINGLE
  public .


  constants GC_SELECT_SINGLE_SRV type STRING value 'http://evbyminsd74b3.minsk.epam.com:8000/sap/opu/odata/sap/zrndic_select_single_srv/SelectSingle?'. "#EC NOTEXT
  constants GC_PARAM_TABLE_NAME type STRING value 'TableName='. "#EC NOTEXT
  constants GC_PARAM_FIELD_LIST type STRING value 'FieldList='. "#EC NOTEXT
  constants GC_PARAM_WHERE_CONDITION type STRING value 'WhereCondition='. "#EC NOTEXT

  methods CALL_SINGLE_SELECT
    importing
      !IV_WHERE_CLAUSE type TEXT255
      !IV_TABLE_NAME type TEXT255
      !IV_FIELD_LIST type TEXT255
    exporting
      !RV_PARSED_RESULT type ZSELECT_SINGLE_RESULT_TT .
endinterface.
