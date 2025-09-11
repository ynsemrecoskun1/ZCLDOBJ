  METHOD get_duration.
    DATA: lv_hours       TYPE c LENGTH 2,
          lv_minutes     TYPE c LENGTH 2,
          lv_secs        TYPE c LENGTH 2,
          lv_time_string TYPE string.

    GET TIME STAMP FIELD DATA(lv_instant_tstmp).
*    DATA(lv_instant_tstmp) = CONV zcldobj_e_log_datetime( get_datetime_turkey( ) ).

    TRY.
        cl_abap_tstmp=>subtract(
          EXPORTING
            tstmp1 = lv_instant_tstmp
            tstmp2 = mv_begin_datetime
          RECEIVING
            r_secs = DATA(lv_seconds)
        ).

        " Calculate hours, minutes, and seconds
        lv_hours   = lv_seconds DIV 3600.
        lv_minutes = ( lv_seconds MOD 3600 ) DIV 60.
        lv_secs    = lv_seconds MOD 60.

        " Format as HH:MM:SS
        rv_time = |{ lv_hours ALPHA = IN WIDTH = 2 }{ lv_minutes ALPHA = IN WIDTH = 2 }{ lv_secs ALPHA = IN WIDTH = 2 }|.


      CATCH cx_parameter_invalid_range cx_parameter_invalid_type INTO DATA(lx_error).

    ENDTRY.
  ENDMETHOD.