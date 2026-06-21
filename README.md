# 📝 Task Manager App (Flutter + Provider)

A simple and efficient Task Manager application built with **Flutter** using **Provider state management**. This app allows users to create, update, delete, and manage daily tasks with a clean UI and smooth performance.

---

## 🚀 Features

- ➕ Add new tasks
- ✏️ Edit existing tasks
- ❌ Delete tasks
- ✔️ Mark tasks as completed / pending
- 🔄 Real-time UI updates using Provider
- 🎨 Clean and responsive Material 3 UI
- ⚡ Optimized state management (no setState for task logic)

---

## 🛠️ Tech Stack

- Flutter
- Dart
- Provider (State Management)

---

## 📁 Project Structure
lib/
├── main.dart
├── models/
│ └── task_model.dart
├── providers/
│ └── task_provider.dart
├── screens/
│ ├── home_screen.dart
│ └── add_task_screen.dart
├── widgets/
│ └── task_tile.dart


---

## 📦 Installation & Setup

1. Clone the repository
```bash
git clone https://github.com/shahzaibtahir90/task_manager_app.git

cd task_manager_app
flutter pub get
flutter run