  METHOD severity_from_numeric.
    rv_severity = SWITCH #( iv_numeric
                            WHEN `1` OR `2` THEN `info`
                            WHEN `3`        THEN `warning`
                            ELSE                 `error` ).
  ENDMETHOD.