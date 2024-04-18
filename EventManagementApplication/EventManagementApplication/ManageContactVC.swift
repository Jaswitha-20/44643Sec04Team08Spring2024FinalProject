//
//  ManageContactVC.swift
//  EventManagementApplication
//
//  Created by Jaswitha Kalikiri on 3/18/24.
//

import UIKit

class ManageContactVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noData: UILabel!
    var organizers: [Organizer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        DataManager.shared.fetchOrganiserDataFromAPI { organiserArr, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
            } else if let organizers = organiserArr {
                DispatchQueue.main.async {
                    self.organizers = organizers
                    self.tableView.reloadData()
                }
            }
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let organizer = organizers[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.commonTitle?.text = organizer.name
        cell.locationLbl?.text = organizer.address
        cell.dateLbl?.text = organizer.contact

        let phoneNumber = organizer.contact ?? ""

        cell.callBtn.tag = Int(phoneNumber) ?? 0

        cell.callBtn.addTarget(self, action: #selector(makePhoneCall(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func makePhoneCall(_ sender: UIButton) {
        let phoneNumber = sender.tag as? String ?? ""
        
        guard let url = URL(string: "tel://\(phoneNumber)") else {
            print("Invalid phone number")
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot make phone call")
        }
    }

    
    // MARK: - UITableViewDelegate
    
    //        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //           let eventRecord = eventRecord[indexPath.row]
    //
    //            let vc = storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
    //            vc.eventData = eventRecord
    //            vc.organiserDetail = eventRecord.organizer
    //            navigationController?.pushViewController(vc, animated: true)
    //        }
}
