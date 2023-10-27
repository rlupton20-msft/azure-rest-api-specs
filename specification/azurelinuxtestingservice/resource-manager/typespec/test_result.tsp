namespace Microsoft.AzureLinuxTestingService;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Autorest;
using Azure.Core;
using Azure.Core.Foundations;
using OpenAPI;

@doc("The test results for a job")
@parentResource(Job)
model TestResult is ProxyResource<TestResultProperties> {
    @doc("Test results from a job")
    @key("testResult")
    @segment("testResults")
    @visibility("read")
    @path()
    name: string;
}

@doc("Test results for a particular test case")
model TestResultProperties is ResourceProperties {
    @doc("The test result ID")
    resultId?: string; 

    @doc("The test name")
    testName?: string;

    @doc("The test category")
    testCategory?: string;

    @doc("The test area")
    testArea?: string;

    @doc("The test priority")
    testPriority?: integer;

    @doc("The test status")
    status?: string;

    @doc("Test details")
    message?: string;

    @doc("Log URL")
    logUrl?: string;

    @doc("Image name source string")
    image?: string;

    @doc("VM Size used")
    vmSize?: string;

    @doc("Region test ran")
    location?: string;

    @doc("Kernel version used")
    kernelVersion?: string;

    @doc("Distro version used")
    distroVersion?: string;

    @doc("VHD Generation")
    vhdGeneration?: integer;

    @doc("Wala Version")
    walaVersion?: string;

    @doc("Extra fields")
    extraFields?: Record<string>;

    @doc("Test duration")
    duration?: string;

    @doc("Start time")
    startTime?: string;

    @doc("End time")
    endTime?: string;
}


@doc("Test result operations")
@armResourceOperations(TestResult)
interface TestResults {
    get is ArmResourceRead<TestResult>;
    listByResourceGroup is ArmResourceListByParent<TestResult>;
    listbySubscription is ArmListBySubscription<TestResult>;

}