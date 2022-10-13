//
//  HomeViewModel.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var food: String = "" //Text to search in the api
    @Published var status: StatusNetwork = .none
    @Published var currentPage: Int = 1
    //This is to avoid unnecesary calls if we already have called that page
    @Published var lastPage: Int = 0
    //Default chip filters
    @Published var chips: [ChipModel] = CHIPS
    @Published var queryItems: [URLQueryItem] = []
    @Published var beers: Beers = []
    @Published var isPaging = false
    
    var subscription = Set<AnyCancellable>()
    
    //Repository
    private let repository = BeerRepository()
    
    init() {
        addBeersSubscriber()
        
        //Search by food parameter logic and prevent multiple requests
        addFoodObserver()
        
        //Listen changes of chips array (detect selections)
        addFilterObserver()
    }
    
    func addBeersSubscriber() {
        repository.$beers
            .sink { completion in
                switch completion{
                case .failure:
                    self.status = .error
                case .finished:
                    break
                }
            } receiveValue: { beers in
                self.status = .success
                if !self.food.isEmpty {
                    if self.isPaging {
                        self.beers.append(contentsOf: beers)
                    } else {
                        self.beers = beers
                    }
                } else {
                    self.beers.append(contentsOf: beers)
                }
            }
            .store(in: &subscription)
    }
    
    func addFoodObserver() {
        $food.debounce(for: .milliseconds(300), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                return string
            }) // prevents sending numerous requests
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] (searchField) in
                resetPagesAndCall()
            }.store(in: &subscription)
    }
    
    func addFilterObserver() {
        $chips.receive(on: RunLoop.main)
            .sink { listItems in
                
                // Do call api with new filters
                self.queryItems = []
                
                listItems.forEach{ item in
                    if(item.isSelected){
                        if let queryItem = item.queryItem{
                            self.queryItems.append(queryItem)
                        }
                    }
                }
                self.beers = []
                if self.status != .none {
                    //Prevent first call
                    self.resetPagesAndCall()
                }
            }.store(in: &subscription)
    }
    
    func getAllBeers(isPaging: Bool = false) {
        
        self.isPaging = isPaging
        
        if !isPaging {
            self.status = .sending
        }
        
        repository.getBeers(page: currentPage, food: food, queryItems: self.queryItems)
    }
    
    func resetPagesAndCall() {
        self.currentPage = 1
        self.lastPage = 0
        self.getAllBeers()
    }
}
