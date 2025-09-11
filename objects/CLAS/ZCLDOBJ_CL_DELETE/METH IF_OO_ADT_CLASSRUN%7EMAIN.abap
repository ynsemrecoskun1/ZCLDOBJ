  METHOD if_oo_adt_classrun~main.

    DATA lv_tablo_adi TYPE string.
    DATA lv_where TYPE string.

*    DELETE FROM (lv_table) WHERE 1 = 1. tüm tablo için denenecek

    IF 1 = 2.
      DELETE FROM (lv_tablo_adi) WHERE (lv_where).
    ENDIF.

  ENDMETHOD.