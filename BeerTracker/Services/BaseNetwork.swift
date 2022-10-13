//
//  BaseNetwork.swift
//  BeerTracker
//
//  Created by Daniel Carracedo on 10/10/22.
//

import Foundation
let API_URL = "https://api.punkapi.com/v2/"

struct HTTPMethods{
    static let post = "POST"
    static let get = "GET"
    static let put = "PUT"
    static let delete = "DELETE"
    static let content = "application/json"
}

enum endpoints : String {
    
    //Registro horario
    case beers = "beers" //GET Obtain all beers
    case beer = "beers/" //GET Obtain specific beer
    case randomBeer = "beers/random" //GET. Obtain random Beer

}

//protocol
protocol BaseNetworkProtocol {
    func getBeers(page: Int, food: String?, queryItems: [URLQueryItem]) -> URLRequest
    func getBeer(_ id:Int) -> URLRequest
    func getRandomBeer() -> URLRequest

}

struct BaseNetwork : BaseNetworkProtocol {
    func getBeers(page: Int = 1, food: String?, queryItems: [URLQueryItem]) -> URLRequest {
        let url : String = "\(API_URL)\(endpoints.beers)"
        
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "per_page", value: "\(14)")]
        
        if(!queryItems.isEmpty) {
            urlComponents.queryItems?.append(contentsOf: queryItems)
        }
        
        if let food = food, !food.isEmpty {
            let foodMapped = food.replacingOccurrences(of: " ", with: "_")
            urlComponents.queryItems?.append(URLQueryItem(name: "food", value: foodMapped))
        }

        var request = URLRequest(url: urlComponents.url!)
        //Header
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Header aplication JSON
        return request
    }
    
    
    func getBeer(_ id: Int) -> URLRequest {
        let url : String = "\(API_URL)\(endpoints.beers)/\(id)"
        
        print(url,endpoints.beer)
        var request : URLRequest = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethods.get
     
        //Header
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type") //Header aplication JSON
        return request
    }
    
    func getRandomBeer() -> URLRequest {
        return URLRequest(url: URL(fileURLWithPath: ""))
    }
    
}
