//
//  EventBookingVC.swift
//  EventManagementApplication
//
//  Created by Kumar Chandu Mallireddy on 3/25/24.
//

import UIKit
import EventKit
import MapKit
import AnimatedGradientView

class EventBookingVC: UIViewController {
    @IBOutlet var termButton: UIButton!
    @IBOutlet var continueButton: UIButton!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var favButton: UIButton!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var date: UITextField!
    @IBOutlet var time: UITextField!
    @IBOutlet var price: UILabel!
    @IBOutlet var organiserName: UILabel!
    @IBOutlet var organiserEmail: UILabel!
    @IBOutlet var organiserContact: UILabel!
    @IBOutlet var organiserAddress: UILabel!
    
    
      var rememberMe: Bool = false
      var eventData : EventDetailData?
      var organiserDetail: Organizer?
      var favEventBool = false
      var startTime: Date?
          var endTime: Date?

      var isHistory = false
      let datePicker = UIDatePicker()
      
      let timePicker = UIDatePicker()

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
          // Set up time picker
          timePicker.datePickerMode = .time
                 if #available(iOS 13.4, *) {
                     timePicker.preferredDatePickerStyle = .wheels
                 }
                 time.inputView = timePicker
                 setupTimePickerAccessoryView() // Highlighted area - calling new method
                // showTimePicker()
          
          datePicker.minimumDate = Date()
          self.date.inputView =  datePicker
          self.showDatePicker()

          termButton.setImage(UIImage(named: "check"), for: .selected)
          termButton.setImage(UIImage(named: "uncheck"), for: .normal)
          
          termButton.isSelected = rememberMe
          
          self.setupView()
  //        self.favEventBool = self.eventData?.fav?.contains(UserDefaultsManager.shared.getEmail().lowercased()) ?? false
  //
  //        if(favEventBool) {
  //            self.eventData.setImage(UIImage(systemName:"heart.fill"), for: .normal)
  //        }else {
  //            self.eventData.setImage(UIImage(systemName:"heart"), for: .normal)
  //        }
      }
      
      
      
      func setupTimePickerAccessoryView() {
              let toolbar = UIToolbar()
              toolbar.sizeToFit()
              let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePicker))
              let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
              let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePicker))
              toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
              
          time.inputAccessoryView = toolbar
          }
    
    func setupView(){
        
        if isHistory{
            self.termButton.isHidden = true
            self.favButton.isHidden = true
            self.continueButton.isHidden = true
            self.date.isUserInteractionEnabled = false
            self.locationButton.isUserInteractionEnabled = false
        } else {
            showAlerOnTop(message: "You can update Event Date and Location")
        }
        
        self.eventName.text = eventData?.event_title
        self.location.text = eventData?.location
        self.date.text = eventData?.date
        self.time.text = eventData?.time
        self.price.text = "\(String(describing: eventData?.price == 0 ? 100 : eventData?.price))"
        self.organiserName.text = "Name : \(organiserDetail?.name ?? "")"
        self.organiserEmail.text = "Email : \(organiserDetail?.email ?? "")"
        self.organiserContact.text = "Contact : \(organiserDetail?.contact ?? "")"
        self.organiserAddress.text = "Address : \(organiserDetail?.address ?? "")"
        
        self.requestCalendarPermission { sucess in
            if sucess{
                print("Add permission")
            }
        }
    }
    
    @objc func doneTimePicker() {
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mma"

            if startTime == nil {
                startTime = timePicker.date
                time.text = formatter.string(from: startTime!)
                time.text! += " - "
                timePicker.minimumDate = timePicker.date // Set minimum date for end time picker
            } else {
                endTime = timePicker.date
                time.text! += formatter.string(from: endTime!)
            }
            
            view.endEditing(true)
        }
    
    @objc func cancelTimePicker() {
           view.endEditing(true)
       }

    
    @IBAction func termToggled(_ sender: UIButton) {
        termButton.isSelected.toggle()
        rememberMe = termButton.isSelected
        
        if rememberMe {
            print("User wants to be remembered.")
        } else {
            print("User does not want to be remembered.")
        }
    }
    
    @IBAction func onLocation(_ sender: Any) {
        let mapKit = MapKitSearchViewController(delegate: self)
        mapKit.modalPresentationStyle = .fullScreen
        present(mapKit, animated: true, completion: nil)
    }
    
    
    @IBAction func onBooking(_ sender: Any) {
        if !rememberMe {
            showAlerOnTop(message: "Please select terms and condition.")
            return
        } else {
            FireStoreManager.shared.bookEventDetail(eventDetail: eventData!, organiser: organiserDetail!) { success in
                if success {
                    self.addEventToCalendar(eventDetail: self.eventData!) { successBool, error in
                        if successBool {
                            showAlerOnTop(message: "Event Booking Confirmed. The event has been added to your calendar.")
                            DispatchQueue.main.async {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingConfirmationVC") as! BookingConfirmationVC
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onFavClick(_ sender: UIButton) {
        let isCurrentlyFav = favEventBool
        let newFavState = !isCurrentlyFav

        FireStoreManager.shared.addInFavorite(favBool: newFavState, eventDetail: self.eventData!, organiser: self.organiserDetail!) { success in
            if success {
                let heartImageName = newFavState ? "heart.fill" : "heart"
                self.favButton.setImage(UIImage(systemName: heartImageName), for: .normal)
                self.favEventBool = newFavState
                let message = newFavState ? "Favorite added" : "Favorite removed"
                showAlertView(message: message)
            }
        }
    }
}


extension EventBookingVC {
    func requestCalendarPermission(completion: @escaping (Bool) -> Void) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { granted, error in
            if let error = error {
                print("Failed to request access to the calendar: \(error)")
                completion(false)
            } else {
                completion(granted)
            }
        }
    }

    func addEventToCalendar(eventDetail: EventDetailData, completion: @escaping (Bool, Error?) -> Void) {
        let eventStore = EKEventStore()
        
        // Make sure you have permission to access the calendar
        eventStore.requestAccess(to: .event) { granted, error in
            if !granted {
                completion(false, error)
                return
            }

            if let eventDate = self.convertEventDetailDate(calenderdate: self.date.text ?? "") {
                
                if let eventEndDate = self.calculateEndDate(startDate: eventDate) {
                    print("Converted date: \(eventEndDate)")
                    let event = EKEvent(eventStore: eventStore)
                    
                    event.title = eventDetail.event_title
                    event.notes = eventDetail.description
                    event.startDate = eventDate
                    event.endDate = eventEndDate
                    event.location = self.location.text ?? ""
                    
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    
                    // Save the event
                    do {
                        try eventStore.save(event, span: .thisEvent)
                        completion(true, nil)
                    } catch {
                        completion(false, error)
                    }
                    
                }
            }else {
                print("Failed to convert date")
            }

            
        }
    }

    func convertEventDetailDate(calenderdate: String) -> Date? {
        // Create an instance of DateFormatter
        let dateFormatter = DateFormatter()
        
        // Set the date format according to the expected format of `eventDetail.date`
        dateFormatter.dateFormat = "yyyy-MM-dd" // Example format: you may need to adjust this
        
        // Convert the date string to a Date object
        if let eventDate = dateFormatter.date(from: calenderdate) {
            return eventDate
        } else {
            print("Invalid date format")
            return nil
        }
    }
    
    func calculateEndDate(startDate: Date) -> Date? {
        // Create a date components object to add one day to the start date
        var dateComponents = DateComponents()
        dateComponents.day = 1
        
        // Calculate the end date by adding one day to the start date
        let endDate = Calendar.current.date(byAdding: dateComponents, to: startDate)
        
        // Return the calculated end date
        return endDate
    }


}


extension EventBookingVC: MapKitSearchDelegate {
    func mapKitSearch(_ mapKitSearchViewController: MapKitSearchViewController, mapItem: MKMapItem) {
    }
    
    func mapKitSearch(_ mapKitSearchViewController: MapKitSearchViewController, searchReturnedOneItem mapItem: MKMapItem) {
    }
    
    func mapKitSearch(_ mapKitSearchViewController: MapKitSearchViewController, userSelectedListItem mapItem: MKMapItem) {
    }
    
    func mapKitSearch(_ mapKitSearchViewController: MapKitSearchViewController, userSelectedGeocodeItem mapItem: MKMapItem) {
    }
    
    func mapKitSearch(_ mapKitSearchViewController: MapKitSearchViewController, userSelectedAnnotationFromMap mapItem: MKMapItem) {
        print(mapItem.placemark.address)
        
        mapKitSearchViewController.dismiss(animated: true)
        self.setAddress(mapItem: mapItem)
    }
    
    
    func setAddress(mapItem: MKMapItem) {
        
        self.location.text = mapItem.placemark.mkPlacemark!.description.removeCoordinates()
        
    }
    
}


extension EventBookingVC {
        func showDatePicker() {
            //Formate Date
            datePicker.datePickerMode = .date
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
            //ToolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            
            //done button & cancel button
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneHolydatePicker))
            doneButton.tintColor = .black
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelDatePicker))
            cancelButton.tintColor = .black
            toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
            
            // add toolbar to textField
            date.inputAccessoryView = toolbar
            // add datepicker to textField
            date.inputView = datePicker
            
        }
        
        @objc func doneHolydatePicker() {
            //For date formate
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd"
            date.text = formatter.string(from: datePicker.date)
            //dismiss date picker dialog
            self.view.endEditing(true)
        }
        
        @objc func cancelDatePicker() {
            self.view.endEditing(true)
        }

}
