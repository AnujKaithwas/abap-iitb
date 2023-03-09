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

**********************************abap classes static and instance constructor and class-constructor: begin
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

**********************************abap classes static and instance constructor and class-constructor: end
