CLASS zcldobj_cl_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_param,
             name  TYPE zcldobj_a_param-pname,
             value TYPE zcldobj_a_param-value,
           END OF ty_param,
           tt_param TYPE TABLE OF ty_param WITH EMPTY KEY.

    CLASS-METHODS: get_param_value IMPORTING iv_param        TYPE zcldobj_a_param-pname
                                   RETURNING VALUE(rv_value) TYPE zcldobj_a_param-value.

    CLASS-METHODS: get_params_value CHANGING ct_params TYPE tt_param.