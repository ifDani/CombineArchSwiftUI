//
//  DetailView.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var detailViewModel : DetailViewModel

    init(beer: Beer) {
        _detailViewModel = StateObject(wrappedValue: DetailViewModel(beer: beer))
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Color.pinkApp.edgesIgnoringSafeArea(.top)
                    ToolbarBack(titleView: "Detalle")
                }.frame(height: 50)
                
                VStack{
                    HStack(spacing: 50) {
                        
                        //Info alcohol
                        ZStack {
                            Rectangle().fill(Color.pinkApp).cornerRadius(50, corners: [.topLeft, .bottomLeft, .bottomRight])
                            VStack {
                                Image(systemName: "lines.measurement.horizontal").foregroundColor(.black).padding(.top)
                                Text("Volume").boilData()
                                Text("\(String(format: "%g", detailViewModel.beer.volume?.value ?? 0))%").boilData().padding(.bottom, 5)
                                
                                Image(systemName: "drop").foregroundColor(.black)
                                Text("Alcohol").boilData()
                                Text("\(String(format: "%g", detailViewModel.beer.abv ?? 0))%").boilData().padding(.bottom, 5)
                            }.padding()
                        }.fixedSize()
                        
                        
                        ZStack {
                            Circle().fill(Color.pinkApp).frame(width: 140, height: 140)
                            AsyncImage(
                                url: URL(string: detailViewModel.beer.imageURL ?? ""),
                                content: { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 200)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            ).frame(height: 200)
                        }

                    }.padding(.top)
                    //Content info
                    ZStack {
                        RoundedRectangle(cornerRadius: 12).fill(Color.pinkApp.opacity(0.9))
                        VStack(alignment: .leading){
                            Text(detailViewModel.beer.name).titleBeer()
                            Text(detailViewModel.beer.tagline).tagLine()
                            Text(detailViewModel.beer.beerDescription).descriptionBeer()
                        }.padding(.vertical).padding()

                    }.fixedSize(horizontal: false, vertical: true).padding(.top)
                }
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }.background(Color.white)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(beer: Beer(id: 1, name: "name", tagline: "tagline", firstBrewed: "brewwde", beerDescription: "desc"))
    }
}
