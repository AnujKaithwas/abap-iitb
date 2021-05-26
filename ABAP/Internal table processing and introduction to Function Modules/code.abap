*&---------------------------------------------------------------------*
*& Report Z21052021_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z21052021_1.

DATA: LWA_EKKO TYPE EKKO.

BREAK: ATOS_ABAP08.

CALL FUNCTION 'ZMM_PO_GET_DETAILS'
  EXPORTING
    IV_EBELN = '4500000001'               " Purchasing Document Number
  IMPORTING
    ES_EKKO  = LWA_EKKO.                  " Purchasing Document Header

BREAK: ATOS_ABAP08.
