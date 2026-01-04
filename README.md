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
## Project Description

The application is divided into three main layers:

- **Data Layer**
- **Domain Layer**
- **Presentation Layer**

Each layer has a single responsibility and communicates only through well-defined abstractions.

---

## 📦 Data Layer

The **Data layer** is the outermost layer of the application.  
It is responsible for fetching data from remote APIs, handling network communication, mapping responses to models, and implementing repository contracts defined in the Domain layer.

### a. Data Sources

Data Sources define how data is retrieved and stored.

#### 🔹 Remote Data Source
- Handles HTTP requests using **Dio**
- Uses a centralized `ApiClient`
- Communicates with REST APIs
- Converts API responses into structured models
- Returns data wrapped inside `Result<T>` for safe error handling

Examples:
- `LoginRemoteDataSource`
- `CourseRemoteDataSource`

> Local Data Sources (e.g. Hive / SharedPreferences) can be added later for caching or offline support.

---

### b. Repository Implementations

Repositories act as a **bridge between the Data layer and the Domain layer**.

- Implements repository interfaces defined in the Domain layer
- Coordinates data from one or more data sources
- Keeps the Domain layer independent of networking and storage details

Examples:
- `LoginRepositoryImpl`
- `CourseRepositoryImpl`

---

### c. Models

- Represent API request and response structures
- Responsible only for data serialization and deserialization
- Contain no business logic

Examples:
- `SignInRequest`
- `CoursesSessionModel`

---

## 🧠 Domain Layer

The **Domain layer** contains the **core business logic** of the application.  
It is written in **pure Dart**, without any dependency on Flutter, GetX, or Dio.

This ensures:
- High testability
- Framework independence
- Clean separation of concerns

### a. Repository Interfaces

- Define contracts for data operations
- Implemented by the Data layer
- Used directly by controllers in the Presentation layer

Examples:
- `LoginRepository`
- `CourseRepository`

---

## 🎨 Presentation Layer

The **Presentation layer** is the most framework-dependent layer.  
It is responsible for UI rendering, handling user interactions, and reacting to state changes.

This layer **does not contain any business logic**.

---

### a. Controllers

- Implemented using **GetX Controllers**
- Handle UI state such as loading, success, and error
- Communicate with Domain repositories
- Control navigation and user actions

Examples:
- `LoginController`
- `CourseListController`

---

### b. Widgets

- Reusable UI components
- Stateless or reactive using `Obx`
- Listen to controller state changes

Examples:
- `CourseCard`
- `SessionCard`

---

### c. Screens / Views

- Combine widgets and controllers
- Represent complete UI screens
- Handle navigation and screen-level interactions

Examples:
- `LoginScreen`
- `CourseScreen`

---

## 🔁 Data Flow Overview

```text
UI (Screen / Widget)
        ↓
Controller (GetX)
        ↓
Domain Repository (Interface)
        ↓
Repository Implementation
        ↓
Remote / Local Data Source
        ↓
API / Cache
````
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
