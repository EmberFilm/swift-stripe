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

/// You can create physical or virtual cards that are issued to cardholders.
public struct IssuingCard: Codable, Hashable, Sendable, Identifiable {
    public typealias ID = String
    public let id: ID
    /// String representing the object's type.
    public let object: String
    /// The brand of the card.
    public var brand: String?
    /// The reason why the card was canceled.
    public var cancellationReason: CancellationReason?
    @Boxed public var cardholder: Cardholder?
    /// Time at which the object was created.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase.
    public var currency: Stripe.Currency?
    /// The card's CVC.
    public var cvc: String?
    /// The expiration month of the card.
    public var expMonth: Int?
    /// The expiration year of the card.
    public var expYear: Int?
    /// The financial account this card is attached to.
    public var financialAccount: String?
    /// The last 4 digits of the card number.
    public var last4: String?
    /// Stripe’s assessment of whether this card’s details have been compromised.
    public var latestFraudWarning: LatestFraudWarning?
    /// Rules that control the lifecycle of this card, such as automatic cancellation.
    public var lifecycleControls: LifecycleControls?
    /// If the object exists in live mode, the value is `true`.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object.
    public var metadata: [String: String]?
    /// The full unredacted card number.
    public var number: String?
    /// The personalization design object belonging to this card.
    @Expandable<Stripe.Issuing.PersonalizationDesign, String> public var personalizationDesign: String?
    /// The latest card that replaces this card, if any.
    @Expandable<IssuingCard, String> public var replacedBy: String?
    /// The card this card replaces, if any.
    @Expandable<IssuingCard, String> public var replacementFor: String?
    /// The reason why the previous card needed to be replaced.
    public var replacementReason: ReplacementReason?
    /// Text separate from cardholder name, printed on the card.
    public var secondLine: String?
    /// Where and how the card will be shipped.
    public var shipping: Shipping?
    public var spendingControls: SpendingControls?
    /// Whether authorizations can be approved on this card.
    public var status: Status?
    /// The type of the card.
    public var `type`: Type?
    /// Information relating to digital wallets (like Apple Pay and Google Pay).
    public var wallets: Wallets?

    public init(
        id: ID,
        object: String,
        brand: String? = nil,
        cancellationReason: CancellationReason? = nil,
        cardholder: Cardholder? = nil,
        created: Date? = nil,
        currency: Stripe.Currency? = nil,
        cvc: String? = nil,
        expMonth: Int? = nil,
        expYear: Int? = nil,
        financialAccount: String? = nil,
        last4: String? = nil,
        latestFraudWarning: LatestFraudWarning? = nil,
        lifecycleControls: LifecycleControls? = nil,
        livemode: Bool? = nil,
        metadata: [String: String]? = nil,
        number: String? = nil,
        personalizationDesign: String? = nil,
        replacedBy: String? = nil,
        replacementFor: String? = nil,
        replacementReason: ReplacementReason? = nil,
        secondLine: String? = nil,
        shipping: Shipping? = nil,
        spendingControls: SpendingControls? = nil,
        status: Status? = nil,
        `type`: Type? = nil,
        wallets: Wallets? = nil
    ) {
        self.id = id
        self.object = object
        self.brand = brand
        self.cancellationReason = cancellationReason
        self._cardholder = Boxed(wrappedValue: cardholder)
        self.created = created
        self.currency = currency
        self.cvc = cvc
        self.expMonth = expMonth
        self.expYear = expYear
        self.financialAccount = financialAccount
        self.last4 = last4
        self.latestFraudWarning = latestFraudWarning
        self.lifecycleControls = lifecycleControls
        self.livemode = livemode
        self.metadata = metadata
        self.number = number
        self._personalizationDesign = Expandable(id: personalizationDesign)
        self._replacedBy = Expandable(id: replacedBy)
        self._replacementFor = Expandable(id: replacementFor)
        self.replacementReason = replacementReason
        self.secondLine = secondLine
        self.shipping = shipping
        self.spendingControls = spendingControls
        self.status = status
        self.`type` = `type`
        self.wallets = wallets
    }

    /// The reason why the card was canceled.
    public enum CancellationReason: String, Codable, Hashable, Sendable {
        case designRejected = "design_rejected"
        case fulfillmentError = "fulfillment_error"
        case lost
        case stolen
    }

    /// The reason why the previous card needed to be replaced.
    public enum ReplacementReason: String, Codable, Hashable, Sendable {
        case damaged
        case expired
        case fulfillmentError = "fulfillment_error"
        case lost
        case stolen
    }

    /// Whether authorizations can be approved on this card.
    public enum Status: String, Codable, Hashable, Sendable {
        case active
        case canceled
        case inactive
    }

    /// The type of the card.
    public enum `Type`: String, Codable, Hashable, Sendable {
        case physical
        case virtual
    }

    public struct LatestFraudWarning: Codable, Hashable, Sendable {
        /// Timestamp of the most recent fraud warning.
        public var startedAt: Date?
        /// The type of fraud warning that most recently took place on this card.
        public var `type`: Type?

