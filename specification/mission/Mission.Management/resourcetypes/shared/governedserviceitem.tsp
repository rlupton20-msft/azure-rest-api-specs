@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Identifier for governed services.")
union ServiceIdentifier {
  @doc("Service identifier for AKS")
  AKS: "AKS",

  @doc("Service identifier for App Service")
  AppService: "AppService",

  @doc("Service identifier for Azure Firewalls")
  AzureFirewalls: "AzureFirewalls",

  @doc("Service identifier for Container Registry")
  ContainerRegistry: "ContainerRegistry",

  @doc("Service identifier for CosmosDB")
  CosmosDB: "CosmosDB",

  @doc("Service identifier for Data Connectors")
  DataConnectors: "DataConnectors",

  @doc("Service identifier for Insights")
  Insights: "Insights",

  @doc("Service identifier for Key Vault")
  KeyVault: "KeyVault",

  @doc("Service identifier for Logic")
  Logic: "Logic",

  @doc("Service identifier for Microsoft SQL")
  MicrosoftSql: "MicrosoftSQL",

  @doc("Service identifier for Monitoring")
  Monitoring: "Monitoring",

  @doc("Service identifier for PostgreSQL")
  PostgreSql: "PostgreSQL",

  @doc("Service identifier for Private DNS Zones")
  PrivateDNSZones: "PrivateDNSZones",

  @doc("Service identifier for Service Bus")
  ServiceBus: "ServiceBus",

  @doc("Service identifier for Storage")
  Storage: "Storage",

  string,
}

@doc("GovernedServiceItem Properties")
model GovernedServiceItem {
  @doc("service id")
  id: ServiceIdentifier;

  @doc("service name")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("governance option for this service (Allow, Deny, ExceptionOnly, or NotApplicable).")
  option?: "Allow" | "Deny" | "ExceptionOnly" | "NotApplicable" | string;

  @doc("initiative enforcement (Enabled or Disabled).")
  enforcement?: "Enabled" | "Disabled" | string;

  @doc("policies set to auditOnly (True or False).")
  auditOnly?: boolean;

  @doc("initiatives associated with this service")
  @visibility(Lifecycle.Read)
  initiatives?: string[];
}
