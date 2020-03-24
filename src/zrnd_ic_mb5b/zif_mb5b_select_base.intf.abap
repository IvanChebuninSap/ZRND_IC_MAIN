INTERFACE zif_mb5b_select_base
  PUBLIC .

    METHODS process
        EXPORTING
            !et_output TYPE any
        RAISING zcx_process_mb5b_select.

endinterface.
