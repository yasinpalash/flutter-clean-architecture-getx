# Flutter Clean Architecture with GetX

A **scalable, production-ready Flutter application** built using **Clean Architecture principles**, **GetX** for state management & dependency injection, and **Dio** for networking.

This project demonstrates **real-world architecture**, **proper error handling**, **API abstraction**, and **feature-based modular design**.

---
### Features

- Login
- Fetch Course
  
### What is used in this project?
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

##  Data Layer

The **Data layer** is the outermost layer of the application.  
It is responsible for fetching data from remote APIs, handling network communication, mapping responses to models, and implementing repository contracts defined in the Domain layer.

### a. Data Sources

Data Sources define how data is retrieved and stored.

####  Remote Data Source
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

##  Domain Layer

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

##  Presentation Layer

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

## Project Structure Overview

- `main.dart`  
  Initializes all app-level dependencies and services before running the application.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}
````

* `app.dart`
  Contains the root `GetMaterialApp`, initializes routes, bindings, themes, localization, and platform-specific behavior.

```dart
return GetMaterialApp(
  initialRoute: AppRoute.loginScreen,
  getPages: AppRoute.routes,
  initialBinding: ControllerBinder(),
);
```

---

##  Core Layer

The `core` folder contains **shared and app-wide utilities** used across all features.

###  Dependency Injection (`core/di`)

All repositories and services are registered using **GetX dependency injection**.

```dart
Get.lazyPut<LoginRepository>(
  () => LoginRepositoryImpl(LoginRemoteDataSource()),
  fenix: true,
);
```

---

###  Network (`core/network`)

Networking is implemented using **Dio**, wrapped with custom abstractions.

#### API Client

```dart
class ApiClient {
  static Dio createDio() {
    final dio = Dio(BaseOptions(baseUrl: AppUrls.baseUrl));
    dio.interceptors.addAll([
      InternetCheckInterceptor(),
      GlobalErrorInterceptor(),
      HttpErrorInterceptor(),
    ]);
    return dio;
  }
}
```

#### Network Caller Extension

All HTTP methods return a **safe `Result<T>`** instead of throwing exceptions.

```dart
Future<Result<T>> getRequest<T>(
  String path, {
  required T Function(dynamic json) fromJson,
});
```

---

###  Error Handling (`core/errors`)

Centralized error handling using:

* Custom Exceptions (`NetworkException`, `ServerException`)
* Dio Interceptors
* Unified error mapping

This ensures **consistent error behavior across the app**.

---

##  Features Layer

Each feature follows the same internal structure:

```
Feature
 ├── controllers
 ├── data
 │   ├── data_sources
 │   ├── models
 │   └── repositories
 ├── domain
 │   └── repositories
 └── presentation
     ├── screens
     └── widgets
```

---
##  Authentication Feature Example

### Repository Contract (Domain Layer)

```dart
abstract class LoginRepository {
  Future<Result<ResponseData>> login(SignInRequest request);
}
```

---

### Repository Implementation (Data Layer)

```dart
class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<ResponseData>> login(SignInRequest request) {
    return remoteDataSource.signIn(request);
  }
}
```

---

### Remote Data Source

```dart
class LoginRemoteDataSource {
  final Dio dio = ApiClient.createDio();

  Future<Result<ResponseData>> signIn(SignInRequest request) {
    return dio.postRequest<ResponseData>(
      AppUrls.login,
      fromJson: (json) => ResponseData.fromJson(json),
      data: request.toJson(),
    );
  }
}
```

---

### Controller (Presentation Layer)

```dart
class LoginController extends GetxController {
  final LoginRepository repository;

  LoginController(this.repository);

  final isLoading = false.obs;

  Future<void> login() async {
    final result = await repository.login(request);

    switch (result) {
      case Ok<ResponseData>():
        Get.to(() => CourseScreen());
        break;
      case Error<ResponseData>():
        // handle error
        break;
    }
  }
}
```

---

