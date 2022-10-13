//
//  DetailViewModel.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import Foundation
import Combine
final class DetailViewModel: ObservableObject {
    @Published var idBeer: Int = 1 
    @Published var status: StatusNetwork = .none
    @Published var beer: Beer = Beer(id: 0, name: "", tagline: "", firstBrewed: "", beerDescription: "")
    var subscription = Set<AnyCancellable>()
    
    
    func getBeer() {
        let request: URLRequest = BaseNetwork().getBeer(idBeer)
        
        
        self.status = .sending
        
        
        URLSession.shared
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
                case .failure(let errorString):
                    print(errorString)
                    self.status = .error
                case .finished:
                    print("success",request.url!)
                }
            } receiveValue: { response in
                self.status = .success
                if let first = response.first {
                    self.beer = first
                }
            }.store(in: &subscription)
    }
    
}
