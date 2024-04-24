# Travel Routes App

This Flutter app allows users to create and view travel routes.

## Features

- Create travel routes by specifying origin, destination, travel date, and weight allowance.
- View available travel routes with details such as origin, destination, travel date, and weight allowance.
- Navigate between screens to create and view travel routes.

## Screens

### Create Post Screen

This screen allows users to create a new travel route by providing the following details:
- Origin Airport
- Destination Airport
- Travel Date
- Weight Allowance

### Available Routes Screen

This screen displays a list of available travel routes. Each route is represented with the following information:
- Origin and Destination
- Travel Date
- Weight Allowance

## Getting Started

To run this project, make sure you have Flutter installed on your local machine. Then, clone this repository and run the app using Flutter CLI commands.

```bash
git clone https://github.com/your_username/travel_routes_app.git
cd travel_routes_app
flutter run
```
## Dependencies

 - `flutter_svg` - Used for displaying SVG icons in the app.
 - `cloud_firestore` - Firebase Firestore plugin for Flutter.

## Thought Process

### User Experience
- **Simplicity**: The app's user interface was designed to be simple and intuitive, with clear labels and minimalistic screens to reduce cognitive load on users.
- **Navigation**: Efforts were made to ensure smooth navigation between screens, allowing users to easily create and view travel routes without any confusion.
- **Feedback**: The app provides feedback to users in the form of loading indicators, error messages, and success notifications, ensuring a seamless user experience.

### Data Management
- **Real-Time Updates**: Utilizing Firebase Firestore allows for real-time synchronization of travel route data across devices, ensuring that users always have access to the latest information.
- **Efficiency**: Data retrieval and manipulation operations were optimized to minimize latency and improve overall app performance, providing a smooth user experience even with large datasets.

### Future Enhancements
- **User Authentication**: Implementing user authentication would allow for personalized experiences, such as saving favorite routes and accessing personalized recommendations.
- **Search Functionality**: Adding search functionality would enable users to quickly find specific routes based on criteria such as origin, destination, or travel date.
- **Sorting and Filtering**: Allowing users to sort and filter routes based on various parameters would enhance usability and make it easier to find relevant information.
