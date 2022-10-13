//
//  Chip.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import Foundation

struct ChipModel: Identifiable {
    let id = UUID()
    var isSelected: Bool
    let title: String
    let queryItem: URLQueryItem?
}
