@doc("Update Mode Enum")
union UpdateMode {
  string,

  @doc("UpdateMode Type Automatic")
  Automatic: "Automatic",

  @doc("UpdateMode Type Manual")
  Manual: "Manual",
}

@doc("Update Mode Model")
model UpdateModeItem {
  @doc("Update mode.")
  updateMode: UpdateMode;
}
