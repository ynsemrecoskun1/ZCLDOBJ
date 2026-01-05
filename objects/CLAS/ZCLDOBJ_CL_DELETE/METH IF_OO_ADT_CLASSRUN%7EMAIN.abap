  METHOD if_oo_adt_classrun~main.

    DATA lv_tablo_adi TYPE string.
    DATA lv_where TYPE string.
    DATA lv_set TYPE string.

*    DELETE FROM (lv_table) WHERE 1 = 1. tüm tablo için denenecek

    IF 1 = 2.
      DELETE FROM (lv_tablo_adi) WHERE (lv_where).
    ENDIF.

    IF 1 = 2.
      UPDATE (lv_tablo_adi) SET (lv_set) WHERE (lv_where).
    ENDIF.

    IF 1 = 2.

      DATA: lv_tabname TYPE string VALUE 'ZMY_TABLE',
            ls_data    TYPE REF TO data.

      CREATE DATA ls_data TYPE (lv_tabname).
      ASSIGN ls_data->* TO FIELD-SYMBOL(<fs_data>).

      INSERT (lv_tabname) FROM @<fs_data>.

    ENDIF.

  ENDMETHOD.