using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

@doc("GiVersion resource definition")
@parentResource(SubscriptionLocationResource)
model GiVersion is ProxyResource<GiVersionProperties> {
  @doc("GiVersion name")
  @key("giversionname")
  @path
  @segment("giVersions")
  @pattern(".*")
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@doc("GiVersion resource model")
model GiVersionProperties {
  @doc("A valid Oracle Grid Infrastructure (GI) software version.")
  @minLength(1)
  @maxLength(255)
  version: string;
}

@doc("Provides GiVersion query parameter for list operations.")
model GiVersionFilter {
  @query
  @doc("If provided, filters the results for the given shape")
  @minLength(1)
  @maxLength(255)
  shape?: string;
}

@added(Versions.v20241201_preview)
@doc("The Oracle Grid Infrastructure (GI) minor version resource definition.")
@parentResource(GiVersion)
model GiMinorVersion is ProxyResource<GiMinorVersionProperties> {
  ...ResourceNameParameter<GiMinorVersion>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Read-only resource. No provisioning state provided."
@added(Versions.v20241201_preview)
@doc("The Oracle Grid Infrastructure (GI) minor version properties")
model GiMinorVersionProperties {
  @doc("A valid Oracle Grid Infrastructure (GI) software version.")
  @minLength(1)
  @maxLength(255)
  version: string;

  @doc("Grid Infrastructure Image Id")
  @minLength(1)
  @maxLength(255)
  gridImageId?: string;
}

@added(Versions.v20241201_preview)
@doc("Provides GiMinorVersion query parameter for list operations.")
model GiMinorVersionFilter {
  @query
  @doc("If provided, filters the results to the set of database versions which are supported for the given shape family.")
  shapeFamily?: ShapeFamily;
}

@added(Versions.v20241201_preview)
@doc("DnNode provisioning state enum")
union ShapeFamily {
  @doc("Indicates single node shape family")
  SingleNode: "SingleNode",

  @doc("Indicates yoda shape family")
  Yoda: "Yoda",

  @doc("Indicates virtual machine shape family")
  VirtualMachine: "VirtualMachine",

  @doc("Indicates exadata shape family")
  Exadata: "Exadata",

  @doc("Indicates EXACC shape family")
  Exacc: "Exacc",

  @doc("indicates ExadbXS shape family")
  ExadbXs: "ExadbXs",

  string,
}
