import "@typespec/openapi";

import "../common/CommonModels.tsp";

using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Routing information properties")
model RoutingInfoPropertiesFormat {
  @doc("A list of IPv4 routes.")
  @extension("x-ms-identifiers", ["destination"])
  controlPlaneAccessRoutes?: Ipv4Route[];

  @doc("A list of IPv4 routes.")
  @extension("x-ms-identifiers", ["destination"])
  userPlaneAccessRoutes?: Ipv4Route[];

  @doc("A list of attached data networks and their IPv4 routes.")
  @extension("x-ms-identifiers", ["/attachedDataNetwork/id"])
  userPlaneDataRoutes?: UserPlaneDataRoutesItem[];
}

@doc("An IPv4 route.")
model Ipv4Route {
  @doc("The destination IPv4 prefix.")
  destination?: Ipv4AddrMask;

  @doc("A list of next hops for the destination.")
  @extension("x-ms-identifiers", ["address"])
  nextHops?: Ipv4RouteNextHop[];
}

@doc("The next hop in an IPv4 route.")
model Ipv4RouteNextHop {
  @doc("The next hop address.")
  address?: Ipv4Addr;

  @doc("The priority of this next hop. Next hops with lower preference values are preferred.")
  priority?: int32;
}

@doc("Attached data networks and their IPv4 routes.")
model UserPlaneDataRoutesItem {
  @doc("Reference to an attached data network resource.")
  attachedDataNetwork?: AttachedDataNetworkResourceId;

  @doc("A list of IPv4 routes.")
  @extension("x-ms-identifiers", ["destination"])
  routes?: Ipv4Route[];
}
