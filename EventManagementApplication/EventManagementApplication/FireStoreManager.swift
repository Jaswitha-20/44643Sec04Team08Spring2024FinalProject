
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

struct Photo {
    var image: UIImage
    var downloadURL: URL?
}

class FireStoreManager {
   
   public static let shared = FireStoreManager()
   var hospital = [String]()

   var db: Firestore!
   var dbRef : CollectionReference!
   
   init() {
       let settings = FirestoreSettings()
       Firestore.firestore().settings = settings
       db = Firestore.firestore()
       dbRef = db.collection("Users")
   }
   
    func signUp(user: UserRegistrationModel, completion: @escaping (Bool)->()) {
        getQueryFromFirestore(field: "email", compareValue: user.email ?? "") { querySnapshot in
            print(querySnapshot.count)
            
            if querySnapshot.count > 0 {
                showAlerOnTop(message: "This Email is Already Registered!!")
                completion(false)
            } else {
                let data = [
                    "firstname": user.firstname ?? "",
                    "lastname": user.lastname ?? "",
                    "email": user.email ?? "",
                    "phone": user.phone ?? "",
                    "password": user.password ?? ""
                ]
                
                self.addDataToFireStore(data: data) { _ in
                    showOkAlertAnyWhereWithCallBack(message: "Registration Success!!") {
                         
                        DispatchQueue.main.async {
                            completion(true)
                        }
                       
                    }
                    
                }
            }
        }
    }

   
   
   func login(email:String,password:String,completion: @escaping (Bool)->()) {
       let  query = db.collection("Users").whereField("email", isEqualTo: email)
       
       query.getDocuments { (querySnapshot, err) in
        
           print(querySnapshot?.count)

           if(querySnapshot?.count == 0) {
               showAlerOnTop(message: "Email id not found!!")
           }else {

               for document in querySnapshot!.documents {
                   print("doclogin = \(document.documentID)")
                   UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")

                   if let pwd = document.data()["password"] as? String{

                       if(pwd == password) {

                           let name = document.data()["name"] as? String ?? ""
                           let email = document.data()["email"] as? String ?? ""
                           let phone = document.data()["phone"] as? String ?? ""

                           UserDefaultsManager.shared.saveData(name: name, email: email, phone: phone)
                           completion(true)

                       }else {
                           showAlerOnTop(message: "Password doesn't match")
                       }


                   }else {
                       showAlerOnTop(message: "Something went wrong!!")
                   }
               }
           }
       }
  }
       
   func getPassword(email:String,password:String,completion: @escaping (String)->()) {
       let  query = db.collection("Users").whereField("email", isEqualTo: email)
       
       query.getDocuments { (querySnapshot, err) in
        
           if(querySnapshot?.count == 0) {
               showAlerOnTop(message: "Email id not found!!")
           }else {

               for document in querySnapshot!.documents {
                   print("doclogin = \(document.documentID)")
                   UserDefaults.standard.setValue("\(document.documentID)", forKey: "documentId")
                   if let pwd = document.data()["password"] as? String{
                           completion(pwd)
                   }else {
                       showAlerOnTop(message: "Something went wrong!!")
                   }
               }
           }
       }
  }
   
   func getQueryFromFirestore(field:String,compareValue:String,completionHandler:@escaping (QuerySnapshot) -> Void){
       
       dbRef.whereField(field, isEqualTo: compareValue).getDocuments { querySnapshot, err in
           
           if let err = err {
               
               showAlerOnTop(message: "Error getting documents: \(err)")
                           return
           }else {
               
               if let querySnapshot = querySnapshot {
                   return completionHandler(querySnapshot)
               }else {
                   showAlerOnTop(message: "Something went wrong!!")
               }
              
           }
       }
       
   }
   
   func addDataToFireStore(data:[String:Any] ,completionHandler:@escaping (Any) -> Void){
       let dbr = db.collection("Users")
       dbr.addDocument(data: data) { err in
                  if let err = err {
                      showAlerOnTop(message: "Error adding document: \(err)")
                  } else {
                      completionHandler("success")
                  }
    }
       
       
   }
   
    func updatePassword(documentid:String, userData: [String:String] ,completion: @escaping (Bool)->()) {
        let  query = db.collection("Users").document(documentid)
        
        query.updateData(userData) { error in
            if let error = error {
                print("Error updating Firestore data: \(error.localizedDescription)")
                // Handle the error
            } else {
                print("Profile data updated successfully")
                completion(true)
                // Handle the success
            }
        }
    }
    
    func bookEventDetail(eventDetail: EventDetailData, organiser: Organizer, completion: @escaping (Bool) -> Void) {
        let meetingsCollection = self.db.collection("BookEvent")
        
        let organizer: [String: Any] = [
            "name": organiser.name ?? "",
            "email": organiser.email ?? "",
            "contact": organiser.contact ?? "",
            "address": organiser.address ?? "",
            "inField": organiser.inField ?? "",
            "eventsDone": organiser.eventsDone ?? 0,
            "rating": organiser.rating ?? 0.0
        ]
        
        let meetingData: [String: Any] = [
            "event_title": eventDetail.event_title ?? "",
            "description": eventDetail.description ?? "",
            "date": eventDetail.date ?? "",
            "location": eventDetail.location ?? "",
            "guests_allowed": eventDetail.guests_allowed ?? 0,
            "price": eventDetail.price ?? 0,
            "userId": UserDefaultsManager.shared.getDocumentId(),
            "organizer": organizer
        ]
        
        meetingsCollection.addDocument(data: meetingData) { error in
            if let error = error {
                print("Error adding meeting request: \(error)")
                completion(false)
            } else {
                print("Event added successfully")
                completion(true)
            }
        }
    }
    
