# EloraDelpierre_12_23022023
P12 Foster App


# Foster App

FosterApp is an orphan kitten management application for cat rescue associations. It lets you create and save kittens, record medical and administrative follow-up and provide breeding advice. In particular, you can keep track of each kitten's weight gain and meals, to make sure they are progressing well. 

This application was developed as part of a work-study programme, so it was decided to use the company's architecture and libraries. 

<p align="center"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.20.24.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.21.21.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.22.38.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.24.03.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.25.26.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.26.08.png" height="500"><img src="FosterApp_Screenshot/Simulator Screenshot - iPhone 15 - 2024-03-04 at 15.27.32.png" height="500"></p>

## Pods 

  <a href="https://github.com/rgmc95/UtilsKit"><img alt="Swift" src="https://img.shields.io/badge/UtilsKit-02569B?style=flat-square"
/></a> by Michael Coqueret

  <a href="https://cocoapods.org/pods/coredatautilskit"><img alt="Swift" src="https://img.shields.io/badge/CoreDataUtilsKit-02569B?style=flat-square"
/></a> by Michael Coqueret 

  <a href="https://cocoapods.org/pods/NetworkUtilsKit"><img alt="Swift" src="https://img.shields.io/badge/NetworkUtilsKit-02569B?style=flat-square"
/></a> by Michael Coqueret

  <a href="https://cocoapods.org/pods/SDWebImage"><img alt="Swift" src="https://img.shields.io/badge/SDWebImage-02569H?style=flat-square"
/></a>

<img alt="Swift" src="https://img.shields.io/badge/Combine-02569H?style=flat-square"
/>

## Custom Clean Archi 

This application was developed as part of a work-study programme, so it was decided to use the company's architecture and libraries. 

The Clean Swift architecture, also known as the VIP (View, Interactor, Presenter) architecture, is a software design approach for iOS applications that aims to improve the readability, separation of concerns and ease of maintenance of the code. It is organised as follows:

The View Controller:
* Defines a scene where user interactions occur and manages one or more views.
* Holds instances of the interactor and the view model to separate display logic from business logic.
* Transfers user actions, captured by the views, to the interactor, acting as a conduit between the user interface and the business logic (output).
The Interactor:
* Contains the business logic of the application, handling actions and usage rules.
* Maintains a reference to the presenter to communicate the results of the business logic.
* Interacts with workers to execute actions based on inputs (from the View Controller) and relays results (output) to the presenter.
The Worker:
* Serves as an abstraction layer that handles technical operations such as fetching data from APIs, querying and updating via Core Data, and more.
* Can be utilized by the interactor to delegate specific tasks, thereby reducing the complexity within the interactor.
The Presenter:
* Handles the display logic, preparing the data for presentation on the screen based on the outcomes provided by the interactor.
* Populates the view model variables with data formatted for display, facilitating updates to the user interface.
* Keeps a reference to the view model to push the prepared display data towards the view.
The View Model:
* Contains data prepared by the presenter in a form that is directly consumable by the views, simplifying the user interface updates.
* Is designed to be a straightforward object, devoid of knowledge or dependencies on other components of the VIP architecture, making it highly testable and reusable.
Utilizing this architecture, developers achieve a clear separation of concerns, where each component has a defined role and interacts with others in a predictable and organized manner. This makes the code easier to follow, test, and maintain.
This version of Clean Architecture omits the abstraction layer of protocols, directly utilizing concrete classes for clearer and potentially simpler interactions between layers.



## Install

Install pods and run
