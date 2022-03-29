import 'package:dio/dio.dart';
import 'package:onoq/data/service/network/urls.dart';

class NetworkHelper {
  /// Amount of time in Milliseconds for connection Timeout
  final int? connectTimeout;
  NetworkHelper({this.connectTimeout});

  /// Performs a GET request with [queryParameters]
  Future<T> get<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isRawResult = false,
    String? customBaseUrl,
    bool isCustomUrl = true,
  }) async {
    final Dio _client = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: connectTimeout,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    try {
      final response = await _client.get(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e);
    }
  }

  /// Performs a POST request with [body], then executes the functions
  /// with generic return value
  Future<T> post<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
    bool cmc = false,
    String? customBaseUrl,
    bool isCustomUrl = true,
  }) async {
    final Dio _client = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: connectTimeout,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    try {
      _client.interceptors.add(LogInterceptor(requestBody: true));
      final response = await _client.post(
        path,
        data: containsFile ? FormData.fromMap(body) : body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e);
    }
  }

  /// Performs a PUT request with [body], then executes the functions
  /// with generic return value
  ///
  /// if the request contains a file, set [containsFile] to true
  /// user [queryParameters] if necessary
  Future<T> put<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    required Map<String, dynamic> body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool containsFile = false,
    bool isRawResult = false,
    String? customBaseUrl,
    bool isCustomUrl = true,
    bool cmc = false,
  }) async {
    final Dio _client = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: connectTimeout,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    try {
      final response = await _client.put(
        path,
        data: containsFile ? FormData.fromMap(body) : body,
        queryParameters: queryParameters,
        // Comment out to check progress on data sending
        // onSendProgress: (int sent, int total) {
        //   print('$sent $total');
        // },
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e);
    }
  }

  Future<T> delete<T>({
    required String path,
    required T Function(dynamic content) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    bool isRawResult = false,
    String? customBaseUrl,
    bool isCustomUrl = true,
    bool cmc = false,
  }) async {
    final Dio _client = Dio(
      BaseOptions(
        baseUrl: Urls.baseUrl,
        connectTimeout: connectTimeout,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    try {
      final response = await _client.delete(
        path,
        options: Options(headers: headers),
      );

      return onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e);
    }
  }
}
