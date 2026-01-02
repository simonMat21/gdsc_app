# 📝 Notes App

A beautiful, feature-rich notes application built with Flutter. Create, organize, and manage your notes with a clean Material Design 3 interface.

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

- 📝 **Create & Edit Notes** - Write notes with titles and content
- 🎨 **Color-coded Notes** - Choose from 8 beautiful pastel colors to organize your notes
- 📌 **Pin Important Notes** - Pin notes to keep them at the top
- 🔍 **Search Notes** - Quickly find notes by title or content
- 🌙 **Dark Mode** - Toggle between light and dark themes
- 💾 **Local Storage** - Notes are stored locally using Hive database
- 📱 **Cross-platform** - Works on Android, iOS, Web, Windows, macOS, and Linux

<!-- ## 📸 Screenshots

|           Light Mode           |     Dark Mode      |
| :----------------------------: | :----------------: |
| Notes grid with colorful cards | Dark theme support | -->

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.10.3 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.10.3 or higher)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/notes-app.git
   cd notes-app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters** (if needed)

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── note.dart               # Note model with Hive annotations
│   └── note.g.dart             # Generated Hive adapter
├── providers/
│   └── notes_provider.dart     # State management with Provider
├── screens/
│   ├── notes_screen.dart       # Main notes list screen
│   └── add_edit_note_screen.dart # Create/edit note screen
├── services/
│   └── notes_database.dart     # Hive database service
└── widgets/
    ├── note_card.dart          # Note card widget
    └── color_picker.dart       # Color selection widget
```

## 🛠️ Tech Stack

| Technology     | Purpose              |
| :------------- | :------------------- |
| **Flutter**    | UI Framework         |
| **Provider**   | State Management     |
| **Hive**       | Local NoSQL Database |
| **Material 3** | Design System        |
| **UUID**       | Unique ID Generation |

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.0.0 # State management
  hive: ^2.2.3 # Local database
  hive_flutter: ^1.1.0 # Hive Flutter integration
  path_provider: ^2.1.1 # File system access
  intl: ^0.19.0 # Date formatting
  uuid: ^4.0.0 # Unique ID generation

dev_dependencies:
  hive_generator: ^2.0.1 # Hive code generation
  build_runner: ^2.4.6 # Code generation runner
```

## 🎨 Color Palette

The app includes 8 beautiful pastel colors for notes:

| Color            | Preview |
| :--------------- | :-----: |
| Light Green      |   🟢    |
| Light Purple     |   🟣    |
| Light Yellow     |   🟡    |
| Light Orange     |   🟠    |
| Light Orange-Red |   🔴    |
| Light Red        |   ❤️    |
| Light Pink       |   💗    |
| Light Blue       |   🔵    |

## 📖 Usage

### Creating a Note

1. Tap the **+** floating action button
2. Enter a title and content
3. Select a color from the palette (tap the color circle in the app bar)
4. Tap the checkmark to save

### Editing a Note

1. Tap on any note card to open it
2. Modify the title, content, or color
3. Tap the checkmark to save changes

### Pinning a Note

- Long press on a note or use the pin icon to pin/unpin
- Pinned notes appear at the top of the list

### Searching Notes

- Use the search bar at the top to filter notes by title or content

### Dark Mode

- Tap the moon/sun icon in the app bar to toggle dark mode

## 🧪 Running Tests

```bash
flutter test
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [Hive Documentation](https://docs.hivedb.dev/)
- [Material Design 3](https://m3.material.io/)

---

<p align="center">Made with ❤️ using Flutter</p>
