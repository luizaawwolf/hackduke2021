//
//  RecipeInfoViewController.swift
//  HackDuke2021
//
//  Created by Rohin Shahi on 10/24/21.
//

import UIKit

class RecipeInfoViewController: UIViewController {

    @IBOutlet weak var RecipeTitle: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    
    @IBOutlet weak var foodImage: UIImageView!
    
    var recipe: Recipe?
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeTitle.text = recipe?.title
        summary.text = recipe?.summary
        
        guard let imageUrl:URL = URL(string: recipe!.image) else {
            return
        }
        
        // Start background thread so that image loading does not make app unresponsive
          DispatchQueue.global().async { [weak self] in
            
            guard let self = self else { return }
            
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }

            
            // When from a background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async { [self] in
                let image = UIImage(data: imageData)
            self.foodImage.image = image
                self.foodImage.contentMode = UIView.ContentMode.scaleAspectFit
                self.view.addSubview(self.foodImage)
            }
        }
        
//        foodImage.image = localImage
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
