  METHOD convert_timestamp_w_time_zone.
    IF iv_datetime IS INITIAL.
      GET TIME STAMP FIELD DATA(lv_timestamp).
    ELSE.
      lv_timestamp = iv_datetime.
    ENDIF.
    TRY.
        CONVERT TIME STAMP lv_timestamp
          TIME ZONE iv_time_zone_to
          INTO DATE DATA(lv_date)
               TIME DATA(lv_time).

        CONVERT DATE lv_date TIME lv_time
          INTO TIME STAMP ev_datetime
          TIME ZONE iv_time_zone_from.

        CONVERT TIME STAMP ev_datetime
          TIME ZONE mc_time_zone_utc
          INTO DATE ev_date
               TIME ev_time.
      CATCH cx_abap_context_info_error.
    ENDTRY.
  ENDMETHOD.