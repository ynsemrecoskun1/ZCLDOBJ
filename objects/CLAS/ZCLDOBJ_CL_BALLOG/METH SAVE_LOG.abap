  METHOD save_log.
    CHECK mo_log IS BOUND.

    " Save logs
    TRY.
        IF iv_jobapp EQ abap_true.
          cl_bali_log_db=>get_instance( )->save_log_2nd_db_connection( log = mo_log
                                                                       assign_to_current_appl_job = abap_true ).
        ELSE.
          cl_bali_log_db=>get_instance( )->save_log( mo_log ).
        ENDIF.
      CATCH cx_bali_runtime INTO DATA(lx_bali_runtime).
        remember_error( lx_bali_runtime ).
    ENDTRY.

    " Get the handle
    rv_result = mo_log->get_handle( ).
  ENDMETHOD.