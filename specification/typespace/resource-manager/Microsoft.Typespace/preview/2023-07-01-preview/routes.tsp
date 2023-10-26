import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.TypeSpace;

@armResourceOperations
interface Namespaces {
    get is ArmResourceRead<NameSpace>;
    put is ArmResourceCreateOrUpdateSync<NameSpace>;
    delete is ArmResourceDeleteSync<NameSpace>;
}

@armResourceOperations
interface ResourceTypes {
    get is ArmResourceRead<Type>;
    put is ArmResourceCreateOrUpdateSync<Type>;
    delete is ArmResourceDeleteSync<Type>;
}

@armResourceOperations
interface TypeApiVersions {
    get is ArmResourceRead<Version>;
    put is ArmResourceCreateOrUpdateSync<Version>;
    delete is ArmResourceDeleteSync<Version>;
}

@armResourceOperations
interface Annotations {
    get is ArmResourceRead<Annotation>;
    put is ArmResourceCreateOrUpdateSync<Annotation>;
    delete is ArmResourceDeleteSync<Annotation>;
}

@armResourceOperations
interface VersionOperations {
    get is ArmResourceRead<Operation>;
    put is ArmResourceCreateOrUpdateSync<Operation>;
    delete is ArmResourceDeleteSync<Operation>;
}
