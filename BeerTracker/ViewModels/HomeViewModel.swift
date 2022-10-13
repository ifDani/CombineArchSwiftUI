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
    @Published var chips: [ChipModel] = [ChipModel(isSelected: true, title: "All", queryItem: nil),ChipModel(isSelected: false, title: "+ABV", queryItem: URLQueryItem(name: "abv_gt", value: "16")), ChipModel(isSelected: false, title: "Bitter", queryItem: URLQueryItem(name: "ibu_gt", value: "100"))]
    @Published var queryItems: [URLQueryItem] = []
    @Published var beers: Beers = []
    var subscription = Set<AnyCancellable>()

    init() {
        //Search by food parameter logic and prevent multiple requests
        addFoodObserver()
        
        //Listen changes of chips array (detect selections)
        addFilterObserver()
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
        
        let request: URLRequest = BaseNetwork().getBeers(page: currentPage, food: food, queryItems: self.queryItems)
        
        //If is pagging we dont want to change our view to display a top loader
        if !isPaging {
            self.status = .sending
        }
        
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
                    print("success",request.url)
                }
            } receiveValue: { response in
                
                self.status = .success
                if !self.food.isEmpty {
                    
                    if isPaging {
                        self.beers.append(contentsOf: response)
                    } else {
                        self.beers = response
                    }
                } else {
                    self.beers.append(contentsOf: response)
                }
                
            }.store(in: &subscription)
    }
    
    func resetPagesAndCall() {
        self.currentPage = 1
        self.lastPage = 0
        self.getAllBeers()
    }
}
