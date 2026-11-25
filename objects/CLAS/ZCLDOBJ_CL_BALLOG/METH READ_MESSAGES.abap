  METHOD read_messages.
    CLEAR et_messages.
    CHECK mo_log IS BOUND.

    TRY.
        DATA(lo_log_db) = cl_bali_log_db=>get_instance( ).
        DATA(lo_log)    = lo_log_db->load_log( mo_log->get_handle( ) ).
        et_messages     = lo_log->get_all_items( ).
      CATCH cx_bali_runtime INTO DATA(lx_error).
        " Yüklenemeyen log üzerinde get_all_items çağrılmaz
        remember_error( lx_error ).
    ENDTRY.
  ENDMETHOD.