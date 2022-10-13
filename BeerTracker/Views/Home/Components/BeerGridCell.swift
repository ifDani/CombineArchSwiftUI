//
//  BeerGridCell.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import SwiftUI

struct BeerGridCell: View {
    @State var beer: Beer
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).fill(Color.pinkApp).frame(minHeight: 200, maxHeight: 200)
            VStack {
                
                AsyncImage(
                    url: URL(string: beer.imageURL ?? ""),
                    content: { image in
                        image.resizable().aspectRatio(contentMode: .fit).frame(height: 125)
                    },
                    placeholder: {
                        ProgressView()
                    }
                ).frame(height: 125)
                Text(beer.name).nameBeer().padding(.top, 8)
            }.padding(.vertical, 15).padding(.horizontal, 8)
            
        }.padding(.horizontal)
    }
}

struct BeerGridCell_Previews: PreviewProvider {
    static var previews: some View {
        BeerGridCell(beer: Beer(id: 1, name: "test", tagline: "tagg", firstBrewed: "", beerDescription: ""))
    }
}
