CLASS zcl_fin_locru_switch_check DEFINITION
 public
  final
  create public .

public section.

  class-methods FIN_LOCRU_SFWS_UI_00
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_NP
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_02
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_03
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_04
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_05
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_06
    returning
      value(RV_ACTIVE) type BOOLE_D .
  class-methods FIN_LOCRU_SFWS_UI_09
    returning
      value(RV_ACTIVE) type BOOLE_D .
protected section.
*"* protected components of class CL_FIN_LOCRU_SWITCH_CHECK
*"* do not include other source files here!!!
private section.
*"* private components of class CL_FIN_LOCRU_SWITCH_CHECK
*"* do not include other source files here!!!
ENDCLASS.



CLASS zcl_fin_locru_switch_check IMPLEMENTATION.

method FIN_LOCRU_SFWS_UI_00.

* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.

endmethod.


method FIN_LOCRU_SFWS_UI_02.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
endmethod.


method FIN_LOCRU_SFWS_UI_03.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
endmethod.


method FIN_LOCRU_SFWS_UI_04.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
endmethod.


method FIN_LOCRU_SFWS_UI_05.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
endmethod.


  method FIN_LOCRU_SFWS_UI_06.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
  endmethod.


  method FIN_LOCRU_SFWS_UI_09.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
  endmethod.


method FIN_LOCRU_SFWS_UI_NP.
* Standard implementation w/o switched overwite exit: Switch is inactive
  rv_active = abap_false.
endmethod.

ENDCLASS.
