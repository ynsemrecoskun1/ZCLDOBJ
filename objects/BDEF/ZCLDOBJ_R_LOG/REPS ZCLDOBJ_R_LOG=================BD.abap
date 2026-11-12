managed implementation in class zcldobj_bp_r_log unique;
strict ( 2 );

define behavior for ZCLDOBJ_R_LOG alias Log
persistent table zcldobj_a_log
lock master
authorization master ( instance )
{
  create;
  update;
  delete;

  field ( readonly : update ) LogId;

  mapping for zcldobj_a_log
  {
    LogId           = log_id;
    LogDatetime     = log_datetime;
    ServiceName     = service_name;
    ServiceType     = service_type;
    TriggerType     = trigger_type;
    RequestPayload  = request_payload;
    ResponsePayload = response_payload;
    Status          = status;
    ErrorMessage    = error_message;
    Duration        = duration;
  }

  association _Item { create; }
}

define behavior for ZCLDOBJ_I_LOGDET alias LogDetail
persistent table zcldobj_a_logdet
lock dependent by _Header
authorization dependent by _Header
{
  update;
  delete;

  field ( readonly : update ) LogId;
  field ( readonly : update ) DetailId;

  mapping for zcldobj_a_logdet
  {
    LogId         = log_id;
    DetailId      = detail_id;
    StepName      = step_name;
    StepDatetime  = step_datetime;
    StepStatus    = step_status;
    StepErrorMsg  = step_error_msg;
  }

  association _Header;
}