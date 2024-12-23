import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@doc("Global Entry Domain Properties.")
model EntryLinkProperties extends BaseResourceProperties {
  @doc("The Id of the entry profile resource that the entry link is attached to.")
  @visibility("create", "read")
  entryProfileId: EntryProfileId;

  @doc("The Id of the entry region resource that the entry link is attached to.")
  @visibility("create", "read")
  entryRegionId: EntryRegionId;

  @doc("The ID of the IP address to use")
  @visibility("create", "read")
  publicIpAddressId: PublicIpAddressId;
}
