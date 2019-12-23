CLASS zcl_mmim_userdefaults DEFINITION
 PUBLIC
  CREATE PUBLIC .

*"* public components of class CL_MMIM_USERDEFAULTS
*"* do not include other source files here!!!
  PUBLIC SECTION.

    CLASS-METHODS flush_all .
    CLASS-METHODS prefetch
      IMPORTING
        !it_action TYPE table
        !i_uname   TYPE syuname DEFAULT sy-uname .
    METHODS constructor
      IMPORTING
        !i_uname  TYPE syuname DEFAULT sy-uname
        !i_action TYPE zes_action .
    METHODS get
      IMPORTING
        !i_element      TYPE any
      RETURNING
        VALUE(r_active) TYPE zes_active .
    METHODS set
      IMPORTING
        !i_element TYPE any
        !i_active  TYPE any .
    METHODS preset
      IMPORTING
        !i_element TYPE any
        !i_active  TYPE any .
    METHODS delete
      IMPORTING
        !i_element TYPE any .
    METHODS flush .
    METHODS get_all
      RETURNING
        VALUE(et_active) TYPE zet_active .
*" protected components of class CL_MMIM_USERDEFAULTS
*" do not include other source files here!!!
  PROTECTED SECTION.

*" private components of class CL_MMIM_USERDEFAULTS
*" do not include other source files here!!!
  PRIVATE SECTION.


*" types
    TYPES:
      BEGIN OF ty_esdus,
        element TYPE zes_element,
        active  TYPE zes_active,
        update  TYPE char1,
      END OF ty_esdus .

*" class attributes
    CLASS-DATA:
      t_instances       TYPE TABLE OF REF TO zcl_mmim_userdefaults ,
      t_actions         TYPE TABLE OF zes_action ,
      t_prefetch        TYPE TABLE OF zesdus ,
      prefetch_user     TYPE syuname ,
      t_prefetch_action TYPE TABLE OF zes_action .

*" instance attributes
    DATA:
      t_esdus      TYPE HASHED TABLE OF ty_esdus WITH UNIQUE KEY element ,
      t_preset     TYPE HASHED TABLE OF ty_esdus WITH UNIQUE KEY element ,
      f_uname      TYPE syuname ,
      f_action     TYPE zes_action ,
      needs_update TYPE char1 .
ENDCLASS.



CLASS zcl_mmim_userdefaults IMPLEMENTATION.
  METHOD constructor.
************************************************************************
* Read user defaults from database into internal buffer table
************************************************************************
    DATA: ls_prefetch TYPE zesdus,
          ls_esdus    TYPE ty_esdus.
* Check that the requested segment has not been loaded yet by
* another instance.
    READ TABLE t_actions WITH KEY table_line = i_action
      TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
*   For sake of data consistency, only one instance at a time can
*   access a segment in ESDUS. If this message occurs, this is
*   an error in the calling application.
      MESSAGE e899(migo) WITH 'CL_MMIM_USERDEFAULTS' 'DOUBLE_CREATION'
                              i_action space.
    ENDIF.
    APPEND i_action TO t_actions.
* Load the segment
    CLEAR t_esdus.
    READ TABLE t_prefetch_action WITH KEY table_line = i_action
                                 TRANSPORTING NO FIELDS.
    IF sy-subrc = 0 AND prefetch_user = i_uname.
      LOOP AT t_prefetch INTO ls_prefetch WHERE uname  = i_uname
                                            AND action = i_action.
        MOVE-CORRESPONDING ls_prefetch TO ls_esdus.
        INSERT ls_esdus INTO TABLE t_esdus.
      ENDLOOP.
      DELETE t_prefetch WHERE uname  = i_uname
                          AND action = i_action.
    ELSE.



     ZCL_TODO_LIST=>replace_select( ).

*      SELECT element active FROM esdus
*                            INTO CORRESPONDING FIELDS OF TABLE t_esdus
*                            WHERE uname  = i_uname
*                              AND action = i_action.




    ENDIF.
* Save constructor parameters
    f_uname  = i_uname.
    f_action = i_action.
* Add yourself to the table of instances
    APPEND me TO t_instances.
  ENDMETHOD.




















  METHOD delete.
************************************************************************
* Mark an element for deletion on the database.
* If the element is not on the database yet (status I), delete table.
************************************************************************
    DATA: ls_esdus TYPE ty_esdus.
    READ TABLE t_esdus INTO ls_esdus
                       WITH TABLE KEY element = i_element
                       TRANSPORTING update.
    IF sy-subrc = 0 AND ls_esdus = 'I'.
      DELETE t_esdus WHERE element = i_element.
    ELSE.
      ls_esdus-element = i_element.
      ls_esdus-update  = 'D'.
      needs_update     = 'X'.
      MODIFY TABLE t_esdus FROM ls_esdus TRANSPORTING update.
    ENDIF.
  ENDMETHOD.




















  METHOD flush.
