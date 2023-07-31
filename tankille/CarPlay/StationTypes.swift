//
//  StationTypes.swift
//  tankille
//
//  Created by Leevi Aattola on 28.7.2023.
//

import Foundation

// MARK: - StationElement
struct StationElement: Codable {
    let address: Address
    let location: Location
    let fuels: [String]
    let isVisible: Bool
    let id, name: String
    let chain: String
    let brand: String
    let price: [Price]
    let updated: String

    enum CodingKeys: String, CodingKey {
        case address, location, fuels, isVisible
        case id
        case name, chain, brand, price
        case updated
    }
}

// MARK: - Address
struct Address: Codable {
    let street: String
    let city: City
    let zipcode: String
    let country: Country
}

enum City: String, Codable {
    case kangasala = "Kangasala"
    case lempäälä = "Lempäälä"
    case pirkkala = "Pirkkala"
    case ruutana = "Ruutana"
    case tampere = "Tampere"
}

enum Country: String, Codable {
    case finland = "Finland"
}

// MARK: - Location
struct Location: Codable {
    let type: TypeEnum
    let coordinates: [Double]
}

enum TypeEnum: String, Codable {
    case point = "Point"
}

// MARK: - Price
struct Price: Codable {
    let id, tag: String
    let price: Double
    let updated: String
    let delta: Double
    let reporter: String

    enum CodingKeys: String, CodingKey {
        case id
        case tag, price, updated, delta, reporter
    }
}

typealias Stations = [StationElement]
