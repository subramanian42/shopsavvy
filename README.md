# Shop Savvy

Shop Savvy is a mobile application built using Flutter that allows users to browse and view products. It includes features such as social login, product listing, product details, and user profile management.

## Screens

The application consists of the following screens:

1. **Login**: This screen is displayed when the user is not logged in. It provides social login options using Google or LinkedIn.

2. **Home**: After successful login, the user is redirected to the home screen. This screen displays a list of products fetched from the backend using the Punk API. The products are presented in a scrollable list view, supporting pull-to-refresh and scroll-to-load-more functionality.

3. **Product Detail**: When a user selects a product from the home screen, the product detail screen is displayed. This screen provides comprehensive details about the selected product as received from the API.

4. **Profile**: The profile screen contains basic user information and an option to logout.

##Screenshots
| | | | |
|:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="200" alt="Login Page" src="assets/screenshots/Screenshot_1.png"> |  <img width="200" alt="home page" src="assets/screenshots/Screenshot_2.png"> | <img width="200" alt="Repository View Page" src="assets/screenshots/Screenshot_3.png"> | <img width="200" alt="File Explorer" src="assets/screenshots/Screenshot_4.png"> |


## Requirements

To set up and run the application, please ensure you have the following:

- Flutter SDK (minimum version 3.10.0)
- Dart SDK (minimum version 3.0.0)
- A code editor (e.g., Visual Studio Code)
- Emulator or physical device for testing
- Firebase project with Firebase Authentication enabled

## Installation Instructions

1. Clone the repository to your local machine:

```bash
git clone [repository_url]
```
2. Change to the project directory:
```bash
cd shop-savvy
```
3.Install the required dependencies:
```bash
flutter pub get
```
Certainly! Here's the unrendered markdown for the Firebase Authentication installation instructions:

bash
Copy code
## Installation Instructions

1. Clone the repository to your local machine:

```bash
git clone [repository_url]
Change to the project directory:


cd shop-savvy
Install the required dependencies:

flutter pub get
```


Configure Firebase Authentication:
Create a new Firebase project in the Firebase Console.
Enable Firebase Authentication in your project.
Download the google-services.json file from the Firebase project settings.
Place the google-services.json file in the android/app directory of your Flutter project.
Update the android/build.gradle file as follows:
```groovy
buildscript {
    dependencies {
        // ...
        classpath 'com.google.gms:google-services:version-number' // Update the version number
    }
}

allprojects {
    // ...
    repositories {
        // ...
        google() // Add this line
    }
}
```
Update the android/app/build.gradle file as follows:
```groovy

apply plugin: 'com.android.application'
apply plugin: 'com.google.gms.google-services' // Add this line

// ...
```
Linkedin auth Provider
1. create and configure shop_savvy_secrets.json file refer sample.json for the format.
2. add client id, client secret to the shop_savvy_secrets.json file.
3. run flutter with --dart-define-from-file to configure the app with shopsavvy secrets.
```bash
flutter run --dart-define-from-file shop_savvy_secrets.json
```

Now the Shop Savvy app is configured with Firebase Authentication. Users can log in using the social login options provided (Google or LinkedIn).

## Dependencies and Libraries

The application utilizes the following dependencies and libraries:

- **flutter_bloc**: A state management library for Flutter, used for managing application state using the BLoC pattern.

- **go_router**: A routing library for Flutter, used for handling navigation between different screens in the application.

- **http**: A package for making HTTP requests, used for fetching data from the backend API.

- **firebase_auth**: The official Firebase plugin for Flutter, used for integrating Firebase Authentication.

## Assumptions

The following assumptions were made during the development of the Shop Savvy application:

1. The user authentication process is handled entirely by the social login APIs (Google, LinkedIn) provided by Firebase Authentication.
2. The backend API provided by Punk API is used for retrieving the product data.
3. The design and layout of the application follow the specifications provided in the Figma design.
4. Meta now requires all NEWLY entered package names to be associated with a valid google play store URL hence has not been implemented[link](https://developers.facebook.com/support/bugs/1307870196812047/?join_id=f12e5a3b52a432)

## Project Structure

The project follows a clean code architecture, with separation of concerns and modularity. It includes the following folders:

- **lib**: Contains the main application code.
  - **core**: contains all reusable widgets, themes and other core components.   
    - **repository**: Handles data-related operations, including API calls.
    - **models**:contains all the required models.
    - **routes**: Contains route definitions and navigation setup using Go Router.
    - **utils**: Provides utility functions and helper classes.
  - **presentation**: Contains the UI components and screens, organized by feature.
    - **controller**: Handles the state management using the BLoC pattern and connects the UI with the domain layer.
    - **view**: Contains the UI components and screens

