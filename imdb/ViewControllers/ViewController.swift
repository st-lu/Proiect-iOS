//
//  ViewController.swift
//  imdb
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements(){
        Utilities.styleHollowButton(logInButton)
        Utilities.styleFilledButton(signUpButton)    }

}

