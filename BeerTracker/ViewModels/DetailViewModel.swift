//
//  DetailViewModel.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 11/10/22.
//

import Foundation
import Combine
final class DetailViewModel: ObservableObject {
    
    @Published var status: StatusNetwork = .none
    
    @Published var beer: Beer
    
    private let bRepository: BeerRepository = BeerRepository()
    
    var subscription = Set<AnyCancellable>()
    
    init(beer: Beer) {
        self.beer = beer
        
        getBeer()
        
        addSubscribers()
    }
    
    func addSubscribers() {
        bRepository.$beer
            .sink { completion in
                switch completion{
                case .failure(let errorString):
                    print(errorString)
                    self.status = .error
                case .finished:
                    break
                }
            } receiveValue: { beer in
                self.status = .success
                guard let beer = beer else {return}
                self.beer = beer
            }.store(in: &subscription)
    }
    
    func getBeer() {
        self.status = .sending
        bRepository.getBeer(beer: beer)
    }
    
}
