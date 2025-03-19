using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Private.OracleDatabaseDev;

// https://docs.oracle.com/en-us/iaas/api/#/en/dns/20180115/

@doc("DnsPrivateZone resource definition")
@parentResource(SubscriptionLocationResource)
model DnsPrivateZone is ProxyResource<DnsPrivateZoneProperties> {
  @doc("DnsPrivateZone name")
  @key("dnsprivatezonename")
  @path
  @segment("dnsPrivateZones")
  @pattern(".*")
  name: string;
}

@doc("Zones resource model")
model DnsPrivateZoneProperties {
  @doc("The OCID of the Zone")
  ocid: Ocid;

  @doc("A Boolean flag indicating whether or not parts of the resource are unable to be explicitly managed.")
  isProtected: boolean;

  @doc("Zones lifecycleState")
  lifecycleState: DnsPrivateZonesLifecycleState;

  @doc("The canonical absolute URL of the resource.")
  self: string;

  @doc("The current serial of the zone. As seen in the zone's SOA record.")
  serial: int32;

  @doc("Version is the never-repeating, totally-orderable, version of the zone, from which the serial field of the zone's SOA record is derived.")
  version: string;

  @doc("The OCID of the private view containing the zone. This value will be null for zones in the global DNS, which are publicly resolvable and not part of a private view.")
  viewId?: Ocid;

  @doc("The type of the zone. Must be either PRIMARY or SECONDARY. SECONDARY is only supported for GLOBAL zones.")
  zoneType: ZoneType;

  @doc("Zones timeCreated")
  timeCreated: utcDateTime;

  @doc("Azure resource provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("DnsPrivateZones lifecycle state enum")
union DnsPrivateZonesLifecycleState {
  @doc("Active value")
  Active: "Active",

  @doc("Creating value")
  Creating: "Creating",

  @doc("Deleted value")
  Deleted: "Deleted",

  @doc("Deleting value")
  Deleting: "Deleting",

  @doc("Updating value")
  Updating: "Updating",

  string,
}

@doc("ZoneType enum")
union ZoneType {
  @doc("Primary value")
  Primary: "Primary",

  @doc("Secondary value")
  Secondary: "Secondary",

  string,
}
