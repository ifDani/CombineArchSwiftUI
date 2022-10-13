//
//  ContentView.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView().navigationTitle("Descubre")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
