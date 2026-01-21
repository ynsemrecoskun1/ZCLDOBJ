
CLASS zcldobj_cl_api DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: ty_api_type TYPE c LENGTH 10,

           BEGIN OF ty_errordetails,
             message  TYPE string,
             code     TYPE string,
             severity TYPE string,
           END OF ty_errordetails,

           tyt_errrordetails TYPE STANDARD TABLE OF ty_errordetails WITH DEFAULT KEY,

           BEGIN OF ty_innererror,
             errordetails TYPE tyt_errrordetails,
           END OF ty_innererror,

           BEGIN OF ty_message,
             value TYPE string,
           END OF ty_message,

           BEGIN OF ty_error,
             message    TYPE ty_message,
             innererror TYPE ty_innererror,
           END OF ty_error,

           BEGIN OF ty_errorbody,
             error TYPE ty_error,
           END OF ty_errorbody,

           ty_code_range TYPE RANGE OF ty_errordetails-code,
           ty_statu      TYPE c LENGTH 1.

    CLASS-DATA: mo_destination  TYPE REF TO if_http_destination,
                mo_http_client  TYPE REF TO if_web_http_client,
                mo_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy.

    METHODS:
      constructor.
    CLASS-METHODS:
      create_api_objects IMPORTING iv_api_type       TYPE ty_api_type ""Örn. ODATAV4, ODATAV2, SOAP
                                   iv_comm_scenario  TYPE if_com_management=>ty_cscn_id
                                   iv_comm_system_id TYPE if_com_management=>ty_cs_id OPTIONAL
                                   iv_service_id     TYPE if_com_management=>ty_cscn_outb_srv_id OPTIONAL
                                   is_proxy_model    TYPE /iwbep/if_cp_runtime_types=>ty_s_proxy_model_key OPTIONAL
                                   iv_service_root   TYPE string OPTIONAL
                         RAISING   cx_http_dest_provider_error
                                   cx_web_http_client_error
                                   /iwbep/cx_gateway,
      deserialize_errors IMPORTING io_catch_data TYPE REF TO object
                                   ir_codes      TYPE ty_code_range OPTIONAL
                         EXPORTING ev_message    TYPE string
                                   ev_statu      TYPE ty_statu,

      get_fields_of_str IMPORTING iv_structure     TYPE string
                        RETURNING VALUE(rt_fields) TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path.
