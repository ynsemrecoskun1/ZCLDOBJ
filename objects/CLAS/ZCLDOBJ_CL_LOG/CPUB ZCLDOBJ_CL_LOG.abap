CLASS zcldobj_cl_log DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS: mc_time_zone_tr  LIKE sy-zonlo VALUE 'TURKEY',
               mc_time_zone_utc LIKE sy-zonlo VALUE 'UTC'.

    TYPES: tty_log        TYPE TABLE OF zcldobj_a_log,
           tty_log_detail TYPE TABLE OF zcldobj_a_logdet,
           BEGIN OF ty_log,
             service_name     TYPE zcldobj_e_service_name,
             service_type     TYPE zcldobj_e_service_type,
             trigger_type     TYPE zcldobj_e_trigger_type,
             request_payload  TYPE zcldobj_e_request_payload,
             response_payload TYPE zcldobj_e_response_payload,
             status           TYPE zcldobj_e_status,
             error_message    TYPE zcldobj_e_error_message,
           END OF ty_log,
           BEGIN OF ty_log_detail,
             step_name      TYPE zcldobj_e_step_name,
             step_status    TYPE zcldobj_e_status,
             step_error_msg TYPE zcldobj_e_error_message,
           END OF ty_log_detail.
    CLASS-METHODS:
      get_instance RETURNING VALUE(ro_instance) TYPE REF TO zcldobj_cl_log,
      convert_timestamp_w_time_zone IMPORTING iv_datetime       TYPE zcldobj_e_log_datetime OPTIONAL
                                              iv_time_zone_from LIKE sy-zonlo OPTIONAL
                                              iv_time_zone_to   LIKE sy-zonlo OPTIONAL
                                    EXPORTING ev_datetime       TYPE zcldobj_e_log_datetime
                                              ev_date           TYPE datum
                                              ev_time           TYPE uzeit.
    METHODS:
      constructor IMPORTING iv_logid TYPE sysuuid_x16 OPTIONAL,
      get_logid RETURNING VALUE(rv_logid) TYPE sysuuid_x16,
      add_log IMPORTING is_log TYPE ty_log,
      add_log_detail IMPORTING is_log_detail TYPE ty_log_detail,
      save_logs IMPORTING iv_behavior TYPE abap_boolean DEFAULT abap_false.
