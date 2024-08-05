import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Private.Edge;

@doc("Usecase enum")
union Usecase {
  string,

  @doc("Provisioning (ZTP) ")
  Provisioning: "Provisioning",
}
