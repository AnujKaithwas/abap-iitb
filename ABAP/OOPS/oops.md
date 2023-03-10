# OOPS Concepts

```abap
REPORT Z1DEMO.

**********************************abap classes access specifications and inheritance: begin
CLASS LCL_DEMO_1 DEFINITION.
  PUBLIC SECTION.
    METHODS: PRINT_PUBLIC.
  PROTECTED SECTION.
    METHODS: PRINT_PROTECTED.
  PRIVATE SECTION.
    METHODS: PRINT_PRIVATE.
ENDCLASS.

CLASS LCL_DEMO_1 IMPLEMENTATION.
  METHOD PRINT_PUBLIC.
    WRITE /: 'public class 1'.
    CALL METHOD PRINT_PROTECTED.
    CALL METHOD PRINT_PRIVATE.
  ENDMETHOD.
  METHOD PRINT_PROTECTED.
    WRITE /: 'protected class 1'.
  ENDMETHOD.
  METHOD PRINT_PRIVATE.
    WRITE /: 'private class 1'.
  ENDMETHOD.
ENDCLASS.

CLASS LCL_DEMO_2 DEFINITION INHERITING FROM LCL_DEMO_1.
  PUBLIC SECTION.
    METHODS: PRINT_PUBLIC REDEFINITION.
  PROTECTED SECTION.
    METHODS: PRINT_PROTECTED REDEFINITION.
*  PRIVATE SECTION.
*    METHODS: PRINT_PRIVATE REDEFINITION.
ENDCLASS.

CLASS LCL_DEMO_2 IMPLEMENTATION.
  METHOD PRINT_PUBLIC.
    WRITE /: 'inherited call to public'.
    CALL METHOD: PRINT_PROTECTED.
  ENDMETHOD.

  METHOD PRINT_PROTECTED.
    WRITE /: 'inherited call to protected'.
  ENDMETHOD.

*  METHOD PRINT_PRIVATE.
*    WRITE: 'inherited call to private'.
*  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(OREF1) = NEW LCL_DEMO_1( ).
  DATA(OREF2) = NEW LCL_DEMO_2( ).

  OREF1->PRINT_PUBLIC( ).
  OREF2->PRINT_PUBLIC( ).
**********************************abap classes access specifications and inheritance: end


**********************************abap classes static and instance attributes: begin
CLASS LCL_DEMO_1 DEFINITION.
  PUBLIC SECTION.
    DATA: LV_1 TYPE I.
    CLASS-DATA: LV_2 TYPE I.
    METHODS: INSTANCE.
    CLASS-METHODS: STATIC.
ENDCLASS.

CLASS LCL_DEMO_1 IMPLEMENTATION.
  METHOD INSTANCE.
    LV_1 = 10.
    LV_2 = 20.
  ENDMETHOD.

  METHOD STATIC.
*    LV_1 = 30.
    LV_2 = 40.
  ENDMETHOD.
ENDCLASS.



START-OF-SELECTION.
  BREAK-POINT.
  DATA(OREF1) = NEW LCL_DEMO_1( ).
  OREF1->INSTANCE( ).
  WRITE : 'instance value of oref1:', OREF1->LV_1.
  WRITE : 'static value of oref1:', OREF1->LV_2.
  OREF1->STATIC( ).
  WRITE : 'instance value of oref1:', OREF1->LV_1.
  WRITE : 'static value of oref1:', OREF1->LV_2.

  DATA(OREF2) = NEW LCL_DEMO_1( ).
  OREF2->INSTANCE( ).
  WRITE : 'instance value of oref2:', OREF2->LV_1.
  WRITE : 'static value of oref2:', OREF2->LV_2.
  OREF2->STATIC( ).
  WRITE : 'instance value of oref2:', OREF2->LV_1.
  WRITE : 'static value of oref2:', OREF2->LV_2.


**********************************abap classes static and instance attributes: end

**********************************abap classes constructor and class-constructor: begin
CLASS LCL1 DEFINITION.
  PUBLIC SECTION.
    METHODS CONSTRUCTOR.
    CLASS-METHODS CLASS_CONSTRUCTOR.
    CLASS-DATA: LV1 TYPE I.
ENDCLASS.


CLASS LCL1 IMPLEMENTATION.
  METHOD CONSTRUCTOR.
    LV1 = 1.
    WRITE: 'constructor says lv1 =', LV1.
  ENDMETHOD.

  METHOD CLASS_CONSTRUCTOR.
    LV1 = 10.
    WRITE: 'class constructor says lv1 =', LV1.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  BREAK-POINT.
*  DATA(OREF) = NEW LCL1( ).
  DATA: OREF TYPE REF TO LCL1.
  CREATE OBJECT OREF.

**********************************abap classes constructor and class-constructor: end

**********************************abap classes abstract: begin
*CLASS LCL1 DEFINITION ABSTRACT.
*  PUBLIC SECTION.
*    DATA: LV TYPE I.
*    METHODS: WRITE.
*    METHODS: DISPLAY IMPORTING LV1 TYPE I.
*  PROTECTED SECTION.
*  PRIVATE SECTION.
*ENDCLASS.
*
*
*CLASS LCL1 IMPLEMENTATION.
*  METHOD WRITE.
**    WRITE /: 'abstract method call'.
*  ENDMETHOD.
*
*  METHOD DISPLAY .
*    WRITE /: lv1.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS LCL2 DEFINITION INHERITING FROM LCL1.
*  PUBLIC SECTION.
**  METHODS WRITE REDEFINITION.
*ENDCLASS.
*
*CLASS LCL2 IMPLEMENTATION.
*
*ENDCLASS.
*
*START-OF-SELECTION.
*
*  DATA(OREF) = NEW LCL2( ).
*  BREAK-POINT.
*  CALL METHOD OREF->DISPLAY
*    EXPORTING
*      LV1 = 1
*    .
**********************************abap classes abstract: end

**********************************abap classes friends: begin
START-OF-SELECTION.
BREAK-POINT.
  DATA(OREF) = NEW ZCL090301( ).

  BREAK-POINT.
  CALL METHOD OREF->CALL_DISPLAY.

=====================================================================
class ZCL090301 definition
  public
  final
  create public .

public section.

  methods CALL_DISPLAY .
protected section.
private section.
ENDCLASS.



CLASS ZCL090301 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL090301->CALL_DISPLAY
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CALL_DISPLAY.

    DATA: OREF TYPE REF TO ZCL0903.
    CALL METHOD ZCL0903=>GET_INSTANCE
      IMPORTING
        EX_INSTANCE = OREF.

    DATA: EBELN TYPE EBELN.
    OREF->EBELN = 11.

    CALL METHOD OREF->DISPLAY
      EXPORTING
        I_EBELN = OREF->EBELN
      IMPORTING
        E_EBELN = EBELN.
    .

    WRITE /: 'ebeln exported from friend class is', OREF->EBELN.
    WRITE /: 'ebeln imported into friend class is', EBELN.

  ENDMETHOD.
ENDCLASS.
=================================================================

class ZCL0903 definition
  public
  final
  create private

  global friends ZCL090301 .

public section.

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR .
  class-methods GET_INSTANCE
    exporting
      !EX_INSTANCE type ref to ZCL0903 .
protected section.
private section.

  class-data INSTANCE type ref to ZCL0903 .
  data EBELN type EBELN .

  methods DISPLAY
    importing
      !I_EBELN type EBELN
    exporting
      !E_EBELN type EBELN .
ENDCLASS.



CLASS ZCL0903 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL0903=>CLASS_CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method CLASS_CONSTRUCTOR.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL0903->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method CONSTRUCTOR.
    BREAK-POINT.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL0903->DISPLAY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_EBELN                        TYPE        EBELN
* | [<---] E_EBELN                        TYPE        EBELN
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD DISPLAY.
    WRITE /: 'imported private ebeln', I_EBELN.
    E_EBELN = 22.
    WRITE /: 'exported private ebeln', E_EBELN.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL0903=>GET_INSTANCE
* +-------------------------------------------------------------------------------------------------+
* | [<---] EX_INSTANCE                    TYPE REF TO ZCL0903
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_INSTANCE.
    IF  INSTANCE IS INITIAL.
      CREATE OBJECT INSTANCE.
    ENDIF.
    EX_INSTANCE = INSTANCE.
  ENDMETHOD.
ENDCLASS.
============================================================================================

**********************************abap classes friends: end
