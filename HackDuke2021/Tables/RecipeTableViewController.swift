//
//  RecipeTableViewController.swift
//  HackDuke2021
//
//  Created by Luiza Wolf on 10/23/21.
//

import UIKit

//struct Recipe: Codable {
//    var name: String
//}

class RecipeTableViewController: UITableViewController {
    
   
    @IBOutlet var searchBar: UITableView!
    @IBOutlet var feedTableView: UITableView!
    
    var networkManager = NetworkManager()
    var searching = false

//    var RecipeData: [Recipe] = []
    var RecipeData: [Recipe] = [] {
       didSet {
           feedTableView.reloadData()
       }
    }

    
    
    override func viewDidLoad() {
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
        super.viewDidLoad()
        title = "Search for Recipes!"
        
        updateFeed()
        
            
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeTableViewCell
        
        let recipe = RecipeData[indexPath.row]
        print(recipe.title)
        cell.RecipeTitle?.text = recipe.title
        
        return cell
    }

    
    func updateFeed() {
       networkManager.getRecipes() { result in
           self.RecipeData = result
       }
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destVC = segue.destination as! RecipeInfoViewController
            let selectRow = tableView.indexPathForSelectedRow?.row
            
            
            let thisRecipe = RecipeData[selectRow!]

            destVC.recipe = thisRecipe
        }
        

}
