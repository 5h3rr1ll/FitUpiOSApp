//
//  LoginViewController.swift
//  FitUpiOSApp
//
//  Created by Anthony Sherrill on 28.04.22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    

    @IBAction func loginTapped(_ sender: Any) {
        // TODO: Validate Inputfields
        
        // Create clean version of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                homeViewController?.userUidForViewTransition = result?.user.uid ?? ""
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
    
    
    @IBAction func devTapped(_ sender: Any) {

        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        homeViewController?.userUidForViewTransition = "j9SJ75IpGeSVnMHdCeRMenaPCeZ2"
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setUpElements() {
        
        // Hides the error label as long as there is no error
        errorLabel.alpha = 0
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

}
