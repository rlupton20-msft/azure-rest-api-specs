import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Private.SecretSyncController;

@@clientName(Private.SecretSyncController,
  "SecretsStoreExtensionMgmt",
  "python"
);
@@clientName(Private.SecretSyncController,
  "SecretsStoreExtensionMgmtClient",
  "java"
);
@@clientName(Private.SecretSyncController,
  "SecretsStoreExtensionManagementClient",
  "javascript"
);

// CSharp
@@clientName(AzureKeyVaultSecretProviderClass,
  "KeyVaultSecretProviderClass",
  "csharp"
);
@@clientName(AzureKeyVaultSecretProviderClassProperties,
  "KeyVaultSecretProviderClassProperties",
  "csharp"
);
@@clientName(ProvisioningState,
  "SecretsStoreExtensionProvisioningState",
  "csharp"
);
@@clientName(StatusConditionType, "SecretSyncConditionStatusType", "csharp");
@@alternateType(AzureKeyVaultSecretProviderClassProperties.clientId,
  uuid,
  "csharp"
);
@@alternateType(AzureKeyVaultSecretProviderClassProperties.tenantId,
  uuid,
  "csharp"
);
