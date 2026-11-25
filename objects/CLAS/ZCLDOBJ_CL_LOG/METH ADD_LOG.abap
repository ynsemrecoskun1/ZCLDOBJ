  METHOD add_log.
    IF mt_log IS INITIAL.
      APPEND INITIAL LINE TO mt_log ASSIGNING FIELD-SYMBOL(<lfs_log>).
    ELSE.
      READ TABLE mt_log ASSIGNING <lfs_log> INDEX 1.
    ENDIF.

    <lfs_log>              = CORRESPONDING #( is_log ).
    <lfs_log>-log_id       = mv_log_id.

    " Kokpit filtresi ve kritiklik rengi tutarlı çalışsın diye değerler normalize edilir
    <lfs_log>-status       = normalize_status( is_log-status ).
    <lfs_log>-service_type = normalize_type( is_log-service_type ).
    <lfs_log>-trigger_type = to_upper( is_log-trigger_type ).
    <lfs_log>-http_method  = to_upper( condense( is_log-http_method ) ).

    GET TIME STAMP FIELD <lfs_log>-log_datetime.

    <lfs_log>-duration     = get_duration( ).
  ENDMETHOD.