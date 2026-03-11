# Taghyeer Task — Flutter App

A production-quality Flutter mobile application built as a technical assignment for **Taghyeer Technologies**. The app demonstrates clean architecture, state management with GetX, API integration, pagination, session handling, local caching, and theme management.

---

## ✨ Features

- 🔐 **User Authentication** — Login with session persistence and auto-login on restart
- 🛍️ **Products Tab** — Paginated product list with thumbnail, title, and price
- 📝 **Posts Tab** — Paginated post feed with title and body preview
- ⚙️ **Settings Tab** — User profile info, theme toggle, and logout
- 🌙 **Dark / Light Mode** — Persisted across app restarts with full app restart on toggle
- 📄 **Detail Screens** — Product and Post detail pages (bonus)
- ♻️ **Pull to Refresh** — On both Products and Posts
- 🔌 **Error Handling** — No internet, API failure, empty state, and pagination failure all gracefully handled

---

## 🔑 Demo Login Credentials

```
Username: emilys
Password: emilyspass
```

> These are valid credentials from the [DummyJSON](https://dummyjson.com) open API — no API key required.

## 🏗️ Architecture

The project follows a **feature-first clean architecture** structure:

```
lib/
├── main.dart
├── core/
│   ├── config/          # AppColors, AppSizes, AppConstants, AppUrl
│   ├── network/         # NetworkCaller, NetworkResponse
│   ├── routes/          # AppRoutes, AppPages (GetX routing)
│   ├── services/        # UserSessionService
│   ├── storage/         # GetStorage wrapper, SecureStorage
│   └── themes/          # LightTheme, DarkTheme, ThemeManager
└── features/
    ├── auth/            # Login screen, controller, binding, UserModel
    ├── main_nav/        # Bottom navigation shell
    ├── products/        # Products list, detail, card, controller
    ├── posts/           # Posts list, detail, card, controller
    └── settings/        # Settings screen, theme toggle, logout
```

---

## 🔧 Tech Stack

| Layer            | Technology                       |
|------------------|----------------------------------|
| Framework        | Flutter 3.x                      |
| State Management | GetX                             |
| Local Storage    | GetStorage, FlutterSecureStorage |
| HTTP Client      | http                             |

| API             | [DummyJSON](https://dummyjson.com) |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK `>=3.0.0`
- Dart SDK `>=3.0.0`

### Installation

```bash
git clone https://github.com/shahriartoky0/taghyeer_task
cd taghyeer_task
flutter pub get
flutter run
```



---

## 📡 API Endpoints Used

| Feature  | Method | Endpoint                                         |
|----------|--------|--------------------------------------------------|
| Login    | POST   | `https://dummyjson.com/auth/login`               |
| Products | GET    | `https://dummyjson.com/products?limit=10&skip=0` |
| Posts    | GET    | `https://dummyjson.com/posts?limit=10&skip=0`    |

Pagination is implemented using `skip` increments of 10, triggered when the user scrolls near the bottom of the list.

---

## 🧩 Requirements Coverage

| Requirement                                 | Status |
|---------------------------------------------|--------|
| Login screen with username & password       | ✅      |
| Save user data locally on login             | ✅      |
| Auto-login on app restart                   | ✅      |
| Clear session on logout                     | ✅      |
| Products tab with pagination                | ✅      |
| Posts tab with pagination                   | ✅      |
| Settings — cached user info                 | ✅      |
| Settings — theme toggle (persisted)         | ✅      |
| Settings — logout with redirect             | ✅      |
| Loading / error / empty / pagination states | ✅      |
| Product detail screen _(bonus)_             | ✅      |
| Post detail screen _(bonus)_                | ✅      |

---

## 📬 Contact

Built by **[Golam Shahriar Toky]** — [tokyshahriar555@gmail.com]