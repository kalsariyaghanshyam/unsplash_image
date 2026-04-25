# Unsplash Image Explorer

A beautiful and modern Flutter application that allows users to explore high-quality images powered by the Pixabay API. The app features a stunning UI with smooth animations and advanced filtering options.

## Features
- **Modern UI**: Clean and premium design with smooth micro-animations.
- **API Integration**: Fetches real-time image data using the Dio package for robust networking.
- **Advanced Filters**: Filter images by category, image type, orientation, and more.
- **Search**: Quickly find images using local search functionality.
- **Dark Mode Support**: Fully compatible with light and dark themes.
- **Pull-to-Refresh**: Easily refresh image feeds with a smooth pull-down gesture.
- **Responsive Layout**: Optimized for various screen sizes using staggered grid views.

## Tech Stack
- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Networking**: [Dio](https://pub.dev/packages/dio)
- **Backend/Services**: Firebase (Integration ready)
- **UI Components**: Staggered Grid, Lottie Animations, Animate Do

## Screenshots
| Home Screen | Image Details | Filter Drawer |
| :---: | :---: | :---: |
| ![Home](https://via.placeholder.com/200x400?text=Home+Screen) | ![Details](https://via.placeholder.com/200x400?text=Image+Details) | ![Filters](https://via.placeholder.com/200x400?text=Filter+Drawer) |

## Installation

### Prerequisites
- Flutter SDK installed on your machine.
- An API key from [Pixabay](https://pixabay.com/api/docs/).

### Steps
1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/unsplash_image.git
   cd unsplash_image
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure API Key**:
   Open `lib/app/data/network/data_provider/data_provider.dart` and replace the placeholder API key with your own.

4. **Run the app**:
   ```bash
   flutter run
   ```

## License
This project is licensed under the MIT License - see the LICENSE file for details.
