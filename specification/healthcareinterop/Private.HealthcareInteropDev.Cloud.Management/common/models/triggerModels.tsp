@doc("Recurrence based trigger configuration")
@discriminator("triggerType")
model RecurrenceTriggerProperties {
  @doc("The type of trigger.")
  triggerType: RecurrenceTriggerType;

  @doc("The state of the trigger.")
  state: TriggerState;
}

@doc("The trigger type.")
union RecurrenceTriggerType {
  string,

  @doc("The schedule trigger type.")
  ScheduleTrigger: "ScheduleTrigger",
}

@doc("The schedule based recurrence trigger configuration.")
model ScheduleRecurrenceTriggerConfiguration
  extends RecurrenceTriggerProperties {
  @doc("The type of trigger.")
  triggerType: RecurrenceTriggerType.ScheduleTrigger;

  @doc("Optional input to specify the start date time of the trigger in UTC timezone. By default, the trigger will start once the resource is successfully provisioned.")
  startDateTimeUtc?: utcDateTime;

  @doc("Optional input to specify the recurrence configuration for the schedule indicating the hours the schedule should run on. By default, the schedule will run at all hours.")
  activeHours?: Array<int32>;

  @doc("Optional input to specify the recurrence configuration for the schedule indicating the days the schedule should run on. By default, the schedule will run on all days.")
  activeDays?: Array<int32>;
}

@doc("The trigger state.")
union TriggerState {
  string,

  @doc("The trigger is enabled.")
  Enabled: "Enabled",

  @doc("The trigger is disabled.")
  Disabled: "Disabled",
}

@doc("OneTime based trigger configuration")
@discriminator("triggerType")
model OneTimeTriggerProperties {
  @doc("The type of trigger.")
  triggerType: OneTimeTriggerType;

  @doc("The state of the trigger.")
  state: TriggerState;
}

@doc("The trigger type.")
union OneTimeTriggerType {
  string,

  @doc("The adhoc trigger type.")
  AdhocTrigger: "AdhocTrigger",
}

@doc("The adhoc based trigger configuration.")
model AdhocTriggerConfiguration extends OneTimeTriggerProperties {
  @doc("The type of trigger.")
  triggerType: OneTimeTriggerType.AdhocTrigger;

  @doc("Optional input to specify the start date time of the trigger in UTC timezone. By default, the trigger will start once the resource is successfully provisioned.")
  startDateTimeUtc?: utcDateTime;
}
