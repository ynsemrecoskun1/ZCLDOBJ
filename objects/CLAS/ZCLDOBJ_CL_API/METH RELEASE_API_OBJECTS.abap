  METHOD release_api_objects.
    IF mo_http_client IS BOUND.
      TRY.
          mo_http_client->close( ).
        CATCH cx_web_http_client_error INTO DATA(lx_close).
          CLEAR lx_close.
      ENDTRY.
    ENDIF.
    CLEAR: mo_client_proxy, mo_http_client, mo_destination.
  ENDMETHOD.