        public init(
            startedAt: Date? = nil,
            `type`: Type? = nil
        ) {
            self.startedAt = startedAt
            self.`type` = `type`
        }

        /// The type of fraud warning that most recently took place on this card.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case cardTestingExposure = "card_testing_exposure"
            case fraudDisputeFiled = "fraud_dispute_filed"
            case thirdPartyReported = "third_party_reported"
            case userIndicatedFraud = "user_indicated_fraud"
        }
    }

    public struct LifecycleControls: Codable, Hashable, Sendable {
        public var cancelAfter: CancelAfter?

        public init(
            cancelAfter: CancelAfter? = nil
        ) {
            self.cancelAfter = cancelAfter
        }

        public struct CancelAfter: Codable, Hashable, Sendable {
            /// The card is automatically cancelled when it makes this number of non-zero payment authorizations and transactions.
            public var paymentCount: Int?

            public init(
                paymentCount: Int? = nil
            ) {
                self.paymentCount = paymentCount
            }
        }
    }

    public struct Shipping: Codable, Hashable, Sendable {
        public var address: Address?
        /// Address validation details for the shipment.
        public var addressValidation: AddressValidation?
        /// The name of the business at the shipping address, used on the shipping label to ensure delivery when the card is.
        public var businessName: String?
        /// The delivery company that shipped a card.
        public var carrier: Carrier?
        /// Additional information that may be required for clearing customs.
        public var customs: Customs?
        /// A unix timestamp representing a best estimate of when the card will be delivered.
        public var eta: Date?
        /// Recipient name.
        public var name: String?
        /// The phone number of the receiver of the shipment.
        public var phoneNumber: String?
        /// Whether a signature is required for card delivery.
        public var requireSignature: Bool?
        /// Shipment service, such as `standard` or `express`.
        public var service: Service?
        /// The delivery status of the card.
        public var status: Status?
        /// A tracking number for a card shipment.
        public var trackingNumber: String?
        /// A link to the shipping carrier's site where you can view detailed information about a card shipment.
        public var trackingUrl: String?
        /// Packaging options.
        public var `type`: Type?

        public init(
            address: Address? = nil,
            addressValidation: AddressValidation? = nil,
            businessName: String? = nil,
            carrier: Carrier? = nil,
            customs: Customs? = nil,
            eta: Date? = nil,
            name: String? = nil,
            phoneNumber: String? = nil,
            requireSignature: Bool? = nil,
            service: Service? = nil,
            status: Status? = nil,
            trackingNumber: String? = nil,
            trackingUrl: String? = nil,
            `type`: Type? = nil
        ) {
            self.address = address
            self.addressValidation = addressValidation
            self.businessName = businessName
            self.carrier = carrier
            self.customs = customs
            self.eta = eta
            self.name = name
            self.phoneNumber = phoneNumber
            self.requireSignature = requireSignature
            self.service = service
            self.status = status
            self.trackingNumber = trackingNumber
            self.trackingUrl = trackingUrl
            self.`type` = `type`
        }

        /// The delivery company that shipped a card.
        public enum Carrier: String, Codable, Hashable, Sendable {
            case correos
            case dhl
            case fedex
            case royalMail = "royal_mail"
            case usps
        }

        /// Shipment service, such as `standard` or `express`.
        public enum Service: String, Codable, Hashable, Sendable {
            case express
            case priority
            case standard
        }

        /// The delivery status of the card.
        public enum Status: String, Codable, Hashable, Sendable {
            case canceled
            case delivered
            case failure
            case pending
            case returned
            case shipped
            case submitted
        }

        /// Packaging options.
        public enum `Type`: String, Codable, Hashable, Sendable {
            case bulk
            case individual
        }

        public struct AddressValidation: Codable, Hashable, Sendable {
            /// The address validation capabilities to use.
            public var mode: Mode?
            /// The normalized shipping address.
            public var normalizedAddress: Address?
            /// The validation result for the shipping address.
            public var result: Result?

            public init(
                mode: Mode? = nil,
                normalizedAddress: Address? = nil,
                result: Result? = nil
            ) {
                self.mode = mode
                self.normalizedAddress = normalizedAddress
                self.result = result
            }

            /// The address validation capabilities to use.
            public enum Mode: String, Codable, Hashable, Sendable {
                case disabled
                case normalizationOnly = "normalization_only"
                case validationAndNormalization = "validation_and_normalization"
            }

            /// The validation result for the shipping address.
            public enum Result: String, Codable, Hashable, Sendable {
                case indeterminate
                case likelyDeliverable = "likely_deliverable"
                case likelyUndeliverable = "likely_undeliverable"
            }
        }

        public struct Customs: Codable, Hashable, Sendable {
            /// A registration number used for customs in Europe.
            public var eoriNumber: String?

            public init(
                eoriNumber: String? = nil
            ) {
                self.eoriNumber = eoriNumber
            }
        }
    }

    public struct SpendingControls: Codable, Hashable, Sendable {
        /// Array of card presence statuses from which authorizations will be allowed.
        public var allowedCardPresences: [AllowedCardPresences]?
        /// Array of strings containing categories of authorizations to allow.
        public var allowedCategories: [AllowedCategories]?
        /// Array of strings containing representing countries from which authorizations will be allowed.
        public var allowedMerchantCountries: [String]?
        /// Array of card presence statuses from which authorizations will be declined.
        public var blockedCardPresences: [BlockedCardPresences]?
        /// Array of strings containing categories of authorizations to decline.
        public var blockedCategories: [BlockedCategories]?
        /// Array of strings containing representing countries from which authorizations will be declined.
        public var blockedMerchantCountries: [String]?
        /// Limit spending with amount-based rules that apply across any cards this card replaced (i.e., its `replacement_for`.
        public var spendingLimits: [SpendingLimits]?
        /// Currency of the amounts within `spending_limits`.
        public var spendingLimitsCurrency: Stripe.Currency?

        public init(
            allowedCardPresences: [AllowedCardPresences]? = nil,
            allowedCategories: [AllowedCategories]? = nil,
            allowedMerchantCountries: [String]? = nil,
            blockedCardPresences: [BlockedCardPresences]? = nil,
            blockedCategories: [BlockedCategories]? = nil,
            blockedMerchantCountries: [String]? = nil,
            spendingLimits: [SpendingLimits]? = nil,
            spendingLimitsCurrency: Stripe.Currency? = nil
        ) {
            self.allowedCardPresences = allowedCardPresences
            self.allowedCategories = allowedCategories
            self.allowedMerchantCountries = allowedMerchantCountries
            self.blockedCardPresences = blockedCardPresences
            self.blockedCategories = blockedCategories
            self.blockedMerchantCountries = blockedMerchantCountries
            self.spendingLimits = spendingLimits
            self.spendingLimitsCurrency = spendingLimitsCurrency
        }

        public enum AllowedCardPresences: String, Codable, Hashable, Sendable {
            case notPresent = "not_present"
            case present
        }

        public enum AllowedCategories: String, Codable, Hashable, Sendable {
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
            case miscellaneous
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

        public enum BlockedCardPresences: String, Codable, Hashable, Sendable {
            case notPresent = "not_present"
            case present
        }

        public enum BlockedCategories: String, Codable, Hashable, Sendable {
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
            case miscellaneous
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

        public struct SpendingLimits: Codable, Hashable, Sendable {
            /// Maximum amount allowed to spend per interval.
            public var amount: Int?
            /// Array of strings containing categories this limit applies to.
            public var categories: [Categories]?
            /// Interval (or event) to which the amount applies.
            public var interval: Interval?

            public init(
                amount: Int? = nil,
                categories: [Categories]? = nil,
                interval: Interval? = nil
            ) {
                self.amount = amount
                self.categories = categories
                self.interval = interval
            }

            public enum Categories: String, Codable, Hashable, Sendable {
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
                case miscellaneous
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

            /// Interval (or event) to which the amount applies.
            public enum Interval: String, Codable, Hashable, Sendable {
                case allTime = "all_time"
                case daily
                case monthly
                case perAuthorization = "per_authorization"
                case weekly
                case yearly
            }
        }
    }

    public struct Wallets: Codable, Hashable, Sendable {
        public var applePay: ApplePay?
        public var googlePay: GooglePay?
        /// Unique identifier for a card used with digital wallets.
        public var primaryAccountIdentifier: String?

        public init(
            applePay: ApplePay? = nil,
            googlePay: GooglePay? = nil,
            primaryAccountIdentifier: String? = nil
        ) {
            self.applePay = applePay
            self.googlePay = googlePay
            self.primaryAccountIdentifier = primaryAccountIdentifier
        }

        public struct ApplePay: Codable, Hashable, Sendable {
            /// Apple Pay Eligibility.
            public var eligible: Bool?
            /// Reason the card is ineligible for Apple Pay.
            public var ineligibleReason: IneligibleReason?

            public init(
                eligible: Bool? = nil,
                ineligibleReason: IneligibleReason? = nil
            ) {
                self.eligible = eligible
                self.ineligibleReason = ineligibleReason
            }

            /// Reason the card is ineligible for Apple Pay.
            public enum IneligibleReason: String, Codable, Hashable, Sendable {
                case missingAgreement = "missing_agreement"
                case missingCardholderContact = "missing_cardholder_contact"
                case unsupportedRegion = "unsupported_region"
            }
        }

        public struct GooglePay: Codable, Hashable, Sendable {
            /// Google Pay Eligibility.
            public var eligible: Bool?
            /// Reason the card is ineligible for Google Pay.
            public var ineligibleReason: IneligibleReason?

            public init(
                eligible: Bool? = nil,
                ineligibleReason: IneligibleReason? = nil
            ) {
                self.eligible = eligible
                self.ineligibleReason = ineligibleReason
            }

            /// Reason the card is ineligible for Google Pay.
            public enum IneligibleReason: String, Codable, Hashable, Sendable {
                case missingAgreement = "missing_agreement"
                case missingCardholderContact = "missing_cardholder_contact"
                case unsupportedRegion = "unsupported_region"
            }
        }
    }
}
