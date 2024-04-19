//
//  SignUpVC.swift
//  EventManagementApplication
//
//  Created by Jaswitha Reddy on 3/7/24.
//

import UIKit
import AnimatedGradientView

class SignUpVC: UIViewController {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if validate() {

            let userData = UserRegistrationModel(firstname: self.firstname.text ?? "", lastname: self.lastname.text ?? "", email: self.email.text ?? "", phone: self.phone.text ?? "", password: self.password.text ?? "")
            
            FireStoreManager.shared.signUp(user: userData) { success in
                if success{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }

    
    func validate() ->Bool {
       
        if(self.email.text!.isEmpty) {
            globalAlart(message: "Please enter email.")
            return false
        }
        
        if !email.text!.emailIsCorrect() {
            globalAlart(message: "Please enter valid email id")
            return false
        }
    
              
        if(self.password.text!.isEmpty) {
            globalAlart(message: "Please enter password.")
            return false
        }
        
        if(self.confirmPassword.text!.isEmpty) {
            globalAlart(message: "Please enter confirm password.")
            return false
        }
        
           if(self.password.text! != self.confirmPassword.text!) {
               globalAlart(message: "Password doesn't match")
            return false
        }
        
        if(self.password.text!.count < 5 || self.password.text!.count > 10 ) {
            
            globalAlart(message: "Password  length shoud be 5 to 10")
            return false
        }
        
        if(self.firstname.text!.isEmpty) {
            globalAlart(message: "Please enter first name.")
            return false
        }
        
        if(self.lastname.text!.isEmpty) {
            globalAlart(message: "Please enter last name.")
            return false
        }
        
        if(self.phone.text!.isEmpty) {
            globalAlart(message: "Please enter phone.")
            return false
        }
        
        return true
    }
}





