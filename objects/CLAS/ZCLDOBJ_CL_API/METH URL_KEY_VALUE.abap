  METHOD url_key_value.
    FIND PCRE |{ iv_key }='([^']*)'| IN iv_url SUBMATCHES DATA(lv_value).
    IF sy-subrc = 0.
      rv_value = cl_web_http_utility=>unescape_url( lv_value ).
    ENDIF.
  ENDMETHOD.