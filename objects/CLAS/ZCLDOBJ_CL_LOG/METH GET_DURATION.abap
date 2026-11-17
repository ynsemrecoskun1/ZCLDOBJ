  METHOD get_duration.
    DATA: lv_total   TYPE i,
          lv_hours   TYPE i,
          lv_minutes TYPE i,
          lv_secs    TYPE i.

    GET TIME STAMP FIELD DATA(lv_instant_tstmp).

    TRY.
        cl_abap_tstmp=>subtract(
          EXPORTING
            tstmp1 = lv_instant_tstmp
            tstmp2 = mv_begin_datetime
          RECEIVING
            r_secs = DATA(lv_seconds)
        ).

        " Saniyenin ondalık kısmı ve negatif değerler HHMMSS biçimini bozmasın
        lv_total = nmax( val1 = 0 val2 = round( val = lv_seconds dec = 0 ) ).

        " TIMS alanı en fazla 23:59:59 tutar
        lv_total   = nmin( val1 = lv_total val2 = 86399 ).
        lv_hours   = lv_total DIV 3600.
        lv_minutes = ( lv_total MOD 3600 ) DIV 60.
        lv_secs    = lv_total MOD 60.

        " HHMMSS biçimi
        rv_time = |{ lv_hours WIDTH = 2 PAD = `0` ALIGN = RIGHT }{ lv_minutes WIDTH = 2 PAD = `0` ALIGN = RIGHT }{ lv_secs WIDTH = 2 PAD = `0` ALIGN = RIGHT }|.

      CATCH cx_parameter_invalid_range cx_parameter_invalid_type.
        CLEAR rv_time.
    ENDTRY.
  ENDMETHOD.