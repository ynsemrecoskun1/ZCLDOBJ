  METHOD add_freetext.
    CHECK mo_log IS BOUND.

    " Free text
    DATA(lo_free) = cl_bali_free_text_setter=>create( severity = severity
                                                      text     = iv_text ).
    TRY.
        mo_log->add_item( lo_free ).
      CATCH cx_bali_runtime INTO DATA(lx_error).
        remember_error( lx_error ).
    ENDTRY.
  ENDMETHOD.