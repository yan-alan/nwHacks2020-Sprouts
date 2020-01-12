//
//  Plant.swift
//  Sprouts
//
//  Created by Alan Yan on 2020-01-11.
//  Copyright © 2020 Alan Yan. All rights reserved.
//

import Foundation

struct Plant {
    init() {
        
    }
}

//credit Quicktype

// MARK: - DetailPlantData
struct DetailPlantData: Codable {
    let year: JSONNull?
    let type: String
    let synonym: Bool
    let status: String
    let specifications: Specifications
    let sources: [Source]
    let soilsAdaptation: SoilsAdaptation
    let slug: String
    let seed: Seed
    let scientificName: String
    let propagation: Propagation
    let products: Products
    let nativeStatus: String
    let mainSpeciesID: JSONNull?
    let isMainSpecies: Bool
    let images: [Image]
    let id: Int
    let growth: Growth
    let fruitOrSeed: FruitOrSeed
    let foliage: Foliage
    let flower: Flower
    let familyCommonName, duration: String
    let completeData: Bool
    let commonName: String
    let bibliography, author: JSONNull?

    enum CodingKeys: String, CodingKey {
        case year, type, synonym, status, specifications, sources
        case soilsAdaptation = "soils_adaptation"
        case slug, seed
        case scientificName = "scientific_name"
        case propagation, products
        case nativeStatus = "native_status"
        case mainSpeciesID = "main_species_id"
        case isMainSpecies = "is_main_species"
        case images, id, growth
        case fruitOrSeed = "fruit_or_seed"
        case foliage, flower
        case familyCommonName = "family_common_name"
        case duration
        case completeData = "complete_data"
        case commonName = "common_name"
        case bibliography, author
    }
}

// MARK: - Flower
struct Flower: Codable {
    let conspicuous: Bool
    let color: String
}

// MARK: - Foliage
struct Foliage: Codable {
    let texture, porosityWinter, porositySummer, color: String

    enum CodingKeys: String, CodingKey {
        case texture
        case porosityWinter = "porosity_winter"
        case porositySummer = "porosity_summer"
        case color
    }
}

// MARK: - FruitOrSeed
struct FruitOrSeed: Codable {
    let seedPersistence: JSONNull?
    let seedPeriodEnd, seedPeriodBegin, seedAbundance: String
    let conspicuous: JSONNull?
    let color: String

    enum CodingKeys: String, CodingKey {
        case seedPersistence = "seed_persistence"
        case seedPeriodEnd = "seed_period_end"
        case seedPeriodBegin = "seed_period_begin"
        case seedAbundance = "seed_abundance"
        case conspicuous, color
    }
}

// MARK: - Growth
struct Growth: Codable {
    let temperatureMinimum: TemperatureMinimum
    let shadeTolerance, salinityTolerance: String
    let rootDepthMinimum: Imum
    let resproutAbility: JSONNull?
    let precipitationMinimum, precipitationMaximum: Imum
    let plantingDensityMinimum, plantingDensityMaximum: PlantingDensityMimum
    let phMinimum, phMaximum: Int
    let moistureUse, hedgeTolerance: String
    let frostFreeDaysMinimum: Int
    let fireTolerance, fertilityRequirement, droughtTolerance: String
    let coldStratificationRequired: Bool
    let caco3_Tolerance, anaerobicTolerance: String

    enum CodingKeys: String, CodingKey {
        case temperatureMinimum = "temperature_minimum"
        case shadeTolerance = "shade_tolerance"
        case salinityTolerance = "salinity_tolerance"
        case rootDepthMinimum = "root_depth_minimum"
        case resproutAbility = "resprout_ability"
        case precipitationMinimum = "precipitation_minimum"
        case precipitationMaximum = "precipitation_maximum"
        case plantingDensityMinimum = "planting_density_minimum"
        case plantingDensityMaximum = "planting_density_maximum"
        case phMinimum = "ph_minimum"
        case phMaximum = "ph_maximum"
        case moistureUse = "moisture_use"
        case hedgeTolerance = "hedge_tolerance"
        case frostFreeDaysMinimum = "frost_free_days_minimum"
        case fireTolerance = "fire_tolerance"
        case fertilityRequirement = "fertility_requirement"
        case droughtTolerance = "drought_tolerance"
        case coldStratificationRequired = "cold_stratification_required"
        case caco3_Tolerance = "caco_3_tolerance"
        case anaerobicTolerance = "anaerobic_tolerance"
    }
}

