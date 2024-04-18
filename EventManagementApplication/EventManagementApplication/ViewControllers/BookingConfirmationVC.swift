//
//  BookingConfirmationVC.swift
//  EventManagementApplication
//
//  Created by Jaswitha Kalikiri on 3/21/24.
//

import UIKit

class BookingConfirmationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onBooking(_ sender: Any) {
        SceneDelegate.shared?.loginCheckOrRestart()
    }

}
