import "../../common/models/dnsPrivateViews.tsp";

using Azure.ResourceManager;
using Autorest;

namespace Private.OracleDatabaseDev;

@armResourceOperations
interface DnsPrivateViews extends OracleLocationBasedResource<DnsPrivateView> {}
