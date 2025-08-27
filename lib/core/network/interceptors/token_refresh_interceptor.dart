// import 'dart:developer';
// import 'package:dio/dio.dart';
//
// import '../../constants/app_urls.dart';
// import '../../services/Auth_service.dart';
// import '../response_data.dart';
//
//
// class TokenInterceptor extends Interceptor {
//   static bool _isRefreshing = false;
//   static final List<RequestOptions> _pendingRequests = [];
//
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//
//     if (_isAuthEndpoint(options.path)) {
//       return handler.next(options);
//     }
//
//     if (AuthService.isAccessTokenExpired()) {
//       log('Access token expired, attempting refresh...');
//
//       if (_isRefreshing) {
//         _pendingRequests.add(options);
//         return;
//       }
//
//       final refreshResult = await _refreshToken();
//
//       if (refreshResult.isSuccess) {
//         options.headers['Authorization'] = 'Bearer ${AuthService.accessToken}';
//         _processPendingRequests();
//
//         return handler.next(options);
//       } else {
//         await AuthService.logoutUser();
//         return handler.reject(
//           DioException(
//             requestOptions: options,
//             type: DioExceptionType.cancel,
//             message: 'Token refresh failed, please login again',
//           ),
//         );
//       }
//     }
//
//     if (AuthService.hasAccessToken()) {
//       options.headers['Authorization'] = 'Bearer ${AuthService.accessToken}';
//     }
//
//     handler.next(options);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (err.response?.statusCode == 401 && !_isAuthEndpoint(err.requestOptions.path)) {
//       log('Received 401 error, attempting token refresh...');
//
//       if (_isRefreshing) {
//         _pendingRequests.add(err.requestOptions);
//         return;
//       }
//
//       final refreshResult = await _refreshToken();
//
//       if (refreshResult.isSuccess) {
//         final retryOptions = err.requestOptions;
//         retryOptions.headers['Authorization'] = 'Bearer ${AuthService.accessToken}';
//
//         try {
//           final dio = Dio();
//           final response = await dio.fetch(retryOptions);
//           return handler.resolve(response);
//         } catch (e) {
//           return handler.next(err);
//         }
//       } else {
//         await AuthService.logoutUser();
//         return handler.next(err);
//       }
//     }
//
//     handler.next(err);
//   }
//
//   static Future<({bool isSuccess, String? error})> _refreshToken() async {
//     if (_isRefreshing) {
//       return (isSuccess: false, error: 'Already refreshing');
//     }
//
//     _isRefreshing = true;
//
//     try {
//       final refreshToken = AuthService.refreshToken;
//
//       if (refreshToken == null) {
//         log('No refresh token available');
//         return (isSuccess: false, error: 'No refresh token');
//       }
//
//       if (AuthService.refreshTokenExpiry != null &&
//           DateTime.now().isAfter(AuthService.refreshTokenExpiry!)) {
//         log('Refresh token expired');
//         return (isSuccess: false, error: 'Refresh token expired');
//       }
//
//       final dio = Dio(BaseOptions(baseUrl: AppUrls.baseUrl));
//
//       final response = await dio.post(
//         AppUrls.refreshToken,
//         data: {'refresh-token': refreshToken},
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = ResponseData.fromJson(response.data);
//         if (responseData.isSuccess && responseData.data != null) {
//           final tokenData = responseData.data;
//
//           await AuthService.saveTokens(
//             accessToken: tokenData['strAccessToken'],
//             accessTokenExpiry: DateTime.parse(tokenData['strAccessTokenExpiresIn']),
//             refreshToken: tokenData['strRefreshToken'] ?? refreshToken,
//             refreshTokenExpiry: tokenData['strRefreshTokenExpiresIn'] != null
//                 ? DateTime.parse(tokenData['strRefreshTokenExpiresIn'])
//                 : AuthService.refreshTokenExpiry!,
//           );
//
//           log('Token refreshed successfully');
//           return (isSuccess: true, error: null);
//         }
//       }
//
//       log('Token refresh failed: ${response.statusCode}');
//       return (isSuccess: false, error: 'Refresh failed');
//
//     } catch (e) {
//       log('Token refresh error: $e');
//       return (isSuccess: false, error: e.toString());
//     } finally {
//       _isRefreshing = false;
//     }
//   }
//
//   static void _processPendingRequests() {
//     for (final request in _pendingRequests) {
//       request.headers['Authorization'] = 'Bearer ${AuthService.accessToken}';
//     }
//     _pendingRequests.clear();
//   }
//
//   static bool _isAuthEndpoint(String path) {
//     return path.contains('auth/login') ||
//         path.contains('auth/register') ||
//         path.contains('auth/refresh-token');
//   }
// }
