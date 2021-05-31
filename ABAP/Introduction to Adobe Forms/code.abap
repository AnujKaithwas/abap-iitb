
DATA: LV_PERNR TYPE PERNR_D.

SELECT SINGLE *
  FROM PA0002
  WHERE PERNR = '10000010'
  INTO @DATA(LS_0002).

GV_PERNR = LS_0002-PERNR. "exist globally in form context
LV_PERNR = LS_0002-PERNR. "exist only locally and not on the layout
