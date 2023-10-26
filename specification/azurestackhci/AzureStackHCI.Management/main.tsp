import "@typespec/rest";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "AzureStackHCI.Management",
  version: "2023-03-01",
})
@server(
  "{$host}",
  "Azure Stack HCI management service",
  {
    $host: string,
  }
)
@doc("Azure Stack HCI management service")
namespace Microsoft.AzureStackHCI;
