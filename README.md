---

# AttendPro

## Overview

AttendPro is a modern attendance application that simplifies the process of marking and managing student attendance. Designed to be intuitive and efficient, AttendPro allows educators to easily mark attendance subject-wise and year-wise. This ensures that attendance records are well-organized and easily accessible, enhancing the overall attendance management experience.

## Features

- **Easy Attendance Marking**: Quickly mark attendance for students subject-wise and year-wise.
- **Visual Attendance Reports**: Display student attendance percentages in a visual pie chart, showing the proportion of present and absent days.
- **Fine Calculator**: Calculate fines for student absences automatically, helping institutions manage attendance policies effectively.
- **Database Integration**: Store and manage attendance records securely in the Firebase database.
- **User Authentication**: Secure user authentication implemented using Firebase, ensuring that only authorized personnel can access and manage attendance records.
- **User-Friendly Interface**: Clean and intuitive design that prioritizes user experience.

## Technology Stack

- **Flutter**: For building a beautiful and responsive UI.
- **Firebase**: For user authentication and data management.
- **FlutterFire**: To integrate Firebase services within the Flutter application.

## Screenshots

Below are some screenshots showcasing the AttendPro app in action:
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e79f19b8-6944-4b72-8589-a5a029f4f300" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/f5e688d7-4b74-4280-8087-933064553007" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/081d1009-09ae-48ac-a983-2998d3bdbcc4" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/b2605449-4692-45b0-a9fc-302ff822d57b" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/b46dd8d6-d0cf-4f67-9aeb-c6bc0f39338f" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/11eab0f2-2ce2-4938-a3c6-4f8aff37c666" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/58879767-64b9-469c-bc42-94121b5063f8" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/e92e755f-025c-47a6-930d-f10799d9e2e5" width="200"/></td>
  </tr>
</table>

## Getting Started

### Prerequisites

- Flutter SDK
- Firebase project setup (follow [Firebase setup instructions](https://firebase.flutter.dev/docs/overview/))

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/AttendPro.git
    ```
2. Navigate to the project directory:
    ```sh
    cd AttendPro
    ```
3. Install dependencies:
    ```sh
    flutter pub get
    ```
4. Set up Firebase:
   - Follow the [Firebase setup instructions](https://firebase.flutter.dev/docs/overview/) to connect your project to Firebase.
   - Add your `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files to the respective directories.
5. Run the app:
    ```sh
    flutter run
    ```

## Usage

1. **Login**: Use your credentials to log in to the app.
2. **Mark Attendance**: Select the subject and year to mark attendance for students.
3. **View Attendance Reports**: Access visual pie charts to see attendance percentages.
4. **Calculate Fines**: Use the fine calculator to automatically calculate fines for absences.
5. **View Attendance Records**: Access and manage attendance records easily.

## Contribution

Contributions are welcome! Please open an issue or submit a pull request for any improvements or suggestions.

## License

Distributed under the MIT License. See `LICENSE` for more information.

---
