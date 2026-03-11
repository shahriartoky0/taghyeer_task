class AppUrl {
  AppUrl._();

  static const String baseUrl = 'https://dummyjson.com';

  // Auth
  static const String login = '$baseUrl/auth/login';

  // Products
  static String products({int limit = 10, int skip = 0}) =>
      '$baseUrl/products?limit=$limit&skip=$skip';

  // Posts
  static String posts({int limit = 10, int skip = 0}) =>
      '$baseUrl/posts?limit=$limit&skip=$skip';
}
