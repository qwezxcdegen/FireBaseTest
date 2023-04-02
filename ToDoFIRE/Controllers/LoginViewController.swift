//
//  ViewController.swift
//  ToDoFIRE
//
//  Created by Степан Фоминцев on 02.04.2023.
//

import UIKit
import Firebase

final class LoginViewController: UIViewController {

    @IBOutlet weak private var warningLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.alpha = 0
        FirebaseApp.configure()
        let listener = FirebaseAuth.Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "tasksSegue", sender: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(with: "Data is incorrect")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error != nil {
                self.displayWarningLabel(with: "Error occured")
                return
            }
            if user != nil {
                print("GOOD")
                self.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            }
            self.displayWarningLabel(with: "No such user")
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(with: "Enter correct data to register")
            return
        }
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { user, error in
            guard error == nil else {
                self.displayWarningLabel(with: "User is exist")
                return
            }
            guard user != nil else {
                self.displayWarningLabel(with: "Error")
                return
            }
            self.performSegue(withIdentifier: "tasksSegue", sender: nil)
        }
    }
    
    private func displayWarningLabel(with text: String) {
        warningLabel.text = text
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 2, animations: {
            self.warningLabel.alpha = 1
        }) { _ in
            self.warningLabel.alpha = 0
        }
    }
}

