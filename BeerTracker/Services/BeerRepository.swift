//
//  BeerRepository.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 13/10/22.
//

import Foundation
import Combine

class BeerRepository {
    
    private var network = BaseNetwork()
    
    func getBeers(page: Int, food: String, queryItems: [URLQueryItem]) -> any Publisher<Beers, any Error> {
        
        let request: URLRequest = network.getBeers(page: page, food: food, queryItems: queryItems)
        
        let beerCall = network.callApi(request).decode(type: Beers.self, decoder: JSONDecoder())
        
        return beerCall
        
    }
    
    func getBeer(beer: Beer) -> any Publisher<Beers, any Error> {
        
        let request: URLRequest = network.getBeer(beer)
        
        let beerCall = network.callApi(request).decode(type: Beers.self, decoder: JSONDecoder())
        //            .catch({ (_) -> AnyPublisher<T, NetworkError> in
        //                        return Empty<T, NetworkError>().eraseToAnyPublisher()
        //                    })
            .eraseToAnyPublisher()

        return beerCall
            
    }
}
