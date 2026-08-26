//===----------------------------------------------------------------------===//
//
// This source file is part of the swift-stripe open source project
//
// Copyright (c) 2026 the swift-stripe project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
// See NOTICE for attribution of derived work
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

extension Transaction {
    public enum CreateForceCapture {}
    public enum CreateUnlinkedRefund {}
    public enum List {}
    public enum Refund {}
    public enum Retrieve {}
    public enum Update {}
}

// POST /v1/test_helpers/issuing/transactions/create_force_capture
extension Transaction.CreateForceCapture {
    public struct Request: Codable, Hashable, Sendable {
        /// The total amount to attempt to capture.
        public var amount: Int
        /// Card associated with this transaction.
        public var card: String
        /// The currency of the capture.
        public var currency: Stripe.Currency?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Details about the seller (grocery store, e-commerce website, etc.
        public var merchantData: MerchantData?
        /// Additional purchase information that is optionally provided by the merchant.
        public var purchaseDetails: PurchaseDetails?

        public init(
            amount: Int,
            card: String,
            currency: Stripe.Currency? = nil,
            expand: [String]? = nil,
            merchantData: MerchantData? = nil,
            purchaseDetails: PurchaseDetails? = nil
        ) {
            self.amount = amount
            self.card = card
            self.currency = currency
            self.expand = expand
            self.merchantData = merchantData
            self.purchaseDetails = purchaseDetails
        }

        /// Details about the seller (grocery store, e-commerce website, etc.
        public struct MerchantData: Codable, Hashable, Sendable {
            /// A categorization of the seller's type of business.
            public var category: Category?
            /// City where the seller is located.
            public var city: String?
            /// Country where the seller is located.
            public var country: String?
            /// Name of the seller.
            public var name: String?
            /// Identifier assigned to the seller by the card network.
            public var networkId: String?
            /// Postal code where the seller is located.
            public var postalCode: String?
            /// State where the seller is located.
            public var state: String?
            /// An ID assigned by the seller to the location of the sale.
            public var terminalId: String?
            /// URL provided by the merchant on a 3DS request.
            public var url: String?

            public init(
                category: Category? = nil,
                city: String? = nil,
                country: String? = nil,
                name: String? = nil,
                networkId: String? = nil,
                postalCode: String? = nil,
                state: String? = nil,
                terminalId: String? = nil,
                url: String? = nil
            ) {
                self.category = category
                self.city = city
                self.country = country
                self.name = name
                self.networkId = networkId
                self.postalCode = postalCode
                self.state = state
                self.terminalId = terminalId
                self.url = url
            }

            public enum Category: String, Codable, Hashable, Sendable {
                case acRefrigerationRepair = "ac_refrigeration_repair"
                case accountingBookkeepingServices = "accounting_bookkeeping_services"
                case advertisingServices = "advertising_services"
                case agriculturalCooperative = "agricultural_cooperative"
                case airlinesAirCarriers = "airlines_air_carriers"
                case airportsFlyingFields = "airports_flying_fields"
                case ambulanceServices = "ambulance_services"
                case amusementParksCarnivals = "amusement_parks_carnivals"
                case antiqueReproductions = "antique_reproductions"
                case antiqueShops = "antique_shops"
                case aquariums
                case architecturalSurveyingServices = "architectural_surveying_services"
                case artDealersAndGalleries = "art_dealers_and_galleries"
                case artistsSupplyAndCraftShops = "artists_supply_and_craft_shops"
                case autoAndHomeSupplyStores = "auto_and_home_supply_stores"
                case autoBodyRepairShops = "auto_body_repair_shops"
                case autoPaintShops = "auto_paint_shops"
                case autoServiceShops = "auto_service_shops"
                case automatedCashDisburse = "automated_cash_disburse"
                case automatedFuelDispensers = "automated_fuel_dispensers"
                case automobileAssociations = "automobile_associations"
                case automotivePartsAndAccessoriesStores = "automotive_parts_and_accessories_stores"
                case automotiveTireStores = "automotive_tire_stores"
                case bailAndBondPayments = "bail_and_bond_payments"
                case bakeries
                case bandsOrchestras = "bands_orchestras"
                case barberAndBeautyShops = "barber_and_beauty_shops"
                case bettingCasinoGambling = "betting_casino_gambling"
                case bicycleShops = "bicycle_shops"
                case billiardPoolEstablishments = "billiard_pool_establishments"
                case boatDealers = "boat_dealers"
                case boatRentalsAndLeases = "boat_rentals_and_leases"
                case bookStores = "book_stores"
                case booksPeriodicalsAndNewspapers = "books_periodicals_and_newspapers"
                case bowlingAlleys = "bowling_alleys"
                case busLines = "bus_lines"
                case businessSecretarialSchools = "business_secretarial_schools"
                case buyingShoppingServices = "buying_shopping_services"
                case cableSatelliteAndOtherPayTelevisionAndRadio = "cable_satellite_and_other_pay_television_and_radio"
                case cameraAndPhotographicSupplyStores = "camera_and_photographic_supply_stores"
                case candyNutAndConfectioneryStores = "candy_nut_and_confectionery_stores"
                case carAndTruckDealersNewUsed = "car_and_truck_dealers_new_used"
                case carAndTruckDealersUsedOnly = "car_and_truck_dealers_used_only"
                case carRentalAgencies = "car_rental_agencies"
                case carWashes = "car_washes"
                case carpentryServices = "carpentry_services"
                case carpetUpholsteryCleaning = "carpet_upholstery_cleaning"
                case caterers
                case charitableAndSocialServiceOrganizationsFundraising = "charitable_and_social_service_organizations_fundraising"
                case chemicalsAndAlliedProducts = "chemicals_and_allied_products"
                case childCareServices = "child_care_services"
                case childrensAndInfantsWearStores = "childrens_and_infants_wear_stores"
                case chiropodistsPodiatrists = "chiropodists_podiatrists"
                case chiropractors
                case cigarStoresAndStands = "cigar_stores_and_stands"
                case civicSocialFraternalAssociations = "civic_social_fraternal_associations"
                case cleaningAndMaintenance = "cleaning_and_maintenance"
                case clothingRental = "clothing_rental"
                case collegesUniversities = "colleges_universities"
                case commercialEquipment = "commercial_equipment"
                case commercialFootwear = "commercial_footwear"
                case commercialPhotographyArtAndGraphics = "commercial_photography_art_and_graphics"
                case commuterTransportAndFerries = "commuter_transport_and_ferries"
                case computerNetworkServices = "computer_network_services"
                case computerProgramming = "computer_programming"
                case computerRepair = "computer_repair"
                case computerSoftwareStores = "computer_software_stores"
                case computersPeripheralsAndSoftware = "computers_peripherals_and_software"
                case concreteWorkServices = "concrete_work_services"
                case constructionMaterials = "construction_materials"
                case consultingPublicRelations = "consulting_public_relations"
                case correspondenceSchools = "correspondence_schools"
                case cosmeticStores = "cosmetic_stores"
                case counselingServices = "counseling_services"
                case countryClubs = "country_clubs"
                case courierServices = "courier_services"
                case courtCosts = "court_costs"
                case creditReportingAgencies = "credit_reporting_agencies"
                case cruiseLines = "cruise_lines"
                case dairyProductsStores = "dairy_products_stores"
                case danceHallStudiosSchools = "dance_hall_studios_schools"
                case datingEscortServices = "dating_escort_services"
                case dentistsOrthodontists = "dentists_orthodontists"
                case departmentStores = "department_stores"
                case detectiveAgencies = "detective_agencies"
                case digitalGoodsApplications = "digital_goods_applications"
                case digitalGoodsGames = "digital_goods_games"
                case digitalGoodsLargeVolume = "digital_goods_large_volume"
                case digitalGoodsMedia = "digital_goods_media"
                case directMarketingCatalogMerchant = "direct_marketing_catalog_merchant"
                case directMarketingCombinationCatalogAndRetailMerchant = "direct_marketing_combination_catalog_and_retail_merchant"
                case directMarketingInboundTelemarketing = "direct_marketing_inbound_telemarketing"
                case directMarketingInsuranceServices = "direct_marketing_insurance_services"
                case directMarketingOther = "direct_marketing_other"
                case directMarketingOutboundTelemarketing = "direct_marketing_outbound_telemarketing"
                case directMarketingSubscription = "direct_marketing_subscription"
                case directMarketingTravel = "direct_marketing_travel"
                case discountStores = "discount_stores"
                case doctors
                case doorToDoorSales = "door_to_door_sales"
                case draperyWindowCoveringAndUpholsteryStores = "drapery_window_covering_and_upholstery_stores"
                case drinkingPlaces = "drinking_places"
                case drugStoresAndPharmacies = "drug_stores_and_pharmacies"
                case drugsDrugProprietariesAndDruggistSundries = "drugs_drug_proprietaries_and_druggist_sundries"
                case dryCleaners = "dry_cleaners"
                case durableGoods = "durable_goods"
                case dutyFreeStores = "duty_free_stores"
                case eatingPlacesRestaurants = "eating_places_restaurants"
                case educationalServices = "educational_services"
                case electricRazorStores = "electric_razor_stores"
                case electricVehicleCharging = "electric_vehicle_charging"
                case electricalPartsAndEquipment = "electrical_parts_and_equipment"
                case electricalServices = "electrical_services"
                case electronicsRepairShops = "electronics_repair_shops"
                case electronicsStores = "electronics_stores"
                case elementarySecondarySchools = "elementary_secondary_schools"
                case emergencyServicesGcasVisaUseOnly = "emergency_services_gcas_visa_use_only"
                case employmentTempAgencies = "employment_temp_agencies"
                case equipmentRental = "equipment_rental"
                case exterminatingServices = "exterminating_services"
                case familyClothingStores = "family_clothing_stores"
                case fastFoodRestaurants = "fast_food_restaurants"
                case financialInstitutions = "financial_institutions"
                case finesGovernmentAdministrativeEntities = "fines_government_administrative_entities"
                case fireplaceFireplaceScreensAndAccessoriesStores = "fireplace_fireplace_screens_and_accessories_stores"
                case floorCoveringStores = "floor_covering_stores"
                case florists
                case floristsSuppliesNurseryStockAndFlowers = "florists_supplies_nursery_stock_and_flowers"
                case freezerAndLockerMeatProvisioners = "freezer_and_locker_meat_provisioners"
                case fuelDealersNonAutomotive = "fuel_dealers_non_automotive"
                case funeralServicesCrematories = "funeral_services_crematories"
                case furnitureHomeFurnishingsAndEquipmentStoresExceptAppliances = "furniture_home_furnishings_and_equipment_stores_except_appliances"
                case furnitureRepairRefinishing = "furniture_repair_refinishing"
                case furriersAndFurShops = "furriers_and_fur_shops"
                case generalServices = "general_services"
                case giftCardNoveltyAndSouvenirShops = "gift_card_novelty_and_souvenir_shops"
                case glassPaintAndWallpaperStores = "glass_paint_and_wallpaper_stores"
                case glasswareCrystalStores = "glassware_crystal_stores"
                case golfCoursesPublic = "golf_courses_public"
                case governmentLicensedHorseDogRacingUsRegionOnly = "government_licensed_horse_dog_racing_us_region_only"
                case governmentLicensedOnlineCasionsOnlineGamblingUsRegionOnly = "government_licensed_online_casions_online_gambling_us_region_only"
                case governmentOwnedLotteriesNonUsRegion = "government_owned_lotteries_non_us_region"
                case governmentOwnedLotteriesUsRegionOnly = "government_owned_lotteries_us_region_only"
                case governmentServices = "government_services"
                case groceryStoresSupermarkets = "grocery_stores_supermarkets"
                case hardwareEquipmentAndSupplies = "hardware_equipment_and_supplies"
                case hardwareStores = "hardware_stores"
                case healthAndBeautySpas = "health_and_beauty_spas"
                case hearingAidsSalesAndSupplies = "hearing_aids_sales_and_supplies"
                case heatingPlumbingAC = "heating_plumbing_a_c"
                case hobbyToyAndGameShops = "hobby_toy_and_game_shops"
                case homeSupplyWarehouseStores = "home_supply_warehouse_stores"
                case hospitals
                case hotelsMotelsAndResorts = "hotels_motels_and_resorts"
                case householdApplianceStores = "household_appliance_stores"
                case industrialSupplies = "industrial_supplies"
                case informationRetrievalServices = "information_retrieval_services"
                case insuranceDefault = "insurance_default"
                case insuranceUnderwritingPremiums = "insurance_underwriting_premiums"
                case intraCompanyPurchases = "intra_company_purchases"
                case jewelryStoresWatchesClocksAndSilverwareStores = "jewelry_stores_watches_clocks_and_silverware_stores"
                case landscapingServices = "landscaping_services"
                case laundries
                case laundryCleaningServices = "laundry_cleaning_services"
                case legalServicesAttorneys = "legal_services_attorneys"
                case luggageAndLeatherGoodsStores = "luggage_and_leather_goods_stores"
                case lumberBuildingMaterialsStores = "lumber_building_materials_stores"
                case manualCashDisburse = "manual_cash_disburse"
                case marinasServiceAndSupplies = "marinas_service_and_supplies"
                case marketplaces
                case masonryStoneworkAndPlaster = "masonry_stonework_and_plaster"
                case massageParlors = "massage_parlors"
                case medicalAndDentalLabs = "medical_and_dental_labs"
                case medicalDentalOphthalmicAndHospitalEquipmentAndSupplies = "medical_dental_ophthalmic_and_hospital_equipment_and_supplies"
                case medicalServices = "medical_services"
                case membershipOrganizations = "membership_organizations"
                case mensAndBoysClothingAndAccessoriesStores = "mens_and_boys_clothing_and_accessories_stores"
                case mensWomensClothingStores = "mens_womens_clothing_stores"
                case metalServiceCenters = "metal_service_centers"
                case miscellaneousApparelAndAccessoryShops = "miscellaneous_apparel_and_accessory_shops"
                case miscellaneousAutoDealers = "miscellaneous_auto_dealers"
                case miscellaneousBusinessServices = "miscellaneous_business_services"
                case miscellaneousFoodStores = "miscellaneous_food_stores"
                case miscellaneousGeneralMerchandise = "miscellaneous_general_merchandise"
                case miscellaneousGeneralServices = "miscellaneous_general_services"
                case miscellaneousHomeFurnishingSpecialtyStores = "miscellaneous_home_furnishing_specialty_stores"
                case miscellaneousPublishingAndPrinting = "miscellaneous_publishing_and_printing"
                case miscellaneousRecreationServices = "miscellaneous_recreation_services"
                case miscellaneousRepairShops = "miscellaneous_repair_shops"
                case miscellaneousSpecialtyRetail = "miscellaneous_specialty_retail"
                case mobileHomeDealers = "mobile_home_dealers"
                case motionPictureTheaters = "motion_picture_theaters"
                case motorFreightCarriersAndTrucking = "motor_freight_carriers_and_trucking"
                case motorHomesDealers = "motor_homes_dealers"
                case motorVehicleSuppliesAndNewParts = "motor_vehicle_supplies_and_new_parts"
                case motorcycleShopsAndDealers = "motorcycle_shops_and_dealers"
                case motorcycleShopsDealers = "motorcycle_shops_dealers"
                case musicStoresMusicalInstrumentsPianosAndSheetMusic = "music_stores_musical_instruments_pianos_and_sheet_music"
                case newsDealersAndNewsstands = "news_dealers_and_newsstands"
                case nonFiMoneyOrders = "non_fi_money_orders"
                case nonFiStoredValueCardPurchaseLoad = "non_fi_stored_value_card_purchase_load"
                case nondurableGoods = "nondurable_goods"
                case nurseriesLawnAndGardenSupplyStores = "nurseries_lawn_and_garden_supply_stores"
                case nursingPersonalCare = "nursing_personal_care"
                case officeAndCommercialFurniture = "office_and_commercial_furniture"
                case opticiansEyeglasses = "opticians_eyeglasses"
                case optometristsOphthalmologist = "optometrists_ophthalmologist"
                case orthopedicGoodsProstheticDevices = "orthopedic_goods_prosthetic_devices"
                case osteopaths
                case packageStoresBeerWineAndLiquor = "package_stores_beer_wine_and_liquor"
                case paintsVarnishesAndSupplies = "paints_varnishes_and_supplies"
                case parkingLotsGarages = "parking_lots_garages"
                case passengerRailways = "passenger_railways"
                case pawnShops = "pawn_shops"
                case petShopsPetFoodAndSupplies = "pet_shops_pet_food_and_supplies"
                case petroleumAndPetroleumProducts = "petroleum_and_petroleum_products"
                case photoDeveloping = "photo_developing"
                case photographicPhotocopyMicrofilmEquipmentAndSupplies = "photographic_photocopy_microfilm_equipment_and_supplies"
                case photographicStudios = "photographic_studios"
                case pictureVideoProduction = "picture_video_production"
                case pieceGoodsNotionsAndOtherDryGoods = "piece_goods_notions_and_other_dry_goods"
                case plumbingHeatingEquipmentAndSupplies = "plumbing_heating_equipment_and_supplies"
                case politicalOrganizations = "political_organizations"
                case postalServicesGovernmentOnly = "postal_services_government_only"
                case preciousStonesAndMetalsWatchesAndJewelry = "precious_stones_and_metals_watches_and_jewelry"
                case professionalServices = "professional_services"
                case publicWarehousingAndStorage = "public_warehousing_and_storage"
                case quickCopyReproAndBlueprint = "quick_copy_repro_and_blueprint"
                case railroads
                case realEstateAgentsAndManagersRentals = "real_estate_agents_and_managers_rentals"
                case recordStores = "record_stores"
                case recreationalVehicleRentals = "recreational_vehicle_rentals"
                case religiousGoodsStores = "religious_goods_stores"
                case religiousOrganizations = "religious_organizations"
                case roofingSidingSheetMetal = "roofing_siding_sheet_metal"
                case secretarialSupportServices = "secretarial_support_services"
                case securityBrokersDealers = "security_brokers_dealers"
                case serviceStations = "service_stations"
                case sewingNeedleworkFabricAndPieceGoodsStores = "sewing_needlework_fabric_and_piece_goods_stores"
                case shoeRepairHatCleaning = "shoe_repair_hat_cleaning"
                case shoeStores = "shoe_stores"
                case smallApplianceRepair = "small_appliance_repair"
                case snowmobileDealers = "snowmobile_dealers"
                case specialTradeServices = "special_trade_services"
                case specialtyCleaning = "specialty_cleaning"
                case sportingGoodsStores = "sporting_goods_stores"
                case sportingRecreationCamps = "sporting_recreation_camps"
                case sportsAndRidingApparelStores = "sports_and_riding_apparel_stores"
                case sportsClubsFields = "sports_clubs_fields"
                case stampAndCoinStores = "stamp_and_coin_stores"
                case stationaryOfficeSuppliesPrintingAndWritingPaper = "stationary_office_supplies_printing_and_writing_paper"
                case stationeryStoresOfficeAndSchoolSupplyStores = "stationery_stores_office_and_school_supply_stores"
                case swimmingPoolsSales = "swimming_pools_sales"
                case tUiTravelGermany = "t_ui_travel_germany"
                case tailorsAlterations = "tailors_alterations"
                case taxPaymentsGovernmentAgencies = "tax_payments_government_agencies"
                case taxPreparationServices = "tax_preparation_services"
                case taxicabsLimousines = "taxicabs_limousines"
                case telecommunicationEquipmentAndTelephoneSales = "telecommunication_equipment_and_telephone_sales"
                case telecommunicationServices = "telecommunication_services"
                case telegraphServices = "telegraph_services"
                case tentAndAwningShops = "tent_and_awning_shops"
                case testingLaboratories = "testing_laboratories"
                case theatricalTicketAgencies = "theatrical_ticket_agencies"
                case timeshares
                case tireRetreadingAndRepair = "tire_retreading_and_repair"
                case tollsBridgeFees = "tolls_bridge_fees"
                case touristAttractionsAndExhibits = "tourist_attractions_and_exhibits"
                case towingServices = "towing_services"
                case trailerParksCampgrounds = "trailer_parks_campgrounds"
                case transportationServices = "transportation_services"
                case travelAgenciesTourOperators = "travel_agencies_tour_operators"
                case truckStopIteration = "truck_stop_iteration"
                case truckUtilityTrailerRentals = "truck_utility_trailer_rentals"
                case typesettingPlateMakingAndRelatedServices = "typesetting_plate_making_and_related_services"
                case typewriterStores = "typewriter_stores"
                case uSFederalGovernmentAgenciesOrDepartments = "u_s_federal_government_agencies_or_departments"
                case uniformsCommercialClothing = "uniforms_commercial_clothing"
                case usedMerchandiseAndSecondhandStores = "used_merchandise_and_secondhand_stores"
                case utilities
                case varietyStores = "variety_stores"
                case veterinaryServices = "veterinary_services"
                case videoAmusementGameSupplies = "video_amusement_game_supplies"
                case videoGameArcades = "video_game_arcades"
                case videoTapeRentalStores = "video_tape_rental_stores"
                case vocationalTradeSchools = "vocational_trade_schools"
                case watchJewelryRepair = "watch_jewelry_repair"
                case weldingRepair = "welding_repair"
                case wholesaleClubs = "wholesale_clubs"
                case wigAndToupeeStores = "wig_and_toupee_stores"
                case wiresMoneyOrders = "wires_money_orders"
                case womensAccessoryAndSpecialtyShops = "womens_accessory_and_specialty_shops"
                case womensReadyToWearStores = "womens_ready_to_wear_stores"
                case wreckingAndSalvageYards = "wrecking_and_salvage_yards"
            }
        }

        /// Additional purchase information that is optionally provided by the merchant.
        public struct PurchaseDetails: Codable, Hashable, Sendable {
            /// Fleet-specific information for transactions using Fleet cards.
            public var fleet: Fleet?
            /// Information about the flight that was purchased with this transaction.
            public var flight: Flight?
            /// Information about fuel that was purchased with this transaction.
            public var fuel: Fuel?
            /// Information about lodging that was purchased with this transaction.
            public var lodging: Lodging?
            /// The line items in the purchase.
            public var receipt: [Receipt]?
            /// A merchant-specific order number.
            public var reference: String?

            public init(
                fleet: Fleet? = nil,
                flight: Flight? = nil,
                fuel: Fuel? = nil,
                lodging: Lodging? = nil,
                receipt: [Receipt]? = nil,
                reference: String? = nil
            ) {
                self.fleet = fleet
                self.flight = flight
                self.fuel = fuel
                self.lodging = lodging
                self.receipt = receipt
                self.reference = reference
            }

            /// Fleet-specific information for transactions using Fleet cards.
            public struct Fleet: Codable, Hashable, Sendable {
                /// Answers to prompts presented to the cardholder at the point of sale.
                public var cardholderPromptData: CardholderPromptData?
                /// The type of purchase.
                public var purchaseType: PurchaseType?
                /// More information about the total amount.
                public var reportedBreakdown: ReportedBreakdown?
                /// The type of fuel service.
                public var serviceType: ServiceType?

                public init(
                    cardholderPromptData: CardholderPromptData? = nil,
                    purchaseType: PurchaseType? = nil,
                    reportedBreakdown: ReportedBreakdown? = nil,
                    serviceType: ServiceType? = nil
                ) {
                    self.cardholderPromptData = cardholderPromptData
                    self.purchaseType = purchaseType
                    self.reportedBreakdown = reportedBreakdown
                    self.serviceType = serviceType
                }

                public enum PurchaseType: String, Codable, Hashable, Sendable {
                    case fuelAndNonFuelPurchase = "fuel_and_non_fuel_purchase"
                    case fuelPurchase = "fuel_purchase"
                    case nonFuelPurchase = "non_fuel_purchase"
                }

                public enum ServiceType: String, Codable, Hashable, Sendable {
                    case fullService = "full_service"
                    case nonFuelTransaction = "non_fuel_transaction"
                    case selfService = "self_service"
                }

                /// Answers to prompts presented to the cardholder at the point of sale.
                public struct CardholderPromptData: Codable, Hashable, Sendable {
                    /// Driver ID.
                    public var driverId: String?
                    /// Odometer reading.
                    public var odometer: Int?
                    /// An alphanumeric ID.
                    public var unspecifiedId: String?
                    /// User ID.
                    public var userId: String?
                    /// Vehicle number.
                    public var vehicleNumber: String?

                    public init(
                        driverId: String? = nil,
                        odometer: Int? = nil,
                        unspecifiedId: String? = nil,
                        userId: String? = nil,
                        vehicleNumber: String? = nil
                    ) {
                        self.driverId = driverId
                        self.odometer = odometer
                        self.unspecifiedId = unspecifiedId
                        self.userId = userId
                        self.vehicleNumber = vehicleNumber
                    }
                }

                /// More information about the total amount.
                public struct ReportedBreakdown: Codable, Hashable, Sendable {
                    /// Breakdown of fuel portion of the purchase.
                    public var fuel: Fuel?
                    /// Breakdown of non-fuel portion of the purchase.
                    public var nonFuel: NonFuel?
                    /// Information about tax included in this transaction.
                    public var tax: Tax?

                    public init(
                        fuel: Fuel? = nil,
                        nonFuel: NonFuel? = nil,
                        tax: Tax? = nil
                    ) {
                        self.fuel = fuel
                        self.nonFuel = nonFuel
                        self.tax = tax
                    }

                    /// Breakdown of fuel portion of the purchase.
                    public struct Fuel: Codable, Hashable, Sendable {
                        /// Gross fuel amount that should equal Fuel Volume multiplied by Fuel Unit Cost, inclusive of taxes.
                        public var grossAmountDecimal: String?

                        public init(
                            grossAmountDecimal: String? = nil
                        ) {
                            self.grossAmountDecimal = grossAmountDecimal
                        }
                    }

                    /// Breakdown of non-fuel portion of the purchase.
                    public struct NonFuel: Codable, Hashable, Sendable {
                        /// Gross non-fuel amount that should equal the sum of the line items, inclusive of taxes.
                        public var grossAmountDecimal: String?

                        public init(
                            grossAmountDecimal: String? = nil
                        ) {
                            self.grossAmountDecimal = grossAmountDecimal
                        }
                    }

                    /// Information about tax included in this transaction.
                    public struct Tax: Codable, Hashable, Sendable {
                        /// Amount of state or provincial Sales Tax included in the transaction amount.
                        public var localAmountDecimal: String?
                        /// Amount of national Sales Tax or VAT included in the transaction amount.
                        public var nationalAmountDecimal: String?

                        public init(
                            localAmountDecimal: String? = nil,
                            nationalAmountDecimal: String? = nil
                        ) {
                            self.localAmountDecimal = localAmountDecimal
                            self.nationalAmountDecimal = nationalAmountDecimal
                        }
                    }
                }
            }

            /// Information about the flight that was purchased with this transaction.
            public struct Flight: Codable, Hashable, Sendable {
                /// The time that the flight departed.
                public var departureAt: Date?
                /// The name of the passenger.
                public var passengerName: String?
                /// Whether the ticket is refundable.
                public var refundable: Bool?
                /// The legs of the trip.
                public var segments: [Segments]?
                /// The travel agency that issued the ticket.
                public var travelAgency: String?

                public init(
                    departureAt: Date? = nil,
                    passengerName: String? = nil,
                    refundable: Bool? = nil,
                    segments: [Segments]? = nil,
                    travelAgency: String? = nil
                ) {
                    self.departureAt = departureAt
                    self.passengerName = passengerName
                    self.refundable = refundable
                    self.segments = segments
                    self.travelAgency = travelAgency
                }

                public struct Segments: Codable, Hashable, Sendable {
                    /// The three-letter IATA airport code of the flight's destination.
                    public var arrivalAirportCode: String?
                    /// The airline carrier code.
                    public var carrier: String?
                    /// The three-letter IATA airport code that the flight departed from.
                    public var departureAirportCode: String?
                    /// The flight number.
                    public var flightNumber: String?
                    /// The flight's service class.
                    public var serviceClass: String?
                    /// Whether a stopover is allowed on this flight.
                    public var stopoverAllowed: Bool?

                    public init(
                        arrivalAirportCode: String? = nil,
                        carrier: String? = nil,
                        departureAirportCode: String? = nil,
                        flightNumber: String? = nil,
                        serviceClass: String? = nil,
                        stopoverAllowed: Bool? = nil
                    ) {
                        self.arrivalAirportCode = arrivalAirportCode
                        self.carrier = carrier
                        self.departureAirportCode = departureAirportCode
                        self.flightNumber = flightNumber
                        self.serviceClass = serviceClass
                        self.stopoverAllowed = stopoverAllowed
                    }
                }
            }

            /// Information about fuel that was purchased with this transaction.
            public struct Fuel: Codable, Hashable, Sendable {
                /// Conexxus Payment System Product Code identifying the primary fuel product purchased.
                public var industryProductCode: String?
                /// The quantity of `unit`s of fuel that was dispensed, represented as a decimal string with at most 12 decimal places.
                public var quantityDecimal: String?
                /// The type of fuel that was purchased.
                public var `type`: Type?
                /// The units for `quantity_decimal`.
                public var unit: Unit?
                /// The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
                public var unitCostDecimal: String?

                public init(
                    industryProductCode: String? = nil,
                    quantityDecimal: String? = nil,
                    `type`: Type? = nil,
                    unit: Unit? = nil,
                    unitCostDecimal: String? = nil
                ) {
                    self.industryProductCode = industryProductCode
                    self.quantityDecimal = quantityDecimal
                    self.`type` = `type`
                    self.unit = unit
                    self.unitCostDecimal = unitCostDecimal
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case diesel
                    case other
                    case unleadedPlus = "unleaded_plus"
                    case unleadedRegular = "unleaded_regular"
                    case unleadedSuper = "unleaded_super"
                }

                public enum Unit: String, Codable, Hashable, Sendable {
                    case chargingMinute = "charging_minute"
                    case imperialGallon = "imperial_gallon"
                    case kilogram
                    case kilowattHour = "kilowatt_hour"
                    case liter
                    case other
                    case pound
                    case usGallon = "us_gallon"
                }
            }

            /// Information about lodging that was purchased with this transaction.
            public struct Lodging: Codable, Hashable, Sendable {
                /// The time of checking into the lodging.
                public var checkInAt: Date?
                /// The number of nights stayed at the lodging.
                public var nights: Int?

                public init(
                    checkInAt: Date? = nil,
                    nights: Int? = nil
                ) {
                    self.checkInAt = checkInAt
                    self.nights = nights
                }
            }

            public struct Receipt: Codable, Hashable, Sendable {
                public var description: String?
                public var quantity: String?
                public var total: Int?
                public var unitCost: Int?

                public init(
                    description: String? = nil,
                    quantity: String? = nil,
                    total: Int? = nil,
                    unitCost: Int? = nil
                ) {
                    self.description = description
                    self.quantity = quantity
                    self.total = total
                    self.unitCost = unitCost
                }
            }
        }
    }

