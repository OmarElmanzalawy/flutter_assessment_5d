# Meal Tracking App

## Tools & Frameworks

- **Flutter**: Cross-platform UI framework for building natively compiled applications
- **Riverpod**: State management solution for Flutter applications
- **GoRouter**: Declarative routing package for Flutter
- **SharedPreferences**: Local storage for persisting meal data
- **ImagePicker**: Package for selecting images from device gallery or camera

## Running the App

1. Ensure you have Flutter installed on your machine. If not, follow the [official installation guide](https://flutter.dev/docs/get-started/install)

2. Clone the repository:
   ```bash
   git clone <repository-url>
   cd assessment_5d
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Responsive Design Approach

The app implements a responsive design strategy to ensure optimal user experience across different screen sizes:

- **Flexible Layouts**: Using MediaQuery to adapt UI elements based on screen dimensions
- **Adaptive Widgets**: Implementing widgets that automatically adjust their size and layout
- **Dynamic Sizing**: Utilizing relative sizing (e.g., percentage-based dimensions) for UI components
- **Responsive Typography**: Scaling text sizes based on device screen size
- **Flexible Grid System**: Implementing an adaptive grid layout for meal items

This approach ensures the app maintains its functionality and visual appeal across various devices, from mobile phones to tablets.
