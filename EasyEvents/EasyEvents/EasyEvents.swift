//
//  EasyEvents.swift
//  EasyEvents
//
//  Created by Kalikiri,Jaswitha on 2/21/24.
//

import UIKit
import Lottie
import AnimatedGradientView
class EasyEvents: UIViewController {
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
            LaunchLAV.animation = LottieAnimation.named("event")
            LaunchLAV.alpha = 1
            LaunchLAV.play{ [weak self] _ in
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut]){
                    self?.LaunchLAV.alpha = 0.0
                }
            }
        }
    }
    
    @IBOutlet weak var WelcomeTV: UITextView!
    
    @IBAction func getStartWelcome(_ sender: UIButton) {
        // logic to navigate to login page
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animatedGradient = AnimatedGradientView(frame: view.bounds)
        animatedGradient.direction = .up
        animatedGradient.animationValues = [(colors: ["#2BC0E4", "#EAECC6"], .up, .axial),
        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial),
        (colors: ["#003973", "#E5E5BE"], .down, .axial),
        (colors: ["#1E9600", "#FFF200", "#FF0000"], .left, .axial)]
        view.addSubview(animatedGradient)
        view.sendSubviewToBack(animatedGradient)
        // Do any additional setup after loading the view.
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