    public typealias Response = Transaction
}

// POST /v1/test_helpers/issuing/transactions/create_unlinked_refund
extension Transaction.CreateUnlinkedRefund {
    public struct Request: Codable, Hashable, Sendable {
        /// The total amount to attempt to refund.
        public var amount: Int
        /// Card associated with this unlinked refund transaction.
        public var card: String
        /// The currency of the unlinked refund.
        public var currency: Stripe.Currency?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Details about the seller (grocery store, e-commerce website, etc.
        public var merchantData: MerchantData?
        /// Additional purchase information that is optionally provided by the merchant.
        public var purchaseDetails: PurchaseDetails?

        public init(
            amount: Int,
            card: String,
            currency: Stripe.Currency? = nil,
            expand: [String]? = nil,
            merchantData: MerchantData? = nil,
            purchaseDetails: PurchaseDetails? = nil
        ) {
            self.amount = amount
            self.card = card
            self.currency = currency
            self.expand = expand
            self.merchantData = merchantData
            self.purchaseDetails = purchaseDetails
        }

        /// Details about the seller (grocery store, e-commerce website, etc.
        public struct MerchantData: Codable, Hashable, Sendable {
            /// A categorization of the seller's type of business.
            public var category: Category?
            /// City where the seller is located.
            public var city: String?
            /// Country where the seller is located.
            public var country: String?
            /// Name of the seller.
            public var name: String?
            /// Identifier assigned to the seller by the card network.
            public var networkId: String?
            /// Postal code where the seller is located.
            public var postalCode: String?
            /// State where the seller is located.
            public var state: String?
            /// An ID assigned by the seller to the location of the sale.
            public var terminalId: String?
            /// URL provided by the merchant on a 3DS request.
            public var url: String?

            public init(
                category: Category? = nil,
                city: String? = nil,
                country: String? = nil,
                name: String? = nil,
                networkId: String? = nil,
                postalCode: String? = nil,
                state: String? = nil,
                terminalId: String? = nil,
                url: String? = nil
            ) {
                self.category = category
                self.city = city
                self.country = country
                self.name = name
                self.networkId = networkId
                self.postalCode = postalCode
                self.state = state
                self.terminalId = terminalId
                self.url = url
            }

            public enum Category: String, Codable, Hashable, Sendable {
                case acRefrigerationRepair = "ac_refrigeration_repair"
                case accountingBookkeepingServices = "accounting_bookkeeping_services"
                case advertisingServices = "advertising_services"
                case agriculturalCooperative = "agricultural_cooperative"
                case airlinesAirCarriers = "airlines_air_carriers"
                case airportsFlyingFields = "airports_flying_fields"
                case ambulanceServices = "ambulance_services"
                case amusementParksCarnivals = "amusement_parks_carnivals"
                case antiqueReproductions = "antique_reproductions"
                case antiqueShops = "antique_shops"
                case aquariums
                case architecturalSurveyingServices = "architectural_surveying_services"
                case artDealersAndGalleries = "art_dealers_and_galleries"
                case artistsSupplyAndCraftShops = "artists_supply_and_craft_shops"
                case autoAndHomeSupplyStores = "auto_and_home_supply_stores"
                case autoBodyRepairShops = "auto_body_repair_shops"
                case autoPaintShops = "auto_paint_shops"
                case autoServiceShops = "auto_service_shops"
                case automatedCashDisburse = "automated_cash_disburse"
                case automatedFuelDispensers = "automated_fuel_dispensers"
                case automobileAssociations = "automobile_associations"
                case automotivePartsAndAccessoriesStores = "automotive_parts_and_accessories_stores"
                case automotiveTireStores = "automotive_tire_stores"
                case bailAndBondPayments = "bail_and_bond_payments"
                case bakeries
                case bandsOrchestras = "bands_orchestras"
                case barberAndBeautyShops = "barber_and_beauty_shops"
                case bettingCasinoGambling = "betting_casino_gambling"
                case bicycleShops = "bicycle_shops"
                case billiardPoolEstablishments = "billiard_pool_establishments"
                case boatDealers = "boat_dealers"
                case boatRentalsAndLeases = "boat_rentals_and_leases"
                case bookStores = "book_stores"
                case booksPeriodicalsAndNewspapers = "books_periodicals_and_newspapers"
                case bowlingAlleys = "bowling_alleys"
                case busLines = "bus_lines"
                case businessSecretarialSchools = "business_secretarial_schools"
                case buyingShoppingServices = "buying_shopping_services"
                case cableSatelliteAndOtherPayTelevisionAndRadio = "cable_satellite_and_other_pay_television_and_radio"
                case cameraAndPhotographicSupplyStores = "camera_and_photographic_supply_stores"
                case candyNutAndConfectioneryStores = "candy_nut_and_confectionery_stores"
                case carAndTruckDealersNewUsed = "car_and_truck_dealers_new_used"
                case carAndTruckDealersUsedOnly = "car_and_truck_dealers_used_only"
                case carRentalAgencies = "car_rental_agencies"
                case carWashes = "car_washes"
                case carpentryServices = "carpentry_services"
                case carpetUpholsteryCleaning = "carpet_upholstery_cleaning"
                case caterers
                case charitableAndSocialServiceOrganizationsFundraising = "charitable_and_social_service_organizations_fundraising"
                case chemicalsAndAlliedProducts = "chemicals_and_allied_products"
                case childCareServices = "child_care_services"
                case childrensAndInfantsWearStores = "childrens_and_infants_wear_stores"
                case chiropodistsPodiatrists = "chiropodists_podiatrists"
                case chiropractors
                case cigarStoresAndStands = "cigar_stores_and_stands"
                case civicSocialFraternalAssociations = "civic_social_fraternal_associations"
                case cleaningAndMaintenance = "cleaning_and_maintenance"
                case clothingRental = "clothing_rental"
                case collegesUniversities = "colleges_universities"
                case commercialEquipment = "commercial_equipment"
                case commercialFootwear = "commercial_footwear"
                case commercialPhotographyArtAndGraphics = "commercial_photography_art_and_graphics"
                case commuterTransportAndFerries = "commuter_transport_and_ferries"
                case computerNetworkServices = "computer_network_services"
                case computerProgramming = "computer_programming"
                case computerRepair = "computer_repair"
                case computerSoftwareStores = "computer_software_stores"
                case computersPeripheralsAndSoftware = "computers_peripherals_and_software"
                case concreteWorkServices = "concrete_work_services"
                case constructionMaterials = "construction_materials"
                case consultingPublicRelations = "consulting_public_relations"
                case correspondenceSchools = "correspondence_schools"
                case cosmeticStores = "cosmetic_stores"
                case counselingServices = "counseling_services"
                case countryClubs = "country_clubs"
                case courierServices = "courier_services"
                case courtCosts = "court_costs"
                case creditReportingAgencies = "credit_reporting_agencies"
                case cruiseLines = "cruise_lines"
                case dairyProductsStores = "dairy_products_stores"
                case danceHallStudiosSchools = "dance_hall_studios_schools"
                case datingEscortServices = "dating_escort_services"
                case dentistsOrthodontists = "dentists_orthodontists"
                case departmentStores = "department_stores"
                case detectiveAgencies = "detective_agencies"
                case digitalGoodsApplications = "digital_goods_applications"
                case digitalGoodsGames = "digital_goods_games"
                case digitalGoodsLargeVolume = "digital_goods_large_volume"
                case digitalGoodsMedia = "digital_goods_media"
                case directMarketingCatalogMerchant = "direct_marketing_catalog_merchant"
                case directMarketingCombinationCatalogAndRetailMerchant = "direct_marketing_combination_catalog_and_retail_merchant"
                case directMarketingInboundTelemarketing = "direct_marketing_inbound_telemarketing"
                case directMarketingInsuranceServices = "direct_marketing_insurance_services"
                case directMarketingOther = "direct_marketing_other"
                case directMarketingOutboundTelemarketing = "direct_marketing_outbound_telemarketing"
                case directMarketingSubscription = "direct_marketing_subscription"
                case directMarketingTravel = "direct_marketing_travel"
                case discountStores = "discount_stores"
                case doctors
                case doorToDoorSales = "door_to_door_sales"
                case draperyWindowCoveringAndUpholsteryStores = "drapery_window_covering_and_upholstery_stores"
                case drinkingPlaces = "drinking_places"
                case drugStoresAndPharmacies = "drug_stores_and_pharmacies"
                case drugsDrugProprietariesAndDruggistSundries = "drugs_drug_proprietaries_and_druggist_sundries"
                case dryCleaners = "dry_cleaners"
                case durableGoods = "durable_goods"
                case dutyFreeStores = "duty_free_stores"
                case eatingPlacesRestaurants = "eating_places_restaurants"
                case educationalServices = "educational_services"
                case electricRazorStores = "electric_razor_stores"
                case electricVehicleCharging = "electric_vehicle_charging"
                case electricalPartsAndEquipment = "electrical_parts_and_equipment"
                case electricalServices = "electrical_services"
                case electronicsRepairShops = "electronics_repair_shops"
                case electronicsStores = "electronics_stores"
                case elementarySecondarySchools = "elementary_secondary_schools"
                case emergencyServicesGcasVisaUseOnly = "emergency_services_gcas_visa_use_only"
                case employmentTempAgencies = "employment_temp_agencies"
                case equipmentRental = "equipment_rental"
                case exterminatingServices = "exterminating_services"
                case familyClothingStores = "family_clothing_stores"
                case fastFoodRestaurants = "fast_food_restaurants"
                case financialInstitutions = "financial_institutions"
                case finesGovernmentAdministrativeEntities = "fines_government_administrative_entities"
                case fireplaceFireplaceScreensAndAccessoriesStores = "fireplace_fireplace_screens_and_accessories_stores"
                case floorCoveringStores = "floor_covering_stores"
                case florists
                case floristsSuppliesNurseryStockAndFlowers = "florists_supplies_nursery_stock_and_flowers"
                case freezerAndLockerMeatProvisioners = "freezer_and_locker_meat_provisioners"
                case fuelDealersNonAutomotive = "fuel_dealers_non_automotive"
                case funeralServicesCrematories = "funeral_services_crematories"
                case furnitureHomeFurnishingsAndEquipmentStoresExceptAppliances = "furniture_home_furnishings_and_equipment_stores_except_appliances"
                case furnitureRepairRefinishing = "furniture_repair_refinishing"
                case furriersAndFurShops = "furriers_and_fur_shops"
                case generalServices = "general_services"
                case giftCardNoveltyAndSouvenirShops = "gift_card_novelty_and_souvenir_shops"
                case glassPaintAndWallpaperStores = "glass_paint_and_wallpaper_stores"
                case glasswareCrystalStores = "glassware_crystal_stores"
                case golfCoursesPublic = "golf_courses_public"
                case governmentLicensedHorseDogRacingUsRegionOnly = "government_licensed_horse_dog_racing_us_region_only"
                case governmentLicensedOnlineCasionsOnlineGamblingUsRegionOnly = "government_licensed_online_casions_online_gambling_us_region_only"
                case governmentOwnedLotteriesNonUsRegion = "government_owned_lotteries_non_us_region"
                case governmentOwnedLotteriesUsRegionOnly = "government_owned_lotteries_us_region_only"
                case governmentServices = "government_services"
                case groceryStoresSupermarkets = "grocery_stores_supermarkets"
                case hardwareEquipmentAndSupplies = "hardware_equipment_and_supplies"
                case hardwareStores = "hardware_stores"
                case healthAndBeautySpas = "health_and_beauty_spas"
                case hearingAidsSalesAndSupplies = "hearing_aids_sales_and_supplies"
                case heatingPlumbingAC = "heating_plumbing_a_c"
                case hobbyToyAndGameShops = "hobby_toy_and_game_shops"
                case homeSupplyWarehouseStores = "home_supply_warehouse_stores"
                case hospitals
                case hotelsMotelsAndResorts = "hotels_motels_and_resorts"
                case householdApplianceStores = "household_appliance_stores"
                case industrialSupplies = "industrial_supplies"
                case informationRetrievalServices = "information_retrieval_services"
                case insuranceDefault = "insurance_default"
                case insuranceUnderwritingPremiums = "insurance_underwriting_premiums"
                case intraCompanyPurchases = "intra_company_purchases"
                case jewelryStoresWatchesClocksAndSilverwareStores = "jewelry_stores_watches_clocks_and_silverware_stores"
                case landscapingServices = "landscaping_services"
                case laundries
                case laundryCleaningServices = "laundry_cleaning_services"
                case legalServicesAttorneys = "legal_services_attorneys"
                case luggageAndLeatherGoodsStores = "luggage_and_leather_goods_stores"
                case lumberBuildingMaterialsStores = "lumber_building_materials_stores"
                case manualCashDisburse = "manual_cash_disburse"
                case marinasServiceAndSupplies = "marinas_service_and_supplies"
                case marketplaces
                case masonryStoneworkAndPlaster = "masonry_stonework_and_plaster"
                case massageParlors = "massage_parlors"
                case medicalAndDentalLabs = "medical_and_dental_labs"
                case medicalDentalOphthalmicAndHospitalEquipmentAndSupplies = "medical_dental_ophthalmic_and_hospital_equipment_and_supplies"
                case medicalServices = "medical_services"
                case membershipOrganizations = "membership_organizations"
                case mensAndBoysClothingAndAccessoriesStores = "mens_and_boys_clothing_and_accessories_stores"
                case mensWomensClothingStores = "mens_womens_clothing_stores"
                case metalServiceCenters = "metal_service_centers"
                case miscellaneousApparelAndAccessoryShops = "miscellaneous_apparel_and_accessory_shops"
                case miscellaneousAutoDealers = "miscellaneous_auto_dealers"
                case miscellaneousBusinessServices = "miscellaneous_business_services"
                case miscellaneousFoodStores = "miscellaneous_food_stores"
                case miscellaneousGeneralMerchandise = "miscellaneous_general_merchandise"
                case miscellaneousGeneralServices = "miscellaneous_general_services"
                case miscellaneousHomeFurnishingSpecialtyStores = "miscellaneous_home_furnishing_specialty_stores"
                case miscellaneousPublishingAndPrinting = "miscellaneous_publishing_and_printing"
                case miscellaneousRecreationServices = "miscellaneous_recreation_services"
                case miscellaneousRepairShops = "miscellaneous_repair_shops"
                case miscellaneousSpecialtyRetail = "miscellaneous_specialty_retail"
                case mobileHomeDealers = "mobile_home_dealers"
                case motionPictureTheaters = "motion_picture_theaters"
                case motorFreightCarriersAndTrucking = "motor_freight_carriers_and_trucking"
                case motorHomesDealers = "motor_homes_dealers"
                case motorVehicleSuppliesAndNewParts = "motor_vehicle_supplies_and_new_parts"
                case motorcycleShopsAndDealers = "motorcycle_shops_and_dealers"
                case motorcycleShopsDealers = "motorcycle_shops_dealers"
                case musicStoresMusicalInstrumentsPianosAndSheetMusic = "music_stores_musical_instruments_pianos_and_sheet_music"
                case newsDealersAndNewsstands = "news_dealers_and_newsstands"
                case nonFiMoneyOrders = "non_fi_money_orders"
                case nonFiStoredValueCardPurchaseLoad = "non_fi_stored_value_card_purchase_load"
                case nondurableGoods = "nondurable_goods"
                case nurseriesLawnAndGardenSupplyStores = "nurseries_lawn_and_garden_supply_stores"
                case nursingPersonalCare = "nursing_personal_care"
                case officeAndCommercialFurniture = "office_and_commercial_furniture"
                case opticiansEyeglasses = "opticians_eyeglasses"
                case optometristsOphthalmologist = "optometrists_ophthalmologist"
                case orthopedicGoodsProstheticDevices = "orthopedic_goods_prosthetic_devices"
                case osteopaths
                case packageStoresBeerWineAndLiquor = "package_stores_beer_wine_and_liquor"
                case paintsVarnishesAndSupplies = "paints_varnishes_and_supplies"
                case parkingLotsGarages = "parking_lots_garages"
                case passengerRailways = "passenger_railways"
                case pawnShops = "pawn_shops"
                case petShopsPetFoodAndSupplies = "pet_shops_pet_food_and_supplies"
                case petroleumAndPetroleumProducts = "petroleum_and_petroleum_products"
                case photoDeveloping = "photo_developing"
                case photographicPhotocopyMicrofilmEquipmentAndSupplies = "photographic_photocopy_microfilm_equipment_and_supplies"
                case photographicStudios = "photographic_studios"
                case pictureVideoProduction = "picture_video_production"
                case pieceGoodsNotionsAndOtherDryGoods = "piece_goods_notions_and_other_dry_goods"
                case plumbingHeatingEquipmentAndSupplies = "plumbing_heating_equipment_and_supplies"
                case politicalOrganizations = "political_organizations"
                case postalServicesGovernmentOnly = "postal_services_government_only"
                case preciousStonesAndMetalsWatchesAndJewelry = "precious_stones_and_metals_watches_and_jewelry"
                case professionalServices = "professional_services"
                case publicWarehousingAndStorage = "public_warehousing_and_storage"
                case quickCopyReproAndBlueprint = "quick_copy_repro_and_blueprint"
                case railroads
                case realEstateAgentsAndManagersRentals = "real_estate_agents_and_managers_rentals"
                case recordStores = "record_stores"
                case recreationalVehicleRentals = "recreational_vehicle_rentals"
                case religiousGoodsStores = "religious_goods_stores"
                case religiousOrganizations = "religious_organizations"
                case roofingSidingSheetMetal = "roofing_siding_sheet_metal"
                case secretarialSupportServices = "secretarial_support_services"
                case securityBrokersDealers = "security_brokers_dealers"
                case serviceStations = "service_stations"
                case sewingNeedleworkFabricAndPieceGoodsStores = "sewing_needlework_fabric_and_piece_goods_stores"
                case shoeRepairHatCleaning = "shoe_repair_hat_cleaning"
                case shoeStores = "shoe_stores"
                case smallApplianceRepair = "small_appliance_repair"
                case snowmobileDealers = "snowmobile_dealers"
                case specialTradeServices = "special_trade_services"
                case specialtyCleaning = "specialty_cleaning"
                case sportingGoodsStores = "sporting_goods_stores"
                case sportingRecreationCamps = "sporting_recreation_camps"
                case sportsAndRidingApparelStores = "sports_and_riding_apparel_stores"
                case sportsClubsFields = "sports_clubs_fields"
                case stampAndCoinStores = "stamp_and_coin_stores"
                case stationaryOfficeSuppliesPrintingAndWritingPaper = "stationary_office_supplies_printing_and_writing_paper"
                case stationeryStoresOfficeAndSchoolSupplyStores = "stationery_stores_office_and_school_supply_stores"
                case swimmingPoolsSales = "swimming_pools_sales"
                case tUiTravelGermany = "t_ui_travel_germany"
                case tailorsAlterations = "tailors_alterations"
                case taxPaymentsGovernmentAgencies = "tax_payments_government_agencies"
                case taxPreparationServices = "tax_preparation_services"
                case taxicabsLimousines = "taxicabs_limousines"
                case telecommunicationEquipmentAndTelephoneSales = "telecommunication_equipment_and_telephone_sales"
                case telecommunicationServices = "telecommunication_services"
                case telegraphServices = "telegraph_services"
                case tentAndAwningShops = "tent_and_awning_shops"
                case testingLaboratories = "testing_laboratories"
                case theatricalTicketAgencies = "theatrical_ticket_agencies"
                case timeshares
                case tireRetreadingAndRepair = "tire_retreading_and_repair"
                case tollsBridgeFees = "tolls_bridge_fees"
                case touristAttractionsAndExhibits = "tourist_attractions_and_exhibits"
                case towingServices = "towing_services"
                case trailerParksCampgrounds = "trailer_parks_campgrounds"
                case transportationServices = "transportation_services"
                case travelAgenciesTourOperators = "travel_agencies_tour_operators"
                case truckStopIteration = "truck_stop_iteration"
                case truckUtilityTrailerRentals = "truck_utility_trailer_rentals"
                case typesettingPlateMakingAndRelatedServices = "typesetting_plate_making_and_related_services"
                case typewriterStores = "typewriter_stores"
                case uSFederalGovernmentAgenciesOrDepartments = "u_s_federal_government_agencies_or_departments"
                case uniformsCommercialClothing = "uniforms_commercial_clothing"
                case usedMerchandiseAndSecondhandStores = "used_merchandise_and_secondhand_stores"
                case utilities
                case varietyStores = "variety_stores"
                case veterinaryServices = "veterinary_services"
                case videoAmusementGameSupplies = "video_amusement_game_supplies"
                case videoGameArcades = "video_game_arcades"
                case videoTapeRentalStores = "video_tape_rental_stores"
                case vocationalTradeSchools = "vocational_trade_schools"
                case watchJewelryRepair = "watch_jewelry_repair"
                case weldingRepair = "welding_repair"
                case wholesaleClubs = "wholesale_clubs"
                case wigAndToupeeStores = "wig_and_toupee_stores"
                case wiresMoneyOrders = "wires_money_orders"
                case womensAccessoryAndSpecialtyShops = "womens_accessory_and_specialty_shops"
                case womensReadyToWearStores = "womens_ready_to_wear_stores"
                case wreckingAndSalvageYards = "wrecking_and_salvage_yards"
            }
        }

        /// Additional purchase information that is optionally provided by the merchant.
        public struct PurchaseDetails: Codable, Hashable, Sendable {
            /// Fleet-specific information for transactions using Fleet cards.
            public var fleet: Fleet?
            /// Information about the flight that was purchased with this transaction.
            public var flight: Flight?
            /// Information about fuel that was purchased with this transaction.
            public var fuel: Fuel?
            /// Information about lodging that was purchased with this transaction.
            public var lodging: Lodging?
            /// The line items in the purchase.
            public var receipt: [Receipt]?
            /// A merchant-specific order number.
            public var reference: String?

            public init(
                fleet: Fleet? = nil,
                flight: Flight? = nil,
                fuel: Fuel? = nil,
                lodging: Lodging? = nil,
                receipt: [Receipt]? = nil,
                reference: String? = nil
            ) {
                self.fleet = fleet
                self.flight = flight
                self.fuel = fuel
                self.lodging = lodging
                self.receipt = receipt
                self.reference = reference
            }

            /// Fleet-specific information for transactions using Fleet cards.
            public struct Fleet: Codable, Hashable, Sendable {
                /// Answers to prompts presented to the cardholder at the point of sale.
                public var cardholderPromptData: CardholderPromptData?
                /// The type of purchase.
                public var purchaseType: PurchaseType?
                /// More information about the total amount.
                public var reportedBreakdown: ReportedBreakdown?
                /// The type of fuel service.
                public var serviceType: ServiceType?

                public init(
                    cardholderPromptData: CardholderPromptData? = nil,
                    purchaseType: PurchaseType? = nil,
                    reportedBreakdown: ReportedBreakdown? = nil,
                    serviceType: ServiceType? = nil
                ) {
                    self.cardholderPromptData = cardholderPromptData
                    self.purchaseType = purchaseType
                    self.reportedBreakdown = reportedBreakdown
                    self.serviceType = serviceType
                }

                public enum PurchaseType: String, Codable, Hashable, Sendable {
                    case fuelAndNonFuelPurchase = "fuel_and_non_fuel_purchase"
                    case fuelPurchase = "fuel_purchase"
                    case nonFuelPurchase = "non_fuel_purchase"
                }

                public enum ServiceType: String, Codable, Hashable, Sendable {
                    case fullService = "full_service"
                    case nonFuelTransaction = "non_fuel_transaction"
                    case selfService = "self_service"
                }

                /// Answers to prompts presented to the cardholder at the point of sale.
                public struct CardholderPromptData: Codable, Hashable, Sendable {
                    /// Driver ID.
                    public var driverId: String?
                    /// Odometer reading.
                    public var odometer: Int?
                    /// An alphanumeric ID.
                    public var unspecifiedId: String?
                    /// User ID.
                    public var userId: String?
                    /// Vehicle number.
                    public var vehicleNumber: String?

                    public init(
                        driverId: String? = nil,
                        odometer: Int? = nil,
                        unspecifiedId: String? = nil,
                        userId: String? = nil,
                        vehicleNumber: String? = nil
                    ) {
                        self.driverId = driverId
                        self.odometer = odometer
                        self.unspecifiedId = unspecifiedId
                        self.userId = userId
                        self.vehicleNumber = vehicleNumber
                    }
                }

                /// More information about the total amount.
                public struct ReportedBreakdown: Codable, Hashable, Sendable {
                    /// Breakdown of fuel portion of the purchase.
                    public var fuel: Fuel?
                    /// Breakdown of non-fuel portion of the purchase.
                    public var nonFuel: NonFuel?
                    /// Information about tax included in this transaction.
                    public var tax: Tax?

                    public init(
                        fuel: Fuel? = nil,
                        nonFuel: NonFuel? = nil,
                        tax: Tax? = nil
                    ) {
                        self.fuel = fuel
                        self.nonFuel = nonFuel
                        self.tax = tax
                    }

                    /// Breakdown of fuel portion of the purchase.
                    public struct Fuel: Codable, Hashable, Sendable {
                        /// Gross fuel amount that should equal Fuel Volume multiplied by Fuel Unit Cost, inclusive of taxes.
                        public var grossAmountDecimal: String?

                        public init(
                            grossAmountDecimal: String? = nil
                        ) {
                            self.grossAmountDecimal = grossAmountDecimal
                        }
                    }

                    /// Breakdown of non-fuel portion of the purchase.
                    public struct NonFuel: Codable, Hashable, Sendable {
                        /// Gross non-fuel amount that should equal the sum of the line items, inclusive of taxes.
                        public var grossAmountDecimal: String?

                        public init(
                            grossAmountDecimal: String? = nil
                        ) {
                            self.grossAmountDecimal = grossAmountDecimal
                        }
                    }

                    /// Information about tax included in this transaction.
                    public struct Tax: Codable, Hashable, Sendable {
                        /// Amount of state or provincial Sales Tax included in the transaction amount.
                        public var localAmountDecimal: String?
                        /// Amount of national Sales Tax or VAT included in the transaction amount.
                        public var nationalAmountDecimal: String?

                        public init(
                            localAmountDecimal: String? = nil,
                            nationalAmountDecimal: String? = nil
                        ) {
                            self.localAmountDecimal = localAmountDecimal
                            self.nationalAmountDecimal = nationalAmountDecimal
                        }
                    }
                }
            }

            /// Information about the flight that was purchased with this transaction.
            public struct Flight: Codable, Hashable, Sendable {
                /// The time that the flight departed.
                public var departureAt: Date?
                /// The name of the passenger.
                public var passengerName: String?
                /// Whether the ticket is refundable.
                public var refundable: Bool?
                /// The legs of the trip.
                public var segments: [Segments]?
                /// The travel agency that issued the ticket.
                public var travelAgency: String?

                public init(
                    departureAt: Date? = nil,
                    passengerName: String? = nil,
                    refundable: Bool? = nil,
                    segments: [Segments]? = nil,
                    travelAgency: String? = nil
                ) {
                    self.departureAt = departureAt
                    self.passengerName = passengerName
                    self.refundable = refundable
                    self.segments = segments
                    self.travelAgency = travelAgency
                }

                public struct Segments: Codable, Hashable, Sendable {
                    /// The three-letter IATA airport code of the flight's destination.
                    public var arrivalAirportCode: String?
                    /// The airline carrier code.
                    public var carrier: String?
                    /// The three-letter IATA airport code that the flight departed from.
                    public var departureAirportCode: String?
                    /// The flight number.
                    public var flightNumber: String?
                    /// The flight's service class.
                    public var serviceClass: String?
                    /// Whether a stopover is allowed on this flight.
                    public var stopoverAllowed: Bool?

                    public init(
                        arrivalAirportCode: String? = nil,
                        carrier: String? = nil,
                        departureAirportCode: String? = nil,
                        flightNumber: String? = nil,
                        serviceClass: String? = nil,
                        stopoverAllowed: Bool? = nil
                    ) {
                        self.arrivalAirportCode = arrivalAirportCode
                        self.carrier = carrier
                        self.departureAirportCode = departureAirportCode
                        self.flightNumber = flightNumber
                        self.serviceClass = serviceClass
                        self.stopoverAllowed = stopoverAllowed
                    }
                }
            }

            /// Information about fuel that was purchased with this transaction.
            public struct Fuel: Codable, Hashable, Sendable {
                /// Conexxus Payment System Product Code identifying the primary fuel product purchased.
                public var industryProductCode: String?
                /// The quantity of `unit`s of fuel that was dispensed, represented as a decimal string with at most 12 decimal places.
                public var quantityDecimal: String?
                /// The type of fuel that was purchased.
                public var `type`: Type?
                /// The units for `quantity_decimal`.
                public var unit: Unit?
                /// The cost in cents per each unit of fuel, represented as a decimal string with at most 12 decimal places.
                public var unitCostDecimal: String?

                public init(
                    industryProductCode: String? = nil,
                    quantityDecimal: String? = nil,
                    `type`: Type? = nil,
                    unit: Unit? = nil,
                    unitCostDecimal: String? = nil
                ) {
                    self.industryProductCode = industryProductCode
                    self.quantityDecimal = quantityDecimal
                    self.`type` = `type`
                    self.unit = unit
                    self.unitCostDecimal = unitCostDecimal
                }

                public enum `Type`: String, Codable, Hashable, Sendable {
                    case diesel
                    case other
                    case unleadedPlus = "unleaded_plus"
                    case unleadedRegular = "unleaded_regular"
                    case unleadedSuper = "unleaded_super"
                }

                public enum Unit: String, Codable, Hashable, Sendable {
                    case chargingMinute = "charging_minute"
                    case imperialGallon = "imperial_gallon"
                    case kilogram
                    case kilowattHour = "kilowatt_hour"
                    case liter
                    case other
                    case pound
                    case usGallon = "us_gallon"
                }
            }

            /// Information about lodging that was purchased with this transaction.
            public struct Lodging: Codable, Hashable, Sendable {
                /// The time of checking into the lodging.
                public var checkInAt: Date?
                /// The number of nights stayed at the lodging.
                public var nights: Int?

                public init(
                    checkInAt: Date? = nil,
                    nights: Int? = nil
                ) {
                    self.checkInAt = checkInAt
                    self.nights = nights
                }
            }

            public struct Receipt: Codable, Hashable, Sendable {
                public var description: String?
                public var quantity: String?
                public var total: Int?
                public var unitCost: Int?

                public init(
                    description: String? = nil,
                    quantity: String? = nil,
                    total: Int? = nil,
                    unitCost: Int? = nil
                ) {
                    self.description = description
                    self.quantity = quantity
                    self.total = total
                    self.unitCost = unitCost
                }
            }
        }
    }

