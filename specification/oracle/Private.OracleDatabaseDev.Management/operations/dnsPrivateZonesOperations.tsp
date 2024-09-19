import "../../common/models/dnsPrivateZones.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DnsPrivateZones extends OracleLocationBasedResource<DnsPrivateZone> {}
