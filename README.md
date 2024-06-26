# 44643Sec04Team08Spring2024FinalProject

Roles and Responsibilities :
1. Rakesh Somanaboina: Responsible for back end development which includes programming, implentation of APIs, Authentication and data security.
2. Jaswitha Kalikiri: Responsible for front end development which includes UI design, including animations and transitions, layout and responsive design.
3. Divya Sarvepalli: Responsible for database design, implementation of CRUD operations and documentation.
4. Kumar Chandu  Mallireddy: Responsible for operations between front end and back end which includes programming using swift, error handling and testing.

## Screens in the app

![home page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/ae5f9b18-9430-4085-b8a1-8d3d35b9fb8f)
![login page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/1b28f68b-f6e1-491e-98cf-bc2510b0a5eb)
![sign in page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/21520fc4-9951-4891-87e3-0362a5bf96e6)
![main screen](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/095f9a17-a13c-4867-8c53-185f14774535)
![menu button](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/c4e300cb-91d7-4950-b8be-ca3df2b641ea)
![calendar](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/b3efe2b7-2b50-46dd-986d-14067fb76938)
![favorites](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/21a8c0de-1596-40f9-a295-8bfb231faf33)
![profile](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/a5fdbe21-cf6c-4d2f-b7e3-191ffc90c080)
![filter page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/f0dac4b9-eacf-4796-9a52-5a950b81c4ab)
![event display](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/e88cd762-cf85-4765-9b3e-6bb2d916d2ff)
![call page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/35daaa4c-fa6f-4afc-9dfb-fc02aa26c930)
![event organizer](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/d578cf20-6484-40ee-9761-b8c745ee328a)
![Booking page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/456f51c8-a976-4ff9-a790-8bd244bc4c43)
![Booking confirm Page](https://github.com/Jaswitha-20/44643Sec04Team08Spring2024FinalProject/assets/120734922/d4e07ca5-adfd-4def-874e-a8c974fe726f)

### Navigation Among Screens

This app basically acts as a third party between users and event organizer teams.
1.	Login:
When the user clicks on the “Get Started” button it will direct you to screen 2 which is the login page. If it's an existing user, you can just login. If not, create an account using sign up.

2.	Type of Event Selection:
After login, you can see the Screen 3 which displays multiple types of events according to your choice.

3.	Type of Decor and event organizer Selection:
After clicking on the event gesture, it will direct you to screen 4 which shows multiple event decors. You can filter out according to your choice or  simply choose from displayed options and you can scroll down.


4.	Organizer details:
After selecting the decor, the event organizer details will be displayed on screen 5. In which you can see the event organizer details.
In case you like the organizing team you can add it to your favorites.

5.	Booking:
After pressing the “Book Now” button, it will redirect to the booking page as shown in screen 6. After reviewing you can book the event with them.

6.	Booking Confirmation:
After clicking on the “Confirm Booking” button , your booking will be confirmed with the particular event organizing team and a confirmation mail will be sent to your registered email.

### Initial Developement for Screen 1 and 2

##  Created Screen 1 
     Added UI Elements and contstraints 
     Added lottie animation
     Included Audio PlayServices
     Added Animated Gradient view
     Added Outlets and Actions for appropriate UI Elments for Screen 1

## Created Screen 2
     Added UI Elements and Contstraints 
     Included Audio Play System Services
     Added Animated gradient view
     Added outlets and actions for appropriate UI Elements for Screen 2

## Naviagtion 1
     Created navigation from screen 1 to screen 2 ( When user clicked on the Get Started button it will navigate to Login page)


============================================================================================

## Modifications Screen 2 
     Added required labels and buttons in the page
     Replaced the loginVC into LoginViewController as earlier was not accepting any modifications
     Updated Animated gradient view
### Basic functionality
     Added logic for validation of email and password fields
     Added logic to show password textually

## Created Screen 3
      Added UI Elements and Contstraints 
      Included Audio Play System Services
      Created a viewController for screen 3
      Added outlets and actions for appropriate UI Elements for Screen 3
      Added Animated gradient view
### Basic functionality
     Added validation logic(email, password format verification and empty fields verification) in the Signup page.

## Navigation 
     Integrated proper navigation between the screens along with the back flow for the application.

===========================================================================================

## Created Reset Password Screen

     Added UI elements and Constraints
     Created a view controller for this screen
     Added outlets and actions for reset password screen
     Added animated gradient view

## FireBaseDatabase

     Created firebase database and added  GoogleService-Info.plist file into the project

### Added Tab bar controller which acomodates Home Screen, Favorites Screen, Profile Screen, and  Calendar Screen

#### In Home Screen 

      Added UI elements and Constraints
      Created a view controller for this screen
      Added outlets and actions for those screens
      Added animated gradient view
      Added Images and Searchbar for the home Screen
      Implements tap gesture functionality 

#### In Profile Screen 

      Added UI elements like imageview, labels, Logout button
      Created a view controller for this screen
      Added animated gradient view
      Added outlets and actions for those screens
 
## Navigation 
     Integrated proper navigation between the screens along with the back flow for the application.


## Created calendar Screen
     Added UI elements and constraints for calendar 
     Created a view controller for this screen
     Added outlets and actions 
     Added functionality for request access and fetch events

## FirebaseDatabase
      Added added the logic for User authentication in firebase
      Added the logic for User authentication in firebase

### Added functionality for Logout Screen

## Created Screen 4
     Added screen 4 with scroll view
     Added event catrgories details into json file for API
     Collected and added reguired images for the project(Due to space added only few images and committing)
     Created Class & outlets for EventDetails Screen
## Created Outlets, class for Screen 5

