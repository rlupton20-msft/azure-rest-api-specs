@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

// "Update source IP addresses in an enclave connection"
@doc("Request to the action call to set the source IP addresses on an enclave connection.")
model SetSourceCidrRequest {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("New source CIDR.")
  sourceCidr: string;
}
