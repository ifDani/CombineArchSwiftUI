//
//  HomeView.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel : HomeViewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            if let beers = homeViewModel.beers {
                
                //Chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(homeViewModel.chips.indices, id: \.self) { index in
                            Chip(chip: $homeViewModel.chips[index])
                        }
                    }.padding(.horizontal)
                }.padding(.vertical)
                
                //Content
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack {
                            switch (homeViewModel.status) {
                            case .success, .none:
                                if !beers.isEmpty {
                                    LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                                        
                                        ForEach(Array(zip(beers.indices, beers)), id: \.0) { index, beer in
                                            NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(beer: beer)).navigationBarHidden(true)) {
                                                BeerGridCell(beer: beer)
                                            }.onAppear{
                                                let max = ((14 * (homeViewModel.currentPage)) - 4)
                                                // We change page if there are 4 left to the end of the list
                                                if index >= max{
                                                    if homeViewModel.lastPage != max {
                                                        homeViewModel.lastPage = max
                                                        homeViewModel.currentPage += 1
                                                        //Call viewModel
                                                        homeViewModel.getAllBeers(isPaging: true)
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                } else {
                                    noDataView
                                }
                            case .error:
                                noDataView
                            case .sending:
                                ProgressView().padding(.top)
                            }

                        }.searchable(text: $homeViewModel.food, placement: .navigationBarDrawer(displayMode: .always))
                            .onChange(of: homeViewModel.food) { _ in
                                withAnimation {
                                    proxy.scrollTo(1)
                                }
                            }
                    }
                }.onAppear {
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
                }
            }
        }
    }
}

var noDataView: some View {
    VStack {
        Image("broken_bottle").resizable().aspectRatio(contentMode: .fill).frame(maxHeight: 200)
        Text("No hay datos...")
    }.padding(.top)
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