************************************************************************
* Write changed data from the buffer to the database.
*
************************************************************************
    FIELD-SYMBOLS: <wa> TYPE ty_esdus.
    DATA: ls_dbtab TYPE zesdus.
    LOOP AT t_esdus ASSIGNING <wa> WHERE update <> space.
      ls_dbtab-mandt  = sy-mandt.
      ls_dbtab-uname  = f_uname.
      ls_dbtab-action = f_action.
      MOVE-CORRESPONDING <wa> TO ls_dbtab.             "ELEMENT and ACTIVE
      CASE <wa>-update.
        WHEN 'I'.
        zcl_todo_list=>ivan( ).
        "  INSERT INTO esdus VALUES ls_dbtab.
          <wa>-update = space.
        WHEN 'U'.
        zcl_todo_list=>ivan( ).
          "MODIFY esdus FROM ls_dbtab.
          <wa>-update = space.
        WHEN 'D'.
        zcl_todo_list=>ivan( ).
          "DELETE esdus FROM ls_dbtab.
          DELETE TABLE t_esdus FROM <wa>.
      ENDCASE.
    ENDLOOP.
    CLEAR needs_update.
  ENDMETHOD.




















  METHOD flush_all.
************************************************************************
* Call FLUSH for all created instances
************************************************************************
    DATA: l_oref TYPE REF TO zcl_mmim_userdefaults.
    LOOP AT t_instances INTO l_oref WHERE table_line->needs_update = 'X'.
      CALL METHOD l_oref->flush.
    ENDLOOP.
  ENDMETHOD.


























  METHOD get .
************************************************************************
* Read a user default value
************************************************************************
    DATA: ls_esdus TYPE ty_esdus.
    CLEAR r_active.
* Try access the user settings
    READ TABLE t_esdus INTO ls_esdus
                       WITH TABLE KEY element = i_element
                       TRANSPORTING active update.
    IF sy-subrc = 0 AND ls_esdus-update <> 'D'.
      r_active = ls_esdus-active.
      EXIT.
    ENDIF.
* Look up system defaults
    READ TABLE t_preset INTO ls_esdus
                        WITH TABLE KEY element = i_element
                        TRANSPORTING active.
    IF sy-subrc = 0.
      r_active = ls_esdus-active.
      EXIT.
    ENDIF.
  ENDMETHOD.




















  METHOD get_all.
    DATA: ls_esdus  TYPE ty_esdus,
          ls_active TYPE zesdus_short.
    LOOP AT t_esdus INTO ls_esdus.
      MOVE-CORRESPONDING ls_esdus TO ls_active.
      APPEND ls_active TO et_active.
    ENDLOOP.
  ENDMETHOD.


  METHOD prefetch.
************************************************************************
* Prefetch of data. All contructors check whether there ACTION is
* already in the buffer and copies from there.
************************************************************************
    t_prefetch_action = it_action.
    IF NOT t_prefetch_action IS INITIAL.
       zcl_todo_list=>replace_select( ).
*      SELECT * FROM esdus INTO TABLE t_prefetch
*               FOR ALL ENTRIES IN t_prefetch_action
*               WHERE uname  = i_uname
*                 AND action = t_prefetch_action-table_line.
    ENDIF.
    prefetch_user = i_uname.
  ENDMETHOD.






  METHOD preset.
************************************************************************
* Register a default value.
* If the "real" user defaults do not contain an entry for the
* ELEMENT, the system looks up the value from the presets.
************************************************************************
    DATA: ls_esdus TYPE ty_esdus.
    ls_esdus-element = i_element.
    ls_esdus-active  = i_active.
    MODIFY TABLE t_preset FROM ls_esdus.
    IF sy-subrc <> 0.
      INSERT ls_esdus INTO TABLE t_preset.
    ENDIF.
  ENDMETHOD.




















  METHOD set .
************************************************************************
* Write a value into the internal buffer.
* If the value does not exist, create it.
* If it exists, but has changed, mark the set for update.
* Otherwise: Do nothing.
************************************************************************
    DATA: ls_esdus TYPE ty_esdus.
    READ TABLE t_esdus INTO ls_esdus WITH TABLE KEY element = i_element.
* If the element exists, but was changed --> mark for update.
    IF sy-subrc = 0.
      CHECK ls_esdus-active <> i_active.
      ls_esdus-active = i_active.
      IF ls_esdus-update <> 'I'.
*     Element is not on the database yet --> INSERT stays INSERT.
        ls_esdus-update = 'U'.
        needs_update = 'X'.
      ENDIF.
      MODIFY TABLE t_esdus FROM ls_esdus.
    ELSE.
* Append new element.
      ls_esdus-element = i_element.
      ls_esdus-active  = i_active.
      ls_esdus-update  = 'I'.
      needs_update     = 'X'.
      INSERT ls_esdus INTO TABLE t_esdus.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
