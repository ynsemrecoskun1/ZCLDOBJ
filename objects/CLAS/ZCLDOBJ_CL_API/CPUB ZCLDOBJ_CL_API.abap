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

           ty_code_range TYPE RANGE OF ty_errordetails-code,
           ty_statu      TYPE c LENGTH 1,

           BEGIN OF ty_message_item,
             code     TYPE string,
             message  TYPE string,
             severity TYPE string,
             msgid    TYPE string,
             msgno    TYPE string,
             msgv1    TYPE string,
             msgv2    TYPE string,
             msgv3    TYPE string,
             msgv4    TYPE string,
           END OF ty_message_item,

           tyt_message_items TYPE STANDARD TABLE OF ty_message_item WITH DEFAULT KEY.

    CONSTANTS: BEGIN OF gcs_api_type,
                 odatav2 TYPE ty_api_type VALUE 'ODATAV2',
                 odatav4 TYPE ty_api_type VALUE 'ODATAV4',
               END OF gcs_api_type,
               gc_default_language TYPE string VALUE 'tr'.

    CLASS-DATA: mo_destination  TYPE REF TO if_http_destination,
                mo_http_client  TYPE REF TO if_web_http_client,
                mo_client_proxy TYPE REF TO /iwbep/if_cp_client_proxy.

    CLASS-METHODS:
      create_api_objects IMPORTING iv_api_type       TYPE ty_api_type
                                   iv_comm_scenario  TYPE if_com_management=>ty_cscn_id
                                   iv_comm_system_id TYPE if_com_management=>ty_cs_id OPTIONAL
                                   iv_service_id     TYPE if_com_management=>ty_cscn_outb_srv_id OPTIONAL
                                   is_proxy_model    TYPE /iwbep/if_cp_runtime_types=>ty_s_proxy_model_key OPTIONAL
                                   iv_service_root   TYPE string OPTIONAL
                                   iv_language       TYPE string DEFAULT gc_default_language
                         RAISING   cx_http_dest_provider_error
                                   cx_web_http_client_error
                                   /iwbep/cx_gateway,

      release_api_objects,

      get_error_messages IMPORTING io_catch_data      TYPE REF TO object
                                   ir_codes           TYPE ty_code_range OPTIONAL
                         RETURNING VALUE(rt_messages) TYPE tyt_message_items,

      deserialize_errors IMPORTING io_catch_data TYPE REF TO object
                                   ir_codes      TYPE ty_code_range OPTIONAL
                         EXPORTING ev_message    TYPE string
                                   ev_statu      TYPE ty_statu
                                   et_messages   TYPE tyt_message_items,

      get_fields_of_str IMPORTING iv_structure     TYPE string
                        RETURNING VALUE(rt_fields) TYPE /iwbep/if_cp_runtime_types=>ty_t_property_path.
