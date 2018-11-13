//
//  ViewController.swift
//  pokeapi
//
//  Created by Kaleb Spillman on 11/12/18.
//  Copyright © 2018 Kaleb Spillman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonTextField: UITextField!
    
    
   
    @IBOutlet weak var textView: UITextView!
    
    
    
    //Base URl for request
    let pokeAPIRequest = "https://api/v2/ability/{id or name}/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    
    
    @IBAction func searchButtonTapped(_ sender: Any) {
    
    //Dismiss keyboard
        pokemonTextField.resignFirstResponder()
        // checking to make sure both fields have values
        guard let pokemonName = pokemonTextField.text
             else {
                return
        }
        // Clearing out text field
        pokemonTextField.text = ""
       
        
        let pokemonNameURLComponent = pokemonName.replacingOccurrences(of: " ", with: "+")
       
        let requestURL = pokeAPIRequest + pokemonNameURLComponent + "/"
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch  response.result {
            case .success(let value):
                let json = JSON(value)
                self.textView.text = json["pokemon"].stringValue
            case .failure(let error):
                self.textView.text = "invalid selection enterd or an error occured. Please try again!"
                print(error.localizedDescription)
            }
            
        }
    }
}

