  METHOD save_log.
    " Save logs
    TRY.
        cl_bali_log_db=>get_instance( )->save_log( mo_log ).
      CATCH cx_bali_runtime.
        "handle exception
    ENDTRY.

    " Get the handle
    rv_result = mo_log->get_handle( ).
  ENDMETHOD.