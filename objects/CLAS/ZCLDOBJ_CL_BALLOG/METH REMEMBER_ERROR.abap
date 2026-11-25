  METHOD remember_error.
    " İlk hata saklanır, sonrakiler onu ezmez
    CHECK mv_error IS INITIAL.

    mv_error = io_exception->get_longtext( ).
    IF mv_error IS INITIAL.
      mv_error = io_exception->get_text( ).
    ENDIF.
  ENDMETHOD.