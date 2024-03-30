//
//  LOGINViewController.swift
//  EasyEvents
//
//  Created by Kumar Chandu Mallireddy on 3/8/24.
//

import UIKit
import AVFoundation
import AnimatedGradientView
class LOGINViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var lockBtn: UIButton!
    
    @IBOutlet weak var signupBtn: UIButton!
    
    @IBAction func emailAction(_ sender: UITextField) {
        
    }
    @IBAction func lockAction(_ sender: UIButton) {
        
        self.passwordTF.isSecureTextEntry.toggle()
              
               let buttonImageName = passwordTF.isSecureTextEntry ? "lock" : "lock.open"
                   if let buttonImage = UIImage(systemName: buttonImageName) {
                       sender.setImage(buttonImage, for: .normal)
               }
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        
        AudioServicesPlaySystemSound(1103)
                   // verify the users email and password with database datadf
                   if(emailTF.text == "admin@gmail.com" && passwordTF.text == "Pass@123"){
                       // navigate to the main view after succesful login
                     //  self.performSegue(withIdentifier: loginNext, sender: self)
                   }
    }
    
    @IBAction func passwordAction(_ sender: UITextField) {
    }
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var passwordValidationTV: UITextView!
    @IBOutlet weak var emailValidationLBL: UILabel!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordTF.isEnabled = false
        self.loginBtn.isEnabled = false
        self.passwordValidationTV.isEditable = false
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
                animatedGradient.direction = .up
                animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                                    (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                                    (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                                    (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
                view.addSubview(animatedGradient)
                view.sendSubviewToBack(animatedGradient)
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func verifyEmail(_ sender: UITextField) {
        if(validateEmail(givenEmail: self.emailTF.text)){
            self.emailValidationLBL.text = ""
            self.passwordTF.isEnabled = true
        }
    }
    
    @IBAction func verifyPassword(_ sender: UITextField) {
        if(validatePassword(givenPassword: self.passwordTF.text)){
            self.passwordValidationTV.text = ""
            self.loginBtn.isEnabled = true
        }
    }
    
    func validateEmail(givenEmail :String?)-> Bool{
           guard let email = givenEmail, !email.isEmpty else {
               self.emailValidationLBL.text = "Please enter the Email ID"
               self.emailValidationLBL.textColor = UIColor.red
               return false}
           let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
              let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
           if(!emailPredicate.evaluate(with: email)){
               self.emailValidationLBL.text = "Please enter a valid email ID"
               self.emailValidationLBL.textColor = UIColor.red
                  return false
           }
           return true
       }
       
       func validatePassword(givenPassword: String?) -> Bool {
           guard let password = givenPassword , !password.isEmpty else {
                       self.passwordValidationTV.text = "Please enter the password"
                       self.passwordValidationTV.textColor = UIColor.red
                       return false
                   }
           var messages: [String] = []
           messages.append("Password must contain at least")

           if !password.contains(where: { $0.isUppercase }) {
               messages.append("\n     • one capital letter")
           }
           
           if !password.contains(where: { $0.isNumber }) {
               messages.append("\n     • one digit.")
           }
           
           if !password.contains(where: { !$0.isLetter && !$0.isNumber }) {
               messages.append("\n     • special character.")
           }

           if password.count < 8 {
               messages.append("\n     • 8 characters long.")
           }
           
           if(messages.count > 1){
               self.passwordValidationTV.text = messages.joined(separator: "")
               self.passwordValidationTV.textColor = UIColor.red
               
               return false
           }

           return true
       }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
