//
//  NetworkManager.swift
//  HackDuke2021
//
//  Created by Rohin Shahi on 10/23/21.
//
import Foundation

struct Recipe: Codable {
    var title: String
    var image: String
}

struct RecipeList: Decodable {
   var results: [Recipe]
}

class NetworkManager {

    let urlSession = URLSession.shared
    var baseURL = "https://api.spoonacular.com/"
    var api_key = "6a7759fef5704426bcac109f81c76b53"
    var searchQuery = "cake"
    var exclude = "egg"

    func getRecipes(completion: @escaping ([Recipe]) -> Void) {
        // our API query
        
        let query = "recipes/complexSearch?query=" + searchQuery + "&excludeIngredients=" + exclude + "&apiKey=" + api_key
        let fullURL = URL(string: baseURL + query)!
        var request = URLRequest(url: fullURL)

        request.httpMethod = "GET"
        // Set up header with API Token.
        request.allHTTPHeaderFields = [
          "Content-Type": "application/json"
        ]

        let task = urlSession.dataTask(with: request) { data, response, error in
          // Check for errors.
          if let error = error {
            print(error)
            return
          }

          // Check to see if there is any data that was retrieved.
          guard let data = data else {
            return
          }

          // Attempt to decode the data.
          guard let result = try? JSONDecoder().decode(RecipeList.self, from: data) else {
            print("oops")
            return
          }

          let recipes = result.results
            
          // Return the result with the completion handler.
          DispatchQueue.main.async {
              completion(recipes)
          }
        }

        task.resume()
      }
}
