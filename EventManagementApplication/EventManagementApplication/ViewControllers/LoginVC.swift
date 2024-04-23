//
//  LoginVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/8/24.
//

import UIKit
import AnimatedGradientView
import AVFoundation

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    var animatedGradient: AnimatedGradientView!
    var rememberMe: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the animated gradient view
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                            (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                            (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                            (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
        
        // Add the animated gradient view to the view hierarchy
        view.addSubview(animatedGradient)
        view.sendSubviewToBack(animatedGradient)
        
        // Set up autoresizing mask to resize with the superview
        animatedGradient.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Update the frame of the animated gradient view when the device rotates
        coordinator.animate(alongsideTransition: { _ in
            self.animatedGradient?.frame = CGRect(origin: CGPoint.zero, size: size)
        }, completion: nil)
    }


    
    @IBAction func onLogin(_ sender: Any) {
        if(email.text!.isEmpty) {
            globalAlart(message: "Please enter your email id.")
            return
        }
        
        if(self.password.text!.isEmpty) {
            globalAlart(message: "Please enter your password.")
            return
        }
        else{
            FireStoreManager.shared.login(email: email.text?.lowercased() ?? "", password: password.text ?? "") { success in
                if success{
                    SceneDelegate.shared?.loginCheckOrRestart()
                    AudioServicesPlaySystemSound(1105)
                }
                
            }
        }
    }
}
