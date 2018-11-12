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
    
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    
    @IBOutlet weak var textView: UITextView!
    //Base URl for request
    let lyricsAPIBaseURL = "/api/v2/ability/{id or name}/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    
    @IBAction func searchTapped(_ sender: Any) {
        //Dismiss keyboard
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
        // checking to make sure both fields have values
        guard let artistName = textField.text,
            let songTitle = textField2.text else {
                return
        }
        // Clearing out text field
        textField.text = ""
        textField2.text = ""
        
        let artistNameURLComponent = artistName.replacingOccurrences(of: " ", with: "+")
        let songTitleURLComponent = songTitle.replacingOccurrences(of: " ", with: "+")
        
        let requestURL = lyricsAPIBaseURL + artistNameURLComponent + "/" + songTitleURLComponent
        
        Alamofire.request(requestURL).responseJSON { (response) in
            switch  response.result {
            case .success(let value):
                let json = JSON(value)
                self.textView.text = json["lyrics"].stringValue
            case .failure(let error):
                self.textView.text = "invalid selection enterd or an error occured. Please try again!"
                print(error.localizedDescription)
            }
            
        }
    }
}

