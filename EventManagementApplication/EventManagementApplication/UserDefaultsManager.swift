
import Foundation

class UserDefaultsManager  {
   
   static  let shared =  UserDefaultsManager()
   
   func clearUserDefaults() {
       
       let defaults = UserDefaults.standard
       let dictionary = defaults.dictionaryRepresentation()

           dictionary.keys.forEach
           {
               key in   defaults.removeObject(forKey: key)
           }
   }
       
   
   func isLoggedIn() -> Bool{
       
       let email = getEmail()
       
       if(email.isEmpty) {
           return false
       }else {
          return true
       }
     
   }
    
   func getEmail()-> String {
       
       let email = UserDefaults.standard.string(forKey: "email") ?? ""
       
       print(email)
      return email
   }
    
    func getPhone()-> String {
        
        let phone = UserDefaults.standard.string(forKey: "Phone") ?? ""
        
        print(phone)
       return phone
    }
   
   func getName()-> String {
      return UserDefaults.standard.string(forKey: "name") ?? ""
   }

   func getUserType()-> String {
      return UserDefaults.standard.string(forKey: "userType") ?? ""
   }
   
   func getDocumentId()-> String {
      return UserDefaults.standard.string(forKey: "documentId") ?? ""
   }
   
   func saveData(name:String, email:String, phone:String) {
       
       UserDefaults.standard.setValue(name, forKey: "name")
       UserDefaults.standard.setValue(email, forKey: "email")
       UserDefaults.standard.setValue(phone, forKey: "phone")
   }
 
   func clearData(){
       UserDefaults.standard.removeObject(forKey: "email")
       UserDefaults.standard.removeObject(forKey: "name")
       UserDefaults.standard.removeObject(forKey: "documentId")
   }
    
    func saveFavourite(title: String) {
      
        UserDefaults.standard.set(true, forKey: getEmail().lowercased() + title.lowercased())
    }
    
    // Function to get favorites
    func getFavorites(title: String) -> Bool {
        
        return UserDefaults.standard.bool(forKey:  getEmail().lowercased() + title.lowercased())
    }
    
    func removeFavorite(title: String) {
           UserDefaults.standard.removeObject(forKey: getEmail().lowercased() + title.lowercased())
    }
}
