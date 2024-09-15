import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Private.Workloads;

@doc("Quality check execution layer enum")
union QualityCheckExecutionLayer {
  string,

  /**  The Azure Resource Manager*/
  AzureResourceManager: "AzureResourceManager",

  /** Execution at Azure OS level */
  OSLevel: "OSLevel",
}

/** QualityCheckTemplate properties */
model QualityCheckTemplateProperties {
  /** Unique Id assigned to template. */
  templateId?: string;

  /** Execution settings of quality check template. */
  executionSettings?: ExecutionSettings;

  /** Association of quality checks with virtual instances */
  associationWithVirtualInstances?: string[];

  /** Profile of QualityCheckTemplate */
  @OpenAPI.extension("x-ms-identifiers", [])
  qualityChecks: QualityChecks[];

  /** The resource provisioning state. */
  @doc("The resource provisioning state.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

 /** Execution settings of quality check template. */
model ExecutionSettings {
  /** The execution interval. */
  interval?: int32;
}

/** Profile of QualityCheckTemplate */
model QualityChecks {
  /** The quality check Id. */
  checkId: string;

  /** The quality check name. */
  checkName: string;

  /**Description of quality check. */
  description?: string;

  /** The quality check applicable on role types. */
  applyOnWorkloadRoleTypes: string[];

  /** The resource type on which quality check will be performed */
  resourceType: string;

  /**Supported OS Types for quality checks */
  supportedOsTypes: string[];

  /**The command settings. */
  command: Command;
}

/** Command settings */
model Command {
  /** The execution layer. */
  executionLayer: QualityCheckExecutionLayer;

  /** The query command. */
  queryCommand: string;

  /** The recommended value. */
  recommendedValue: string;

  /** The customized value */
  customizedValue?: string
}
