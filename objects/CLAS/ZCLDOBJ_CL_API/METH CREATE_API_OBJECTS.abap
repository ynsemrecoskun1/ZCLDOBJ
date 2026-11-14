  METHOD create_api_objects.
    release_api_objects( ).

    mo_destination = cl_http_destination_provider=>create_by_comm_arrangement(
                       comm_scenario  = iv_comm_scenario
                       comm_system_id = iv_comm_system_id
                       service_id     = iv_service_id ).
    mo_http_client = cl_web_http_client_manager=>create_by_http_destination( mo_destination ).

    mo_http_client->get_http_request( )->set_header_field( i_name  = 'Accept-Language'
                                                           i_value = iv_language ).

    CASE to_upper( iv_api_type ).
      WHEN gcs_api_type-odatav2.
        mo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
                            is_proxy_model_key       = is_proxy_model
                            io_http_client           = mo_http_client
                            iv_relative_service_root = iv_service_root ).

      WHEN gcs_api_type-odatav4.
        mo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v4_remote_proxy(
                            is_proxy_model_key       = is_proxy_model
                            io_http_client           = mo_http_client
                            iv_relative_service_root = iv_service_root ).

      WHEN OTHERS.
        release_api_objects( ).
        RAISE EXCEPTION TYPE /iwbep/cx_gateway.
    ENDCASE.
  ENDMETHOD.