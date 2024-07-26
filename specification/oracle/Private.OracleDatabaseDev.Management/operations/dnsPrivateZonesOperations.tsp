import "../../common/models/dnsPrivateZones.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DnsPrivateZones extends OracleLocationBasedResource<DnsPrivateZone> {}

@@Autorest.example(DnsPrivateZones.listByLocation,
  "./examples/dnsPrivateZones_listByLocation.json",
  "List DnsPrivateZones by location"
);
@@Autorest.example(DnsPrivateZones.get,
  "./examples/dnsPrivateZones_get.json",
  "Get a DnsPrivateZone by name"
);
