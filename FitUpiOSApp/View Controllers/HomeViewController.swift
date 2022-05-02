//
//  HomeViewController.swift
//  FitUpiOSApp
//
//  Created by Anthony Sherrill on 28.04.22.
//

import UIKit
import FirebaseAuth
import Firebase

class HomeViewController: UIViewController {
    
    var userUidForViewTransition = String()
    var id = String()
    var firstName = String()
    var lastName = String()
    var bets = [Bet]()
    
    let returnUserName: (String) -> String = { firstName in
        return firstName
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        userNameLabel.text = setUserName(completionHandler: returnUserName)
        userNameLabel.text = "Anthony"
        print("‼️ User: \(userNameLabel.text ?? "nil")")
        print("Bets: \(bets.count)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutTabbed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            print("Successfully logged out!")
        }
        catch {
            print("already logged out")
        }
        transitionToLogin()
    }
    
    func transitionToLogin() {
        
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    func getUserFromFireStore(_ uid: String) -> User {
        
        // request firestore for user entry
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()
                print("dataDescription: \(dataDescription ?? ["default": "value"])")
                self.id = dataDescription!["uid"] as? String ?? "nil"
                self.firstName = dataDescription?["firstname"] as? String ?? "nil"
                self.lastName = dataDescription?["lastname"] as? String ?? "nil"
            } else {
                print("Document does not exist")
            }
        }
        print("‼️ id: \(self.id), firstname: \(self.firstName), lastName: \(self.lastName)")
        let user = User(id: self.id, firstName: self.firstName, lastName: self.lastName)
        print("✌️USER: \(user)")
        return user
    }
    
    func setUserName(completionHandler: (String) -> String) -> String {
        let user = getUserFromFireStore(userUidForViewTransition)
        return completionHandler(user.firstName ?? "nil")
    }
}
