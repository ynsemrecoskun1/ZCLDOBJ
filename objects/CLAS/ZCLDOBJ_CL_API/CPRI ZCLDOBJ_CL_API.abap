  PRIVATE SECTION.
    CLASS-METHODS:
      walk_error_node IMPORTING ir_node     TYPE REF TO data
                      CHANGING  ct_messages TYPE tyt_message_items,

      text_of_node IMPORTING ir_node        TYPE REF TO data
                   RETURNING VALUE(rv_text) TYPE string,

      severity_from_numeric IMPORTING iv_numeric         TYPE string
                            RETURNING VALUE(rv_severity) TYPE string,

      enrich_message_item IMPORTING iv_longtext_url TYPE string OPTIONAL
                          CHANGING  cs_item         TYPE ty_message_item,

      url_key_value IMPORTING iv_url          TYPE string
                              iv_key          TYPE string
                    RETURNING VALUE(rv_value) TYPE string.