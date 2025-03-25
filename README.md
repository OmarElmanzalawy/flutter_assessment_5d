# Meal Tracking App

## Tools & Frameworks
- **Flutter**: Cross-platform UI framework for building natively compiled applications
- **Riverpod**: State management solution for Flutter applications
- **GoRouter**: Declarative routing package for Flutter
- **SharedPreferences**: Local storage for persisting meal data
- **ImagePicker**: Package for selecting images from device gallery or camera

## Getting Started
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

## How to run the App

### Installation Steps

1. **Download the APK**
   - Download the APK file
   - Alternatively, you can build the APK yourself using `flutter build apk`

2. **Enable Unknown Sources**
   - Go to your device's Settings
   - Navigate to Security or Privacy settings
   - Enable "Install from Unknown Sources" or "Install Unknown Apps"

3. **Install the App**
   - Locate the downloaded APK file using your file manager
   - Tap on the APK file to start installation
   - Review the requested permissions and tap "Install"
   - Wait for the installation to complete
   - Tap "Open" to launch the app

### Required Permissions
- Storage access (for meal images)
- Camera access (for taking meal photos)

