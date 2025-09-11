CLASS zcldobj_cl_ballog DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: mo_log TYPE REF TO if_bali_log.

    METHODS: constructor IMPORTING iv_object    TYPE balobj_d
                                   iv_subobject TYPE balsubobj,

      add_freetext IMPORTING
                     severity TYPE symsgty DEFAULT if_bali_constants=>c_severity_status
                     iv_text  TYPE if_bali_free_text_setter=>ty_text,

      add_bapiret2 IMPORTING is_bapiret2 TYPE bapiret2,

      add_message IMPORTING
                    severity    TYPE symsgty DEFAULT if_bali_constants=>c_severity_status
                    id          TYPE if_bali_message_setter=>ty_id
                    number      TYPE if_bali_message_setter=>ty_number
                    !variable_1 TYPE if_bali_message_setter=>ty_variable OPTIONAL
                    !variable_2 TYPE if_bali_message_setter=>ty_variable OPTIONAL
                    !variable_3 TYPE if_bali_message_setter=>ty_variable OPTIONAL
                    !variable_4 TYPE if_bali_message_setter=>ty_variable OPTIONAL,

      save_log RETURNING VALUE(rv_result) TYPE if_bali_log=>ty_handle,

      read_messages IMPORTING iv_handle   TYPE if_bali_log=>ty_handle
                    EXPORTING et_messages TYPE if_bali_log=>ty_item_table.
