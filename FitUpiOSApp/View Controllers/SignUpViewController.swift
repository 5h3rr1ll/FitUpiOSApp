//
//  SignUpViewController.swift
//  FitUpiOSApp
//
//  Created by Anthony Sherrill on 28.04.22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func validateFields() -> String? {
        
        // check that all fields are filled in
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields."
        }
        
        // check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validate the fields
        let error = validateFields()
        
        if error != nil {
            // there was an error, show error message
            showError(error!)
        } else {
            
            // Create cleaned version of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                
                if err != nil {
                    self.showError("Error creating user")
                } else {
                    
                    // User was created successfully, now store first name and last name
                    let db = Firestore.firestore()
                    let userUid = result!.user.uid
                    
                    db.collection("users").document(userUid).setData(["firstname": firstName, "lastname": lastName, "uid": userUid]) { error in
                        if error != nil {
                            // Show error message
                            self.showError("User data coulnd't be saved!")
                        }
                    }
                    // transition to the home screen
                    self.transitionToHome(userUid)
                }
            }
        }
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    func setUpElements() {
        
        // Hides the error label as long as there is no error
        errorLabel.alpha = 0
        
    }
    
    func transitionToHome(_ userUid: String) {

        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        homeViewController?.userUidForViewTransition = userUid
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}
