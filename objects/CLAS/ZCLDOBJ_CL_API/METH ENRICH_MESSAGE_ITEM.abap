  METHOD enrich_message_item.
    " Kod "MESAJSINIFI/NUMARA" biçimindeyse ayır (ad alanlı sınıflarda son "/" ayırıcıdır)
    IF cs_item-code IS NOT INITIAL AND matches( val = cs_item-code pcre = `.+/\d{3}` ).
      DATA(lv_pos) = find( val = cs_item-code sub = `/` occ = -1 ).
      cs_item-msgid = substring( val = cs_item-code len = lv_pos ).
      cs_item-msgno = substring( val = cs_item-code off = lv_pos + 1 ).
    ENDIF.

    " V4: uzun metni olan mesajlarda longtextUrl sınıf, numara ve değişkenleri taşır
    IF iv_longtext_url IS NOT INITIAL.
      DATA(lv_class)  = url_key_value( iv_url = iv_longtext_url iv_key = `MessageClass` ).
      DATA(lv_number) = url_key_value( iv_url = iv_longtext_url iv_key = `MessageNumber` ).
      IF lv_class IS NOT INITIAL.
        cs_item-msgid = lv_class.
      ENDIF.
      IF lv_number IS NOT INITIAL.
        cs_item-msgno = lv_number.
      ENDIF.
      cs_item-msgv1 = url_key_value( iv_url = iv_longtext_url iv_key = `Variable1` ).
      cs_item-msgv2 = url_key_value( iv_url = iv_longtext_url iv_key = `Variable2` ).
      cs_item-msgv3 = url_key_value( iv_url = iv_longtext_url iv_key = `Variable3` ).
      cs_item-msgv4 = url_key_value( iv_url = iv_longtext_url iv_key = `Variable4` ).
    ENDIF.
  ENDMETHOD.