  METHOD send_mail.
    TRY.

        DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

        lo_mail->set_sender( iv_address = iv_sender ).

        LOOP AT it_recipient INTO DATA(ls_recipient).
          lo_mail->add_recipient(
            iv_address = ls_recipient-recipient
            iv_copy    = cl_bcs_mail_message=>to
          ).
        ENDLOOP.

        LOOP AT it_recipient_cc INTO DATA(ls_recipient_cc).
          lo_mail->add_recipient(
            iv_address = ls_recipient_cc-recipient
            iv_copy    = cl_bcs_mail_message=>cc
          ).
        ENDLOOP.

        lo_mail->set_subject( iv_subject ).

        "
        IF iv_template_id IS INITIAL.
          lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
              iv_content      = iv_content
              iv_content_type = 'text/html' ) ).
        ELSE.
          DATA(lo_template) = cl_smtg_email_templ_renderer=>create_instance( iv_template_id ).

          lo_template->set_privileged_access( iv_privileged_access = abap_true ).

          lo_template->render_email_message(
            io_message  = lo_mail
            iv_language = iv_template_lang
            it_data_key = it_template_keys
          ).
        ENDIF.

        IF is_attachment-iv_content IS NOT INITIAL.
          lo_mail->add_attachment( cl_bcs_mail_binarypart=>create_instance(
                                     iv_content      = is_attachment-iv_content
                                     iv_content_type = is_attachment-iv_content_type
                                     iv_filename     = is_attachment-iv_filename
                                   )  ).
        ENDIF.

        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).



      CATCH cx_bcs_mail INTO DATA(lo_err).
        ev_error = lo_err->get_longtext( ).
      CATCH cx_root INTO DATA(lo_root).
        ev_error = lo_root->get_longtext( ).
    ENDTRY.

  ENDMETHOD.