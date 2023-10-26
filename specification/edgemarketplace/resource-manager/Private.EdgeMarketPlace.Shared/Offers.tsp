import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "EdgeMarketPlaceClient",
  version: "2023-04-01-preview",
})
@doc("Edge Market Place Resource Provider management API.")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Private.EdgeMarketPlace;

@doc("An offer.")
model Offer is ExtensionResource<OfferProperties> {
  @doc("Id of the offer")
  @format("^[a-zA-Z0-9-]{3,24}$")
  @key("OfferId")
  @path
  @segment("offers")
  name: string;
}

model OfferProperties {
    @doc("The content version")
	contentVersion: string;
	
	@doc("The content url")
	contentURL: string;
	
	offerContent: OfferContent;

}

model OfferContent
{
	@doc("The display name of the offer")
	displayName: string; 
		
	@doc("The summary")
    summary: string;
		 
    @doc("The long summary")
    longSummary: string;  
		 
    @doc("The description")
    description: string;  
		 
    @doc("The offer id")
    offerId: string;  

	@doc("The offer type")
    offerType: string;
		 
	@doc("The support uri")
	supportUri: string;  

	@doc("The popularity of the offer")
    popularity : integer;   
	
	@doc("The publisher of the offer")
    offerPublisher : OfferPublisher; 

	@doc("The availability of the offer")
	availability:OfferAvailability;
	
	@doc("The release type of the offer")
	releaseType:OfferReleaseType;
	
	@doc("The terms and conditions of the offer")
	termsAndConditions:TermsAndConditions;
	
	@doc("The icon files")
	iconFileUris:IconFileUris;
	
}

enum OfferAvailability {
  Private,
  Public
}

enum OfferReleaseType {
  Preview,
  GA
}

model TermsAndConditions
{
	@doc("The legal terms and conditions uri")
	legalTermsUri:string;
	
	@doc("The type of legal terms")
	legalTermsType: string;
	
	@doc("The privacy policy uri")
	privacyPolicyUri: string;
}	

model OfferPublisher
{
	@doc("The publisher Id")
	publisherId:string;
	
	@doc("The publisher name")
	publisherDisplayName: string;
}	

model IconFileUris
{
	@doc("uri of small icon")
	small:string;
	
	@doc("uri of medium icon")
	medium: string;
	
	@doc("uri of wide icon")
	wide: string;
		
	@doc("uri of large icon")
	large: string;
}	

model MarketplaceSku
{
	@doc("The catalog plan id")
	catalogPlanId:string;
	
	@doc("The marketplace sku id")
	marketplaceSkuId: string;
	
	@doc("The type of marketplace sku")
	type: string;
		
	@doc("The display name of marketplace sku")
	displayName: string;
	
	@doc("The summary")
	summary:string;
	
	@doc("The long summary")
	longSummary: string;
	
	@doc("The description")
	description: string;
	
	@doc("The operating system supported")
	operatingSystem: SKUOperatingSystem;

}	

model MarketplaceSkuVersion
{
	@doc("The name of sku version")
	Name:string;
	
	@doc("The size of the image")
	SizeOnDiskInMB: integer;
	
	@doc("The size of the download")
	MinimumDownloadSizeInMB: integer;
	
	@doc("The stage name")
	StageName: string;	
}

model SKUOperatingSystem
{
	@doc("The family of the operating system")
	family:string;
	
	@doc("The type of the operating system")
	type: string;
	
	@doc("The name of the operating system")
	name: string;
}



@armResourceOperations
interface offers
{
  list is ArmResourceListByParent<Offer>;
  get is ArmResourceRead<Offer>;
}