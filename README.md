Here's a detailed README for your Flutter project, including setup instructions, explanations on architecture, state management choices, and any assumptions made.

---

# Product App

## Overview

The **Product App** is a Flutter application that allows users to view a list of products, mark products as favorites, and view details about each product. The app features a product listing screen, a liked items screen, and a product details screen. It utilizes the BLoC (Business Logic Component) pattern for state management and includes features like infinite scrolling, search functionality, and favorite toggling.

## Features

- **Product List Screen**: Displays a list of products with support for infinite scrolling and searching.
- **Product Details Screen**: Shows detailed information about a selected product.
- **Liked Items Screen**: Lists products marked as favorites and allows navigating to product details.

## Setup Instructions

### Prerequisites

- Flutter SDK installed on your machine. Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install) to set it up.
- An IDE such as Android Studio or Visual Studio Code with Flutter and Dart plugins installed.

### Installation

1. **Clone the Repository**

   ```bash
   git clone <repository_url>
   cd product_app
   ```

2. **Install Dependencies**

   Run the following command to get all the required packages:

   ```bash
   flutter pub get
   ```

3. **Set Up Your Emulator or Device**

   Ensure you have an emulator running or a physical device connected to your machine.

4. **Run the Application**

   Use the following command to run the app:

   ```bash
   flutter run
   ```

## Architecture

The application follows the **Clean Architecture** principles and uses the **BLoC** pattern for state management.

### Folder Structure

- **`lib/`**: Contains all the Dart code for the application.
  - **`bloc/`**: Contains BLoC-related files.
    - **`product_bloc.dart`**: The BLoC class handling product-related events and states.
    - **`product_event.dart`**: Defines the events that the `ProductBloc` responds to.
    - **`product_state.dart`**: Defines the states that the `ProductBloc` can emit.
  - **`data/`**: Contains data-related files.
    - **`models/`**: Data models used in the application.
    - **`repositories/`**: Repository classes for data fetching and management.
  - **`utils/`**: Utility files, such as constants and helper functions.
  - **`view/`**: Contains UI components and screens.
    - **`screens/`**: Different screens of the app, such as product list and product details.
    - **`widgets/`**: Reusable widgets used across different screens.

### State Management

**BLoC (Business Logic Component)** is used for state management. BLoC helps in separating the business logic from the UI code. It allows the app to respond to user events and update the UI based on the state of the application.

- **ProductBloc**: Handles product-related logic, including fetching products, toggling favorite status, and managing the list of liked products.
- **Events**: Defined in `product_event.dart` and include events like `FetchProducts` and `ToggleFavoriteStatus`.
- **States**: Defined in `product_state.dart` and include states like `ProductInitial`, `ProductLoading`, `ProductLoaded`, and `ProductError`.

### Event Handling

Events trigger actions in the BLoC, such as fetching new products or toggling the favorite status of a product. The BLoC processes these events and emits new states based on the current state and the event received.

### State Management Choice

BLoC was chosen for its ability to manage complex state changes and provide a clear separation of business logic from the UI. It makes the application easier to test and maintain by managing state and events in a centralized manner.

## Assumptions

1. **Product Data**: It is assumed that product data is fetched from a remote repository. The repository layer is responsible for handling data retrieval and caching.
2. **Infinite Scrolling**: The product list screen supports infinite scrolling, where new products are fetched as the user scrolls to the bottom of the list.
3. **Search Functionality**: The search functionality filters products based on user input in real-time.
4. **Error Handling**: Basic error handling is implemented to display error messages if data fetching fails.

## Testing

### Unit Tests

Unit tests for BLoC classes and other business logic components are located in the `test/` directory. Run the tests using:

```bash
flutter test
```

### Widget Tests

Widget tests are also located in the `test/` directory and cover various UI components and interactions. Run the widget tests using:

```bash
flutter test
```

## Contributing

If you would like to contribute to the project, please fork the repository and create a pull request with your changes. Ensure that your code adheres to the project's coding standards and includes appropriate tests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Feel free to modify the README according to your project's specifics or additional requirements.
