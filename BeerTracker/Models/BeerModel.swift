//
//  BeerModel.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import Foundation

// MARK: - BeerElement
struct Beer: Codable, Identifiable {
    let id: Int
    let name, tagline, firstBrewed, beerDescription: String
    let imageURL: String?
    let abv: Double?
    let ibu: Double?
    let targetFg: Int?
    let targetOg: Double?
    let ebc: Double?
    let srm, ph: Double?
    let attenuationLevel: Double?
    let volume, boilVolume: BoilVolume?
    let method: Method?
    let ingredients: Ingredients?
    let foodPairing: [String]?
    let brewersTips: String?
    let contributedBy: String?

    enum CodingKeys: String, CodingKey {
        case id, name, tagline
        case firstBrewed = "first_brewed"
        case beerDescription = "description"
        case imageURL = "image_url"
        case abv, ibu
        case targetFg = "target_fg"
        case targetOg = "target_og"
        case ebc, srm, ph
        case attenuationLevel = "attenuation_level"
        case volume
        case boilVolume = "boil_volume"
        case method, ingredients
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
    }
    
    init(id: Int, name: String, tagline: String, firstBrewed: String, beerDescription: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.beerDescription = beerDescription
        self.imageURL = nil
        self.abv = nil
        self.ibu = nil
        self.targetFg = nil
        self.targetOg = nil
        self.ebc = nil
        self.srm = nil
        self.ph = nil
        self.attenuationLevel = nil
        self.volume = nil
        self.boilVolume = nil
        self.method = nil
        self.ingredients = nil
        self.foodPairing = nil
        self.brewersTips = nil
        self.contributedBy = nil
    }
    
    init(id: Int, name: String, tagline: String, firstBrewed: String, beerDescription: String, imageURL: String?, abv: Double?, ibu: Double?, targetFg: Int?, targetOg: Double?, ebc: Double?, srm: Double?, ph: Double?, attenuationLevel: Double?, volume: BoilVolume?, boilVolume: BoilVolume?, method: Method?, ingredients: Ingredients?, foodPairing: [String]?, brewersTips: String?, contributedBy: String?) {
        self.id = id
        self.name = name
        self.tagline = tagline
        self.firstBrewed = firstBrewed
        self.beerDescription = beerDescription
        self.imageURL = imageURL
        self.abv = abv
        self.ibu = ibu
        self.targetFg = targetFg
        self.targetOg = targetOg
        self.ebc = ebc
        self.srm = srm
        self.ph = ph
        self.attenuationLevel = attenuationLevel
        self.volume = volume
        self.boilVolume = boilVolume
        self.method = method
        self.ingredients = ingredients
        self.foodPairing = foodPairing
        self.brewersTips = brewersTips
        self.contributedBy = contributedBy
    }
}

// MARK: - BoilVolume
struct BoilVolume: Codable {
    let value: Double?
    let unit: String?
}

// MARK: - Ingredients
struct Ingredients: Codable {
    let malt: [Malt]?
    let hops: [Hop]?
    let yeast: String?
}

// MARK: - Hop
struct Hop: Codable {
    let name: String?
    let amount: BoilVolume?
    let add: String
    let attribute: String?
}

// MARK: - Malt
struct Malt: Codable {
    let name: String?
    let amount: BoilVolume?
}

// MARK: - Method
struct Method: Codable {
    let mashTemp: [MashTemp]?
    let fermentation: Fermentation?
    let twist: String?

    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation, twist
    }
}

// MARK: - Fermentation
struct Fermentation: Codable {
    let temp: BoilVolume?
}

// MARK: - MashTemp
struct MashTemp: Codable {
    let temp: BoilVolume?
    let duration: Int?
}

typealias Beers = [Beer]
