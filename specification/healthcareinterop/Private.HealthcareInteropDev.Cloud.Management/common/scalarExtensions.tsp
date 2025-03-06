@doc("Storage account blob service endpoint")
@pattern(".+\\.blob\\.core\\.windows\\.net\\/")
scalar BlobServiceEndpoint extends url;

@doc("Key Vault URI")
@pattern(".+\\.vault\\.azure\\.net\\/")
scalar KeyVaultURI extends url;
