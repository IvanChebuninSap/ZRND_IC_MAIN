interface ZIF_MB5B_SELECT_BASE
  public .

    METHODS process
        EXPORTING
            !et_output TYPE any
        RAISING zcx_process_mb5b_select.

endinterface.
