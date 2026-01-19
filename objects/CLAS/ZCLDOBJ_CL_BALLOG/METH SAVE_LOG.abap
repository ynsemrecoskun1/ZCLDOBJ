    METHOD save_log.
      " Save logs
      TRY.
          IF iv_jobapp EQ abap_true.
            cl_bali_log_db=>get_instance( )->save_log_2nd_db_connection( log = mo_log
                                                                         assign_to_current_appl_job = abap_true ).
          ELSE.
            cl_bali_log_db=>get_instance( )->save_log( mo_log ).
          ENDIF.
        CATCH cx_bali_runtime INTO DATA(lx_bali_runtime).
          DATA(lv_text) = lx_bali_runtime->get_longtext(  ).
      ENDTRY.

      " Get the handle
      rv_result = mo_log->get_handle( ).
    ENDMETHOD.