    func addInFavorite(favBool: Bool, eventDetail: EventDetailData, organiser: Organizer, completion: @escaping (Bool) -> Void) {
        let userId = UserDefaultsManager.shared.getDocumentId()
        let documentReference = db.collection("FavouriteEvent").document(userId)
        
        // Create the organizer dictionary
        let organizer: [String: Any] = [
            "name": organiser.name ?? "",
            "email": organiser.email ?? "",
            "contact": organiser.contact ?? "",
            "address": organiser.address ?? "",
            "inField": organiser.inField ?? "",
            "eventsDone": organiser.eventsDone ?? 0,
            "rating": organiser.rating ?? 0.0
        ]
        
        // Create the event data dictionary
        let meetingData: [String: Any] = [
            "event_title": eventDetail.event_title ?? "",
            "description": eventDetail.description ?? "",
            "date": eventDetail.date ?? "",
            "location": eventDetail.location ?? "",
            "guests_allowed": eventDetail.guests_allowed ?? 0,
            "price": eventDetail.price ?? "",
            "organizer": organizer
        ]
        
        // Function to add or remove the meeting data from the "events" array field
        func updateFavorite(favBool: Bool) {
            let updateData = favBool ? FieldValue.arrayUnion([meetingData]) : FieldValue.arrayRemove([meetingData])
            documentReference.updateData(["events": updateData]) { error in
                if let error = error {
                    print("Error updating favorites: \(error)")
                    completion(false)
                } else {
                    let action = favBool ? "added to" : "removed from"
                    print("Event \(action) favorites successfully")
                    completion(true)
                }
            }
        }
        
        // Check if the document exists before updating it
        documentReference.getDocument { documentSnapshot, error in
            if let error = error {
                print("Error checking document existence: \(error)")
                completion(false)
                return
            }
            
            if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                // Document exists, proceed to update it
                updateFavorite(favBool: favBool)
            } else {
                // Document does not exist, create it and then update
                documentReference.setData(["events": FieldValue.arrayUnion([meetingData])]) { error in
                    if let error = error {
                        print("Error creating document: \(error)")
                        completion(false)
                    } else {
                        print("Document created and event added to favorites successfully")
                        completion(true)
                    }
                }
            }
        }
    }

    
    func getEventHistory(completion: @escaping ([EventDetailData]) -> Void) {
        
        let id = UserDefaultsManager.shared.getDocumentId()

        self.db.collection("BookEvent").whereField("userId", isEqualTo: id).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error getting accommodation offers: \(error.localizedDescription)")
                    completion([])
                } else {
                    
                    var list: [EventDetailData] = []
                    
                    for document in querySnapshot!.documents {
                        do {
                            var temp = try document.data(as: EventDetailData.self)
                            list.append(temp)
                        } catch let error {
                            print(error)
                        }
                    }
                    completion(list)
                }
            }
    }
    
    func fetchFavoriteEvents(completion: @escaping ([EventDetailData]) -> Void) {
        let userId = UserDefaultsManager.shared.getDocumentId()
        let documentReference = db.collection("FavouriteEvent").document(userId)
        
        documentReference.getDocument { (documentSnapshot, error) in
            if let error = error {
                print("Error getting favorite events: \(error.localizedDescription)")
                completion([])
            } else if let documentSnapshot = documentSnapshot, documentSnapshot.exists {
                // Retrieve the events array from the document
                guard let eventsData = documentSnapshot.data()?["events"] as? [[String: Any]] else {
                    // If there's no events field in the document, return an empty list
                    completion([])
                    return
                }
                
                var eventDetailsList: [EventDetailData] = []
                
                // Use JSONDecoder to parse each event data dictionary into EventDetailData
                let decoder = JSONDecoder()
                
                for eventData in eventsData {
                    do {
                        // Convert eventData dictionary to JSON data
                        let jsonData = try JSONSerialization.data(withJSONObject: eventData, options: [])
                        
                        // Decode JSON data into EventDetailData using JSONDecoder
                        let eventDetail = try decoder.decode(EventDetailData.self, from: jsonData)
                        
                        // Append to the list
                        eventDetailsList.append(eventDetail)
                    } catch {
                        print("Error parsing EventDetailData: \(error)")
                    }
                }
                
                // Return the list of EventDetailData
                completion(eventDetailsList)
            } else {
                print("Document does not exist or has no data")
                completion([])
            }
        }
    }


    
    func updateProfile(documentID: String, user: UserRegistrationModel, completion: @escaping (Bool) -> Void) {
        let query = db.collection("Users").document(documentID)
        
        let userData = [
            "firstname": user.firstname ?? "",
            "lastname": user.lastname ?? "",
            "email": user.email ?? "",
            "phone": user.phone ?? "",
            "password": user.password ?? ""
        ]
        
        query.updateData(userData) { error in
            if let error = error {
                print("Error updating Firestore data: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Profile data updated successfully")
                completion(true)
            }
        }
    }

}
