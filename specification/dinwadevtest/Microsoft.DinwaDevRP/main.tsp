import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Versioning;

@versioned(Versions)
@service({
  title: "Widget Service",
})
namespace DemoService;

enum Versions {
  v2021_10_01_preview: "2021-10-01-preview",
  v2021_10_02_preview: "2021-10-02-preview",
}

using TypeSpec.Http;
using TypeSpec.Rest;

/** The Widget */
model Widget {
  /** The weight */
  weight: int32;

  /** The color */
  color: "red";

  /** The name */
  @added(Versions.v2021_10_02_preview) name: string;
}

/** The Error */
@error
model Error {
  /** The error code */
  code: int32;

  /** The error message */
  message: string;
}
