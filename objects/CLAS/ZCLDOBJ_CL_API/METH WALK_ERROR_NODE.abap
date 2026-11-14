  METHOD walk_error_node.
    IF ir_node IS NOT BOUND.
      RETURN.
    ENDIF.

    ASSIGN ir_node->* TO FIELD-SYMBOL(<node>).
    DATA(lo_descr) = cl_abap_typedescr=>describe_by_data( <node> ).

    CASE lo_descr->kind.
      WHEN cl_abap_typedescr=>kind_struct.
        DATA(lt_components) = CAST cl_abap_structdescr( lo_descr )->get_components( ).
        DATA(ls_item) = VALUE ty_message_item( ).
        DATA(lv_longtext_url) = VALUE string( ).

        LOOP AT lt_components INTO DATA(ls_component).
          ASSIGN COMPONENT ls_component-name OF STRUCTURE <node> TO FIELD-SYMBOL(<child>).
          IF sy-subrc <> 0
             OR cl_abap_typedescr=>describe_by_data( <child> )->type_kind <> cl_abap_typedescr=>typekind_dref.
            CONTINUE.
          ENDIF.

          CASE ls_component-name.
            WHEN 'MESSAGE'.
              ls_item-message = text_of_node( <child> ).
            WHEN 'CODE'.
              ls_item-code = text_of_node( <child> ).
            WHEN 'SEVERITY'.
              ls_item-severity = to_lower( text_of_node( <child> ) ).
            WHEN OTHERS.
              IF ls_component-name CS 'NUMERICSEVERITY'.
                ls_item-severity = severity_from_numeric( text_of_node( <child> ) ).
              ELSEIF ls_component-name CS 'LONGTEXTURL'.
                lv_longtext_url = text_of_node( <child> ).
              ENDIF.
          ENDCASE.
        ENDLOOP.

        IF ls_item-message IS NOT INITIAL.
          enrich_message_item( EXPORTING iv_longtext_url = lv_longtext_url
                               CHANGING  cs_item         = ls_item ).
          APPEND ls_item TO ct_messages.
        ENDIF.

        LOOP AT lt_components INTO ls_component.
          ASSIGN COMPONENT ls_component-name OF STRUCTURE <node> TO <child>.
          IF sy-subrc = 0
             AND cl_abap_typedescr=>describe_by_data( <child> )->type_kind = cl_abap_typedescr=>typekind_dref.
            walk_error_node( EXPORTING ir_node = <child> CHANGING ct_messages = ct_messages ).
          ENDIF.
        ENDLOOP.

      WHEN cl_abap_typedescr=>kind_table.
        FIELD-SYMBOLS <table> TYPE ANY TABLE.
        ASSIGN <node> TO <table>.
        LOOP AT <table> ASSIGNING FIELD-SYMBOL(<row>).
          IF cl_abap_typedescr=>describe_by_data( <row> )->type_kind = cl_abap_typedescr=>typekind_dref.
            walk_error_node( EXPORTING ir_node = <row> CHANGING ct_messages = ct_messages ).
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.