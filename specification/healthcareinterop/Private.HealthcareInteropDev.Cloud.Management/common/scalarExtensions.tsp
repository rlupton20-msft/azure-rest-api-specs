@doc("Storage account blob service endpoint")
@pattern(".+\\.blob\\.core\\.windows\\.net\\/")
scalar BlobServiceEndpoint extends url;

@doc("Key Vault URI")
@pattern(".+\\.vault\\.azure\\.net\\/")
scalar KeyVaultURI extends url;

@doc("Fabric host URI")
@pattern(".+\\.fabric\\.microsoft\\.com")
scalar FabricHostURI extends url;

@doc("Storage account container URI")
@pattern(".+\\.blob\\.core\\.windows\\.net\\/.+")
scalar StorageAccountContainerURI extends url;
