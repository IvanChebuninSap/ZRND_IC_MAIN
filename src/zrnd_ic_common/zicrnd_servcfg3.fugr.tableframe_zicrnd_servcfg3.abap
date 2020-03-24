*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZICRND_SERVCFG3
*   generation date: 25.02.2020 at 16:30:57
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZICRND_SERVCFG3    .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