##  Courses Feature Example

### Repository Contract

```dart
abstract class CourseRepository {
  Future<Result<CoursesSessionModel>> getCourses();
}
```

---

### Repository Implementation

```dart
class CourseRepositoryImpl extends CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<CoursesSessionModel>> getCourses() {
    return remoteDataSource.getCourseSessions();
  }
}
```

---

### Controller Usage

```dart
final courseController = Get.find<CourseListController>();

Obx(() {
  if (courseController.inProgress.value) {
    return CircularProgressIndicator();
  }
});
```

---

##  Data Flow

```text
UI (Screen / Widget)
        ↓
GetX Controller
        ↓
Domain Repository (Abstract)
        ↓
Repository Implementation
        ↓
Remote Data Source
        ↓
Dio API Client
```
##  Folder Structure
```txt
lib/
├── Features/
│   ├── Authentication/
│   │   ├── controllers/
│   │   │   └── login_controller.dart
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   └── login_remote_data_sources.dart
│   │   │   ├── models/
│   │   │   │   └── login_request_body.dart
│   │   │   └── repositories/
│   │   │       └── login_repository_impl.dart
│   │   ├── domain/
│   │   │   └── repositories/
│   │   │       └── login_repository.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── login_screen.dart
│   │       └── widgets/
│   │           └── dummy.dart
│   └── Courses/
│       ├── controllers/
│       │   └── course_list_controller.dart
│       ├── data/
│       │   ├── data_sources/
│       │   │   └── course_remote_data_source.dart
│       │   ├── models/
│       │   │   ├── course_sessions_model.dart
│       │   │   └── sessions_model.dart
│       │   └── repositories/
│       │       └── course_repository_impl.dart
│       ├── domain/
│       │   └── repositories/
│       │       └── course_repository.dart
│       └── presentation/
│           ├── screens/
│           │   └── course_screen.dart
│           └── widgets/
│               ├── course_card.dart
│               └── session_card.dart
├── core/
│   ├── bindings/
│   │   └── controller_binder.dart
│   ├── common/
│   │   ├── styles/
│   │   │   └── get_text_style.dart
│   │   └── widgets/
│   │       ├── custom_card.dart
│   │       └── internet_banner_manager.dart
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_sizer.dart
│   │   ├── app_texts.dart
│   │   ├── app_urls.dart
│   │   ├── enums.dart
│   │   ├── icon_path.dart
│   │   ├── image_path.dart
│   │   └── logo_path.dart
│   ├── di/
│   │   └── dependency_injection.dart
│   ├── errors/
│   │   └── exceptions.dart
│   ├── localization/
│   │   └── app_localizations.dart
│   ├── network/
│   │   ├── interceptors/
│   │   │   ├── global_error_interceptor.dart
│   │   │   ├── http_error_interceptor.dart
│   │   │   ├── internet_check_interceptor.dart
│   │   │   └── token_refresh_interceptor.dart
│   │   ├── api_client.dart
│   │   ├── network_caller.dart
│   │   ├── response_data.dart
│   │   ├── result.dart
│   │   └── server_exception.dart
│   ├── services/
│   │   ├── Auth_service.dart
│   │   └── network_checker.dart
│   └── utils/
│       ├── device/
│       │   └── device_utility.dart
│       ├── formatters/
│       │   └── app_formatters.dart
│       ├── helpers/
│       │   └── app_helper.dart
│       ├── listener/
│       │   └── connection_listener.dart
│       ├── logging/
│       │   ├── logger.dart
│       │   └── loggerformain.dart
│       ├── theme/
│       │   ├── custom_themes/
│       │   │   ├── app_bar_theme.dart
│       │   │   ├── app_text_theme.dart
│       │   │   ├── elevated_button_theme.dart
│       │   │   └── text_field_theme.dart
│       │   └── theme.dart
│       └── validators/
│           └── app_validator.dart
├── routes/
│   └── app_routes.dart
├── app.dart
└── main.dart
```
