//
//  Constants.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 13/10/22.
//

import Foundation


let CHIPS = [ChipModel(isSelected: true, title: "All", queryItem: nil),ChipModel(isSelected: false, title: "+ABV", queryItem: URLQueryItem(name: "abv_gt", value: "16")), ChipModel(isSelected: false, title: "Bitter", queryItem: URLQueryItem(name: "ibu_gt", value: "100"))]
