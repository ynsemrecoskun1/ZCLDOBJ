CLASS zcldobj_cl_parameter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS: get_param_value IMPORTING iv_param        TYPE zcldobj_a_param-pname
                                   RETURNING VALUE(rv_value) TYPE zcldobj_a_param-value.