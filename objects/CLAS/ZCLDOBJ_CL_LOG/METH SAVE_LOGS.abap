  METHOD save_logs.
    IF mt_log IS NOT INITIAL.
      MODIFY zcldobj_a_log FROM TABLE @mt_log.
    ENDIF.

    IF mt_log_detail IS NOT INITIAL.
      MODIFY zcldobj_a_logdet FROM TABLE @mt_log_detail.
    ENDIF.

    IF iv_behavior IS INITIAL.
      COMMIT WORK AND WAIT.
    ENDIF.
  ENDMETHOD.