    public typealias Response = Transaction
}

// GET /v1/issuing/transactions
extension Transaction.List {
    public struct Request: Codable, Hashable, Sendable {
        /// Only return transactions that belong to the given card.
        public var card: String?
        /// Only return transactions that belong to the given cardholder.
        public var cardholder: String?
        /// Only return transactions that were created during the given date interval.
        public var created: Stripe.RangeQuery?
        /// A cursor for use in pagination.
        public var endingBefore: String?
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// A limit on the number of objects to be returned.
        public var limit: Int?
        /// A cursor for use in pagination.
        public var startingAfter: String?
        /// Only return transactions that have the given type.
        public var `type`: Type?

        public init(
            card: String? = nil,
            cardholder: String? = nil,
            created: Stripe.RangeQuery? = nil,
            endingBefore: String? = nil,
            expand: [String]? = nil,
            limit: Int? = nil,
            startingAfter: String? = nil,
            `type`: Type? = nil
        ) {
            self.card = card
            self.cardholder = cardholder
            self.created = created
            self.endingBefore = endingBefore
            self.expand = expand
            self.limit = limit
            self.startingAfter = startingAfter
            self.`type` = `type`
        }

        public enum `Type`: String, Codable, Hashable, Sendable {
            case capture
            case refund
        }
    }

    public typealias Response = Stripe.Page<Transaction>
}

// POST /v1/test_helpers/issuing/transactions/{transaction}/refund
extension Transaction.Refund {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// The total amount to attempt to refund.
        public var refundAmount: Int?

        public init(
            expand: [String]? = nil,
            refundAmount: Int? = nil
        ) {
            self.expand = expand
            self.refundAmount = refundAmount
        }
    }

    public typealias Response = Transaction
}

// GET /v1/issuing/transactions/{transaction}
extension Transaction.Retrieve {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?

        public init(
            expand: [String]? = nil
        ) {
            self.expand = expand
        }
    }

    public typealias Response = Transaction
}

// POST /v1/issuing/transactions/{transaction}
extension Transaction.Update {
    public struct Request: Codable, Hashable, Sendable {
        /// Specifies which fields in the response should be expanded.
        public var expand: [String]?
        /// Set of key-value pairs that you can attach to an object.
        public var metadata: Stripe.Clearable<[String: String]>?

        public init(
            expand: [String]? = nil,
            metadata: Stripe.Clearable<[String: String]>? = nil
        ) {
            self.expand = expand
            self.metadata = metadata
        }
    }

    public typealias Response = Transaction
}
