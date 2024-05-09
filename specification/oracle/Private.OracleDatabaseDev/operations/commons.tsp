import "../../common/operations/commons.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

using Azure.ResourceManager.Foundations;

namespace Private.OracleDatabaseDev;

@armResourceOperations(T)
interface OracleSubscriptionLevelResource<
  T extends ArmResource,
  TProperties extends TypeSpec.Reflection.Model
>
  extends ResourceListBySubscription<T>,
    ResourceCreateAsync<T>,
    ResourceRead<T>,
    ResourceUpdateAsync<T, TProperties>,
    ResourceDeleteWithoutOkAsync<T> {}

@armResourceOperations(T)
interface OracleTrackedResource<
  T extends ArmResource,
  TProperties extends TypeSpec.Reflection.Model
> extends OracleSubscriptionLevelResource<T, TProperties> {
  listByResourceGroup is ArmResourceListByParent<T>;
}

@armResourceOperations(T)
interface OracleReadOnlyResource<T extends ArmResource> {
  // TODO: Swagger generator bug, cannot be extracted to interface
  // listByParent is ArmResourceListByParent<T>;
  get is ArmResourceRead<T>;
}

@armResourceOperations(T)
interface OracleLocationBasedResource<T extends ArmResource>
  extends OracleReadOnlyResource<T> {
  listByLocation is ArmResourceListByParent<T>;
}

@armResourceOperations(T)
interface OracleChildResource<
  T extends ArmResource,
  TProperties extends TypeSpec.Reflection.Model
>
  extends ResourceCreateAsync<T>,
    ResourceRead<T>,
    ResourceDeleteWithoutOkAsync<T> {}
