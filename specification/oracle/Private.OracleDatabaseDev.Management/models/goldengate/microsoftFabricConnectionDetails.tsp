import "./connection.tsp";

using TypeSpec.Versioning;

namespace Private.OracleDatabaseDev;

// https://docs.oracle.com/en-us/iaas/api/#/en/goldengate/20200407/datatypes/CreateMicrosoftFabricConnectionDetails

@added(Versions.v20251001_preview)
@doc("Allowed values for Microsoft Fabric technology type.")
union MicrosoftFabricConnectionTechnologyType {
  @doc("The Microsoft Fabric Lakehouse type.")
  MicrosoftFabricLakehouse: "MICROSOFT_FABRIC_LAKEHOUSE",

  @doc("The Microsoft Fabric Mirror type.")
  MicrosoftFabricMirror: "MICROSOFT_FABRIC_MIRROR",

  string,
}

@added(Versions.v20251001_preview)
@doc("The metadata of a Microsoft Fabric Connection.")
model MicrosoftFabricConnectionDetails extends ConnectionBaseProperties {
  connectionType: ConnectionType.MicrosoftFabric;

  @doc("The Microsoft Fabric technology type.")
  technologyType: MicrosoftFabricConnectionTechnologyType;

  @doc("Azure tenant ID of the application.")
  @minLength(1)
  @maxLength(36)
  tenantId: string;

  @doc("Azure client ID of the application.")
  @minLength(1)
  @maxLength(36)
  clientId: string;

  #deprecated "replaced by `clientSecretSecretId`"
  @doc("Client secret associated with the client id.")
  @minLength(1)
  @maxLength(65536)
  clientSecret?: Password;

  @doc("The OCID of the Secret where the client secret is stored.")
  clientSecretSecretId?: Ocid;

  @doc("The Microsoft Fabric service endpoint.")
  @minLength(0)
  @maxLength(261)
  endpoint?: string;
}
