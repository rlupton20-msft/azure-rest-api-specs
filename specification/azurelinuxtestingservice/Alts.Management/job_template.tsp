namespace Private.AltsTest;

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@doc("A template defining the parameters for a test job.")
model JobTemplate is TrackedResource<JobTemplateResourceProperties> {
  @doc("Job template name")
  @pattern("^[a-zA-Z0-9-_]{3,60}$")
  @key("jobTemplateName")
  @segment("jobTemplates")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@doc("The job template properties")
model JobTemplateResourceProperties is ResourceProperties {
  @doc("Tags used to organized templates.")
  templateTags?: string[] = #[];

  @doc("Azure region to run test in.")
  region?: string[] = #[];

  @doc("VM sizes to run test on.")
  vmSize?: string[] = #[];

  @doc("Test Selections. Default is to run the smoke_test case")
  @OpenAPI.extension("x-ms-identifiers", #[])
  selections?: Selections[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "customParameters requires a Record<string> for backward compatibility"
  @doc("Custom parameters for different test cases")
  customParameters?: Record<string>;

  @doc("The number of concurrent environments. Default is 4.")
  concurrency?: int32 = 4;
}

@doc("Action to take on a particular test case")
union TestCaseAction {
  @doc("Include test case")
  include: "include",

  @doc("Exclude test case")
  exclude: "exclude",

  @doc("Force include test case")
  forceInclude: "forceInclude",

  @doc("Force exclude test case")
  forceExclude: "forceExclude",

  @doc("Custom action as a string")
  string,
}

@minValue(0)
@maxValue(4)
scalar CasePriorityLevel extends int32;

@doc("Details test case criteria")
model Selections {
  @doc("Test case name. Default is empty.")
  caseName?: string[] = #[];

  @doc("Test case area. Default is empty.")
  caseArea?: string[] = #[];

  @doc("Test case category. Default is empty.")
  caseCategory?: string[] = #[];

  @doc("Test case priority. Default is empty and represents all priorities. Valid values are from 0-4")
  casePriority?: CasePriorityLevel[] = #[];

  @doc("Test case tags. Default empty")
  caseTags?: string[] = #[];

  @doc("Action to take. Default is include")
  action?: TestCaseAction = TestCaseAction.include;

  @doc("Test iterations to run. Default 1")
  testIterations?: int32 = 1;

  @doc("Retry on failure. Default 0")
  retryCount?: int32 = 0;

  @doc("Use new environment for each test case. Default false")
  useNewEnvironment?: boolean = false;

  @doc("Ignore failed test cases. Default false")
  ignoreFailure?: boolean = false;
}

/**
 * Represents the updateable properties of a Job Template.
 */
model JobTemplatePatch {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** RP-specific properties */
  properties?: JobTemplatePatchProperties;
}

/**
 * Properties model for patch operations without default values,
 * defaults are prohibited for PATCH operations
 */
@doc("The job template properties for PATCH operations without default values")
model JobTemplatePatchProperties {
  @doc("Tags used to organized templates.")
  templateTags?: string[];

  @doc("Azure region to run test in.")
  region?: string[];

  @doc("VM sizes to run test on.")
  vmSize?: string[];

  @doc("Test Selections without defaults")
  @OpenAPI.extension("x-ms-identifiers", #[])
  selections?: SelectionsPatch[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "customParameters requires a Record<string> for backward compatibility"
  @doc("Custom parameters for different test cases")
  customParameters?: Record<string>;

  @doc("The number of concurrent environments.")
  concurrency?: int32;
}

@doc("Details test case criteria for PATCH operations (without default values)")
model SelectionsPatch {
  @doc("Test case name.")
  caseName?: string[];

  @doc("Test case area.")
  caseArea?: string[];

  @doc("Test case category.")
  caseCategory?: string[];

  @doc("Test case priority. Valid values are from 0-4")
  casePriority?: CasePriorityLevel[];

  @doc("Test case tags.")
  caseTags?: string[];

  @doc("Action to take.")
  action?: TestCaseAction;

  @doc("Test iterations to run.")
  testIterations?: int32;

  @doc("Retry on failure.")
  retryCount?: int32;

  @doc("Use new environment for each test case.")
  useNewEnvironment?: boolean;

  @doc("Ignore failed test cases.")
  ignoreFailure?: boolean;
}

@doc("JobTemplate operations.")
@armResourceOperations(JobTemplate)
interface JobTemplates {
  listByResourceGroup is ArmResourceListByParent<JobTemplate>;
  listbySubscription is ArmListBySubscription<JobTemplate>;
  get is ArmResourceRead<JobTemplate>;
  createOrUpdate is ArmResourceCreateOrReplaceSync<JobTemplate>;
  update is ArmCustomPatchSync<JobTemplate, JobTemplatePatch>;
  delete is ArmResourceDeleteSync<JobTemplate>;
}
