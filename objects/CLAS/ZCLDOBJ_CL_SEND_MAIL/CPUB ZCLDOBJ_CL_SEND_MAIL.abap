CLASS zcldobj_cl_send_mail DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_attachment,
             iv_content      TYPE xstring,
             iv_content_type TYPE cl_bcs_mail_bodypart=>ty_content_type,
             iv_filename     TYPE string,
           END OF ty_attachment.

    TYPES: BEGIN OF ty_recipient,
             recipient TYPE cl_bcs_mail_message=>ty_address,
           END OF ty_recipient,
           tt_recipient TYPE TABLE OF ty_recipient.

    CLASS-METHODS: send_mail IMPORTING it_recipient     TYPE tt_recipient
                                       it_recipient_cc  TYPE tt_recipient OPTIONAL
                                       iv_sender        TYPE cl_bcs_mail_message=>ty_address
                                       iv_subject       TYPE cl_bcs_mail_message=>ty_subject
                                       iv_content       TYPE string OPTIONAL
                                       is_attachment    TYPE ty_attachment OPTIONAL
                                       iv_template_id   TYPE if_smtg_email_templ_renderer=>ty_email_template_id OPTIONAL "if a schema will be used through the “Maintain Email Templates” application
                                       iv_template_lang TYPE spras OPTIONAL "if a schema will be used through the “Maintain Email Templates” application
                                       it_template_keys TYPE if_smtg_email_templ_renderer=>tyt_template_keys OPTIONAL "if a schema will be used through the “Maintain Email Templates” application
                             EXPORTING ev_error         TYPE string
                             RAISING
                                       cx_smtg_email_common.