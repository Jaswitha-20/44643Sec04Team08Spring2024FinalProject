//
//  FavouriteVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/21/24.
//

import UIKit
import AnimatedGradientView

class FavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noData: UILabel!
    var eventRecord: [EventData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.favEventRecord()
    }
    
    
    func favEventRecord(){
        FireStoreManager.shared.fetchFavoriteEvents { event in
            self.eventRecord = event
            self.tableView.isHidden = true

            self.tableView.isHidden = self.eventRecord.count != 0 ? false : true
            self.noData.isHidden = self.eventRecord.count != 0 ? true : false

            print(self.eventRecord)
            
            self.tableView.reloadData()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return eventRecord.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let eventRecord = eventRecord[indexPath.row]

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            
            cell.setData(title: eventRecord.organizerName ?? "", location: eventRecord.location ?? "", description: "", date: eventRecord.date ?? "")
            
            return cell
        }

        // MARK: - UITableViewDelegate

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
           let eventRecord = eventRecord[indexPath.row]
            
            
            if(DataManager.shared.organizers.isEmpty) {
                
                DataManager.shared.fetchOrganiserDataFromAPI(completion: {_,_ in
                    
                    
                    let event = getEvent(selectedId: eventRecord.organizerId!)
                   
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
                    
                    vc.eventData = event
                  
                    vc.isHistory = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                })
            }else {
                
                
                let event = getEvent(selectedId: eventRecord.organizerId!)
               
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
                
                vc.eventData = event
              
                vc.isHistory = true
                navigationController?.pushViewController(vc, animated: true)
                
                
            }
            
           
           
        }
}


func getEvent(selectedId:Int)->EventData? {
    
    for eventData in DataManager.shared.globalEentData {
        
        if(selectedId  == eventData.organizerId) {
            
            return eventData
            break
        }
        
    }
    
    return nil
}
