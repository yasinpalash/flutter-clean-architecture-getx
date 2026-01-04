# Flutter Clean Architecture with GetX

A **scalable, production-ready Flutter application** built using **Clean Architecture principles**, **GetX** for state management & dependency injection, and **Dio** for networking.

This project demonstrates **real-world architecture**, **proper error handling**, **API abstraction**, and **feature-based modular design**.

---

##  Features
-  Clean Architecture (Data / Domain / Presentation)
-  GetX (State Management, Routing, Dependency Injection)
-  Dio with Interceptors
-  Centralized API Client
-  Global Network & HTTP Error Handling
-  Repository Pattern
-  Feature-based Modular Structure
-  Result & Response Wrapper Pattern
-  Scalable & Maintainable Codebase

---
##  Folder Structure
```txt
lib/
│
├── core/
│   ├── bindings/                 # Global GetX bindings
│   ├── common/                   # Shared widgets & helpers
│   ├── constants/                # App constants (URLs, colors, sizes)
│   ├── di/                       # Dependency injection setup
│   ├── errors/                   # App & network exceptions
│   ├── localization/             # Localization & translations
│   ├── network/
│   │   ├── interceptors/         # Dio interceptors
│   │   ├── api_client.dart       # Base Dio client
│   │   ├── network_caller.dart   # API call handler
│   │   ├── response_data.dart    # API response wrapper
│   │   ├── result.dart           # Success / Failure result pattern
│   │   └── server_exception.dart # Server & network exceptions
│   ├── services/                 # Auth, storage, listeners
│   └── utils/                    # Logger, validators, helpers
│
├── features/
│   ├── authentication/
│   │   ├── controllers/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   └── courses/
│       ├── controllers/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── routes/
│   └── app_routes.dart           # GetX named routes
│
├── app.dart                      # Root GetMaterialApp
└── main.dart                     # Application entry point
