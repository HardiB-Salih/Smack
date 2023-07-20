# Smack - A Chat Application

<img src="https://filedn.com/lgYM5v25LH64Wknu6KIrjpj/Client%20Project/Innovative%20Candor/GitHub/Smack/smack1024.png" alt="Smack Logo" width="200">

Smack is a chat application that allows users to connect and communicate with each other in real-time. It utilizes Firebase for authentication and Firestore for storing chat data, providing a seamless and secure chatting experience. The app is built using SwiftUI for the user interface and follows the MVVM architecture for data processing.

## Getting Started

Follow these steps to set up Smack on your local development environment:

### Prerequisites

- Xcode: Ensure you have Xcode installed on your macOS system.
- Swift Package Manager (SPM): Smack uses Swift Package Manager for managing dependencies. SPM is integrated into Xcode, so you don't need to install anything separately.

### Installation

1. Clone the Smack repository to your local machine using the following command:

```bash
git clone https://github.com/HardiB-Salih/Smack.git
```

2. Navigate to the project directory:

```bash
cd smack
```

3. Open the Xcode project:

```bash
open Smack.xcodeproj
```

4. Xcode should automatically resolve and fetch the required packages specified in the `Package.swift` file. If it doesn't, you can manually fetch the packages by selecting **File** > **Swift Packages** > **Update to Latest Package Versions**.

### Configuration

1. Firebase Setup:
   - Create a new Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/).
   - Follow the instructions to add your iOS app to the Firebase project.
   - Download the `GoogleService-Info.plist` file and add it to your Xcode project (place it in the root folder of the project).
   - Enable Firebase Authentication and Firestore in the Firebase console.

2. Build and Run:
   - Select the desired simulator or a connected device in Xcode.
   - Press the "Build and Run" button (or `Cmd + R`) to build and run the Smack app on your chosen device.

## Features

- **Real-time Chatting**: Engage in real-time conversations with other users.
- **User Authentication**: Register and log in securely with Firebase Authentication.
- **Message History**: View and access your chat history at any time.
- **Custom Smile Structure**: Download and include custom smileys to enhance your chatting experience.
- **Animated User Interface**: Enjoy a visually appealing chat interface with smooth animations.

## Screenshots

<div style="display: flex; justify-content: space-between;">
  <img src="https://filedn.com/lgYM5v25LH64Wknu6KIrjpj/Client%20Project/Innovative%20Candor/GitHub/Smack/Simulator%20Screenshot%20-%20iPhone%2014%20-%202023-07-20%20at%2020.23.07.png" alt="Login Screen" width="300">
  <img src="https://filedn.com/lgYM5v25LH64Wknu6KIrjpj/Client%20Project/Innovative%20Candor/GitHub/Smack/Simulator%20Screenshot%20-%20iPhone%2014%20-%202023-07-20%20at%2020.23.01.png" alt="Chat Screen" width="300">
</div>

## Feedback and Support

If you encounter any issues or have suggestions for improvement, feel free to open an issue on the GitHub repository. We appreciate your feedback and contributions to make Smack even better.

## License

Smack is open-source and distributed under the [MIT License](https://innovativecandor.com/mit_license/). Feel free to use, modify, and distribute the code as per the terms of the license.

---

Thank you for choosing Smack! We hope you enjoy using the app as much as we enjoyed building it. Happy chatting! 😄🎉
