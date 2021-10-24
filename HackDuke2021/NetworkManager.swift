//
//  NetworkManager.swift
//  HackDuke2021
//
//  Created by Rohin Shahi on 10/23/21.
//
import Foundation

struct Recipe: Decodable {
    var title: String
    var image: String
    var summary: String
    var analyzedInstructions: [Instruction]
//    var ingredients: [Ingredient]?
}

struct RecipeList: Decodable {
   var results: [Recipe]
}

struct Instruction: Decodable {
    var name: String //doesn't matter but here to help
    var steps: [Step]
}

struct Step: Decodable {
    var number: Int
    var step: String
    var ingredients: [Ingredient]
}

struct Ingredient: Decodable {
    var name: String
}

class NetworkManager {

    let urlSession = URLSession.shared
    var baseURL = "https://api.spoonacular.com/"
    var api_key = "6a7759fef5704426bcac109f81c76b53"
    var searchQuery = "cake"
    var exclude = ["egg", "gluten"]
    var intolerances = ["egg", "gluten"]
    var diets = ["keto"]

    func getRecipes(completion: @escaping ([Recipe]) -> Void) {
        // our API query
        
        var query = "recipes/complexSearch?query=" + searchQuery + "&apiKey=" + api_key
        query += "&excludeIngredients=" + exclude.joined(separator: ",")
        query += "&intolerances=" + intolerances.joined(separator: ",")
        query += "&diets=" + diets.joined(separator: ",")
        query += "&addRecipeInformation=true"
        
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

          var recipes = result.results
            
//            for var recipe in recipes {
//                var steps = recipe.analyzedInstructions[0].steps
//                for step in steps{
//                    recipe.ingredients.append(contentsOf: step.ingredients)
//                }
//            }
            
          // Return the result with the completion handler.
          DispatchQueue.main.async {
              completion(recipes)
          }
        }

        task.resume()
      }
}
