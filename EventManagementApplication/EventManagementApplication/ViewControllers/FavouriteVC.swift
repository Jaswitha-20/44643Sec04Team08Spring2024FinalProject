//
//  FavouriteVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/21/24.
//

import UIKit
import AnimatedGradientView
import AVFoundation

class FavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noData: UILabel!
    var eventRecord: [EventData] = []

    var animatedGradient: AnimatedGradientView!

      override func viewDidLoad() {
          super.viewDidLoad()
          
          // Create the animated gradient view
          animatedGradient = AnimatedGradientView(frame: view.bounds)
          animatedGradient.direction = .up
          animatedGradient.animationValues = [(colors: ["#A9F5F2", "#F5F6CE"], .up, .axial),
                                              (colors: ["#F5A9D0", "#2ECCFA", "#BEF781"], .right, .axial),
                                              (colors: ["#ECE0F8", "#819FF7"], .down, .axial),
                                              (colors: ["#58FAF4", "#F4FA58", "#A9A9F5"], .left, .axial)]
          
          // Add the animated gradient view to the view hierarchy
          view.addSubview(animatedGradient)
          view.sendSubviewToBack(animatedGradient)
          
          // Set up the table view
          tableView.delegate = self
          tableView.dataSource = self
      }
    
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           // Update the frame of the animated gradient view to cover the entire screen
           animatedGradient.frame = view.bounds
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
                    DispatchQueue.main.async {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
                        
                        vc.eventData = event
                      
                        vc.isHistory = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    
                  
                })
            }else {
                DispatchQueue.main.async {
                if  let event = getEvent(selectedId: eventRecord.organizerId!)
                    {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventBookingVC") as! EventBookingVC
                        
                        vc.eventData = event
                      
                        vc.isHistory = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else {
                        // Handle the case where myOptionalValue is nil
                    }
                }
                
                
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
extension FavouriteVC {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AudioServicesPlaySystemSound(SystemSoundID(1152))
            let eventToDelete = eventRecord[indexPath.row]
            FireStoreManager.shared.deleteFavoriteEvent(eventToDelete) { success in
                if success {
                    self.eventRecord.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tableView.isHidden = self.eventRecord.isEmpty
                    self.noData.isHidden = !self.eventRecord.isEmpty
                } else {
                    // Handle error
                }
            }
        }
    }
}
