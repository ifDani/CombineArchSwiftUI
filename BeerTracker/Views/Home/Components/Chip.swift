//
//  Chip.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import SwiftUI

struct Chip: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var chip: ChipModel
    var body: some View {
        //Lets make a iOS14 compatible chip
        ZStack {
            RoundedRectangle(cornerRadius: 12).fill(chip.isSelected ? Color.pinkApp : Color.clear)
            Text(chip.title).chipText(color: chip.isSelected ? .black : (colorScheme == .dark ? .white : .black)).padding(6)
        }.fixedSize().onTapGesture {
            chip.isSelected.toggle()
        }
    }
}
