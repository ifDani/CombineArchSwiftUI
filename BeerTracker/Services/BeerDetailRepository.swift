//
//  BeerDetailRepository.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 13/10/22.
//

import Foundation
import Combine

class BeerDetailRepository {
    
    @Published var beer: Beer

    var beerSubscription: AnyCancellable?

    
    init(beer: Beer) {
        self.beer = beer
    }
    
    func getBeer() {
        let request: URLRequest = BaseNetwork().getBeer(beer)
        
        beerSubscription = URLSession.shared
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
                if let first = response.first {
                    self.beer = first
                }
                self.beerSubscription?.cancel()
            }
    }
}
