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
    @Published var beer: Beer?
    private var network = BaseNetwork()
    
    var beersSubscription: AnyCancellable?
    
    func getBeers(page: Int, food: String, queryItems: [URLQueryItem]) -> any Publisher<Beers, any Error> {
        
        let request: URLRequest = network.getBeers(page: page, food: food, queryItems: queryItems)
        
        let beerCall = network.callApi(request).decode(type: Beers.self, decoder: JSONDecoder()).eraseToAnyPublisher()
        
        return beerCall
        
    }
    
    func getBeer(beer: Beer) {
        
        let request: URLRequest = network.getBeer(beer)
        
        beersSubscription = network.callApi(request)
            .decode(type: Beers.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { response in
                if let first = response.first {
                    self.beer = first
                }
                self.beersSubscription?.cancel()
            }
    }
}
