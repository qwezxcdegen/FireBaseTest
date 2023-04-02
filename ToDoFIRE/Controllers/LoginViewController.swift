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
        FirebaseApp.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        displayWarningLabel(with: "qwe")
    }
    
    private func displayWarningLabel(with text: String) {
        warningLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.warningLabel.alpha = 1
        }) { _ in
            self.warningLabel.alpha = 0
        }
    }
}

