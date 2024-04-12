//
//  ProfileVC.swift
//  EasyEvents
//
//  Created by RAKESH SOMANABOINA on 3/29/24.
//

import UIKit
import AnimatedGradientView

class ProfileVC: UIViewController {

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
    @IBAction func logoutBTN(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
           
                let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
                    self.performSegue(withIdentifier: "profileToLogin", sender: self)
                }
                alertController.addAction(confirmAction)
                present(alertController, animated: true, completion: nil)
    }
    

     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is LOGINViewController else {return}
    }
    

}
