//
//  LogInViewController.swift
//  imdb
//
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    @IBOutlet weak var
        emailTextField:
        UITextField!
    
    @IBOutlet weak var
        passwordTextField:
        UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var validationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        validationLabel.alpha = 0;
        
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleHollowButton(logInButton)
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logInTapped(_ sender: Any) {
        let email = emailTextField.text!
        let passw = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: email, password: passw) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.validationLabel.text = error!.localizedDescription
                self.validationLabel.alpha = 1
            }
            else {
                
                let homeViewController = self.storyboard?.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
