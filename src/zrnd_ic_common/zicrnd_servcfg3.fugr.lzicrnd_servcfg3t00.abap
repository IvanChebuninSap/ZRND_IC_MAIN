*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 25.02.2020 at 16:30:57
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZICRND_SERVC....................................*
DATA:  BEGIN OF STATUS_ZICRND_SERVC                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZICRND_SERVC                  .
CONTROLS: TCTRL_ZICRND_SERVC
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZICRND_SERVC                  .
TABLES: ZICRND_SERVC                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
