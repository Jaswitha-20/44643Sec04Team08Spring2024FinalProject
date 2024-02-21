//
//  EasyEvents.swift
//  EasyEvents
//
//  Created by Kalikiri,Jaswitha on 2/21/24.
//

import UIKit
import Lottie
class EasyEvents: UIViewController {
    
    @IBOutlet weak var LaunchLAV: LottieAnimationView!{
        didSet{
            LaunchLAV.animation = LottieAnimation.named("event")
            LaunchLAV.alpha = 1
            LaunchLAV.play()
            LaunchLAV.loopMode = .loop
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
