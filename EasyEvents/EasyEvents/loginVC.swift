//
//  loginVC.swift
//  EasyEvents
//
//  Created by Divya Sarvepalli on 2/23/24.
//

import UIKit
import AnimatedGradientView
import AVFoundation
import SwiftUI

class loginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var emailValidationLBL: UILabel!
    
    @IBOutlet weak var passwordValidationLBL: UILabel!
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1103)
        if(validateEmail(email: emailTF.text)){
            // verify the users email and password with database datadf
            if(emailTF.text == "admin@gmail.com" && passwordTF.text == "password"){
                // navigate to the main view after succesful login
              //  self.performSegue(withIdentifier: loginNext, sender: self)
            }
        }
    }
    
    
    @IBAction func onSignUp(_ sender: UIButton) {
        AudioServicesPlaySystemSound(1103)
    }
    
    func validateEmail(email :String?)-> Bool{
        guard let email = emailTF.text, !email.isEmpty else {
            self.emailValidationLBL.text = "Please enter the Email ID"
            self.emailValidationLBL.textColor = UIColor.red
            return false}
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        self.emailValidationLBL.text = "Please enter a valid email ID"
           return emailPredicate.evaluate(with: email)
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