// MARK: - PlantingDensityMimum
struct PlantingDensityMimum: Codable {
    let sqm, acre: Int
}

// MARK: - Imum
struct Imum: Codable {
    let inches: Int
    let cm: Double
}

// MARK: - TemperatureMinimum
struct TemperatureMinimum: Codable {
    let degF: Int
    let degC: Double

    enum CodingKeys: String, CodingKey {
        case degF = "deg_f"
        case degC = "deg_c"
    }
}

// MARK: - Image
struct Image: Codable {
    let url: String
}

// MARK: - Products
struct Products: Codable {
    let veneer, pulpwood: JSONNull?
    let proteinPotential: String
    let post: JSONNull?
    let palatableHuman: Bool
    let palatableGrazeAnimal, palatableBrowseAnimal: String
    let nurseryStock, navalStore, lumber, fuelwood: JSONNull?
    let fodder, christmasTree, berryNutSeed: JSONNull?

    enum CodingKeys: String, CodingKey {
        case veneer, pulpwood
        case proteinPotential = "protein_potential"
        case post
        case palatableHuman = "palatable_human"
        case palatableGrazeAnimal = "palatable_graze_animal"
        case palatableBrowseAnimal = "palatable_browse_animal"
        case nurseryStock = "nursery_stock"
        case navalStore = "naval_store"
        case lumber, fuelwood, fodder
        case christmasTree = "christmas_tree"
        case berryNutSeed = "berry_nut_seed"
    }
}

// MARK: - Propagation
struct Propagation: Codable {
    let tubers, sprigs, sod: JSONNull?
    let seed: Bool
    let cuttings, corms: JSONNull?
    let container, bulbs: Bool
    let bareRoot: JSONNull?

    enum CodingKeys: String, CodingKey {
        case tubers, sprigs, sod, seed, cuttings, corms, container, bulbs
        case bareRoot = "bare_root"
    }
}

// MARK: - Seed
struct Seed: Codable {
    let vegetativeSpreadRate: String
    let smallGrain: JSONNull?
    let seedsPerPound: Int
    let seedlingVigor, seedSpreadRate, commercialAvailability, bloomPeriod: String

    enum CodingKeys: String, CodingKey {
        case vegetativeSpreadRate = "vegetative_spread_rate"
        case smallGrain = "small_grain"
        case seedsPerPound = "seeds_per_pound"
        case seedlingVigor = "seedling_vigor"
        case seedSpreadRate = "seed_spread_rate"
        case commercialAvailability = "commercial_availability"
        case bloomPeriod = "bloom_period"
    }
}

// MARK: - SoilsAdaptation
struct SoilsAdaptation: Codable {
    let medium: Bool
    let fine: JSONNull?
    let coarse: Bool
}

// MARK: - Source
struct Source: Codable {
    let speciesID: Int
    let sourceURL: String
    let name, lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case speciesID = "species_id"
        case sourceURL = "source_url"
        case name
        case lastUpdate = "last_update"
    }
}

// MARK: - Specifications
struct Specifications: Codable {
    let toxicity, shapeAndOrientation, regrowthRate, nitrogenFixation: String
    let maxHeightAtBaseAge, matureHeight: MatureHeight
    let lowGrowingGrass: JSONNull?
    let lifespan: String
    let leafRetention, knownAllelopath: JSONNull?
    let growthRate, growthPeriod, growthHabit, growthForm: String
    let fireResistance: Bool
    let fallConspicuous, coppicePotential: JSONNull?
    let cNRatio, bloat: String

    enum CodingKeys: String, CodingKey {
        case toxicity
        case shapeAndOrientation = "shape_and_orientation"
        case regrowthRate = "regrowth_rate"
        case nitrogenFixation = "nitrogen_fixation"
        case maxHeightAtBaseAge = "max_height_at_base_age"
        case matureHeight = "mature_height"
        case lowGrowingGrass = "low_growing_grass"
        case lifespan
        case leafRetention = "leaf_retention"
        case knownAllelopath = "known_allelopath"
        case growthRate = "growth_rate"
        case growthPeriod = "growth_period"
        case growthHabit = "growth_habit"
        case growthForm = "growth_form"
        case fireResistance = "fire_resistance"
        case fallConspicuous = "fall_conspicuous"
        case coppicePotential = "coppice_potential"
        case cNRatio = "c_n_ratio"
        case bloat
    }
}

// MARK: - MatureHeight
struct MatureHeight: Codable {
    let ft: Int?
    let cm: Double?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
