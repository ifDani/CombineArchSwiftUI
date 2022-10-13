//
//  Text.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//


import Foundation
import SwiftUI

extension Text {
    
    func nameBeer() -> some View {
        self.font(.system(size: 15))
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .tracking(-0.28)
            .lineLimit(2)
    }
    func boilData() -> some View {
        self.font(.system(size: 15))
            .fontWeight(.regular)
            .foregroundColor(.black)
            .tracking(-0.28)
            .lineLimit(2)
    }
    func chipText(size: CGFloat = 15,color: Color = .black) -> some View {
        self.font(.system(size: size))
            .foregroundColor(color)
            .fontWeight(.medium)
    }
        
    func titleBeer() -> some View {
        self.font(.system(size: 30))
            .fontWeight(.medium)
            .foregroundColor(.black)
    }
    
    func tagLine() -> some View {
        self.font(.system(size: 25))
            .fontWeight(.regular)
            .foregroundColor(.black)
    }
    
    func descriptionBeer(_ size: CGFloat = 13) -> some View {
        self.font(.system(size: size))
            .fontWeight(.light)
            .foregroundColor(.black)
    }
    
    func titleToolbar() -> some View {
        self.font(.system(size: 20))
            .fontWeight(.bold)
            .foregroundColor(.black)
            .tracking(-0.28)
    }
    
}
