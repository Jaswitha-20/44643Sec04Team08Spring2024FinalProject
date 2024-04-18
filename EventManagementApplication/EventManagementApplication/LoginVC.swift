//
//  LoginVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/8/24.
//

import UIKit
import AnimatedGradientView

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var rememberMe: Bool = false
    
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
    

    
    @IBAction func onLogin(_ sender: Any) {
        if(email.text!.isEmpty) {
            showAlerOnTop(message: "Please enter your email id.")
            return
        }
        
        if(self.password.text!.isEmpty) {
            showAlerOnTop(message: "Please enter your password.")
            return
        }
        else{
            FireStoreManager.shared.login(email: email.text?.lowercased() ?? "", password: password.text ?? "") { success in
                if success{
                    SceneDelegate.shared?.loginCheckOrRestart()
                }
                
            }
        }
    }
}
