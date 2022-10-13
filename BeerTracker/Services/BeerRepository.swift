//
//  BeerRepository.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 13/10/22.
//

import Foundation
import Combine

class BeerRepository {
    
    @Published var beers: Beers = []
    @Published var beer: Beer = Beer(id: 0, name: "", tagline: "", firstBrewed: "", beerDescription: "")
    
    var beersSubscription: AnyCancellable?
    
     func getBeers(page: Int, food: String, queryItems: [URLQueryItem]) {
        
        let request: URLRequest = BaseNetwork().getBeers(page: page, food: food, queryItems: queryItems)
        
        beersSubscription = URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap{
                guard let response = $0.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    
                    throw URLError(.badServerResponse)
                }
                return $0.data
            }
            .decode(type: Beers.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                self.beers = response
                self.beersSubscription?.cancel()
            }
        
    }
}
