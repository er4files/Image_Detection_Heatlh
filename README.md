# GenDetc - Gender Detection App

**GenDetc** is a mobile application built using Flutter and TensorFlow Lite, designed to detect gender from photos. This app uses deep learning models to predict gender (male or female) from an image and display the result along with a confidence percentage.

## Features

- **Image Classification**: Upload or capture an image to classify gender.
- **Confidence Score**: Displays the confidence percentage for the detected gender.
- **User-Friendly Interface**: Simple, clean UI for a seamless user experience.
- **On-Device Processing**: Powered by TensorFlow Lite for efficient, offline image classification.

## How It Works

1. The user selects an image from the gallery or takes a new picture with the camera.
2. The app processes the image using TensorFlow Lite's model to predict the gender.
3. The result is displayed along with the confidence score as a percentage.

## Tech Stack

- **Flutter**: For building the cross-platform mobile app.
- **TensorFlow Lite**: For running the deep learning model on-device.
- **Image Picker**: To select images from the gallery or take new photos with the camera.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- **Flutter SDK**: Install the Flutter SDK from [Flutter's official site](https://flutter.dev/docs/get-started/install).
- **Android Studio or Visual Studio Code**: For developing and running the Flutter app.
- **TensorFlow Lite Model**: Ensure you have a pre-trained model (`model.tflite`) and corresponding labels (`labels.txt`).

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/er4files/gendetc.git
   cd gendetc
   ```

2. **Install dependencies:**

   Navigate to the project directory and run:

   ```bash
   flutter pub get
   ```

3. **Add the TensorFlow Lite model and labels:**

   Place your `model.tflite` and `labels.txt` inside the `assets` folder. Make sure to update `pubspec.yaml` to include the assets:

   ```yaml
   flutter:
     assets:
       - assets/model.tflite
       - assets/labels.txt
   ```

4. **Run the app:**

   Connect your device or emulator and run:

   ```bash
   flutter run
   ```

## Project Structure

```bash
gendetc/
├── assets/
│   ├── model.tflite     # TensorFlow Lite model
│   └── labels.txt       # Labels file for the model
├── lib/
│   ├── screens/
│   │   ├── main_activity.dart  # Main screen with image picker and analyzer
│   │   └── result_activity.dart # Result screen showing prediction
│   └── main.dart        # App entry point
├── pubspec.yaml         # Flutter dependencies and asset configurations
└── README.md            # Project documentation
```

## How To Use

1. **Select Image**: Open the app and tap the image box to select an image from the gallery or take a photo using the camera.
2. **Analyze**: Once the image is selected, tap the "Analyze" button to run gender detection.
3. **View Result**: The app will display the detected gender along with the confidence score as a percentage.

## Dependencies

- [Image Picker](https://pub.dev/packages/image_picker): For selecting images from the gallery or taking photos.
- [TensorFlow Lite v2](https://pub.dev/packages/tflite_v2): For running the TensorFlow Lite model on-device.

Your dependencies in `pubspec.yaml` will look like this:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^0.8.7
  tflite_v2: ^1.0.0
```

## Model Information

The gender detection model (`model.tflite`) is a pre-trained deep learning model optimized for mobile devices using TensorFlow Lite. The model takes an image as input and outputs a gender prediction along with a confidence score. Ensure the model and the corresponding `labels.txt` are included in the `assets` folder.

## Future Improvements

- Add more detailed feedback based on the confidence levels.
- Improve the UI with enhanced animations and transitions.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Contact

If you have any questions, feel free to contact me at [rahmaderasugiarto@gmail.com](mailto:rahmaderasugiarto@gmail.com).