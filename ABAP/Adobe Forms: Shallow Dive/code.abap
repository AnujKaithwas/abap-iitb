*&---------------------------------------------------------------------*
*& Report ZHPERSDETDEMO1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHPERSDETDEMO1.

TABLES: PA0002.

PARAMETERS: P_PERNR TYPE PA0002-PERNR.

DATA: GS_OUTPUTPARAMS TYPE SFPOUTPUTPARAMS,
      GS_DOCPARAMS    TYPE SFPDOCPARAMS,
      GV_FM_NAME      TYPE RS38L_FNAM.

SELECT SINGLE *
  FROM  PA0002
  INTO @DATA(LWA_0002)
  WHERE PERNR = @P_PERNR.

"1. job open
GS_OUTPUTPARAMS-DEVICE    =  'PRINTER'.
GS_OUTPUTPARAMS-DEST      =  'LP01'.
GS_OUTPUTPARAMS-NODIALOG  = 'X'.
GS_OUTPUTPARAMS-PREVIEW   = 'X'.

CALL FUNCTION 'FP_JOB_OPEN'
  CHANGING
    IE_OUTPUTPARAMS = GS_OUTPUTPARAMS
  EXCEPTIONS
    CANCEL          = 1
    USAGE_ERROR     = 2
    SYSTEM_ERROR    = 3
    INTERNAL_ERROR  = 4
    OTHERS          = 5.
IF SY-SUBRC <> 0.
  " <error handling>
ENDIF.
" Get the name of the generated function module

**** adobe form call funtion module call ***********
"2. Connverting Adobe form name into system dependant run-time generated
"dynamic form name
CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
  EXPORTING
    I_NAME     = 'ZHF_GET_USER_DETAILS'
  IMPORTING
    E_FUNCNAME = GV_FM_NAME.
IF SY-SUBRC <> 0.
  "<error handling>
ENDIF.

GS_DOCPARAMS-LANGU   = 'E'.
*  wa_docparams-country = 'US'.

CALL FUNCTION GV_FM_NAME
  EXPORTING
    IV_0002        = LWA_0002
  EXCEPTIONS
    USAGE_ERROR    = 1
    SYSTEM_ERROR   = 2
    INTERNAL_ERROR = 3.



"3. CLosing the PDF call/job
" Close the spool job 
CALL FUNCTION 'FP_JOB_CLOSE'
  EXCEPTIONS
    USAGE_ERROR    = 1
    SYSTEM_ERROR   = 2
    INTERNAL_ERROR = 3
    OTHERS         = 4.
*&

BREAK-POINT.
