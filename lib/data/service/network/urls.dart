class Urls {
  /// Base URL

  static const String baseUrl = "http://api.elevenia.co.id/rest/";

  // API Endpoint

  static const String urlCategory = "cateservice/category";
  static const String deliveryList = "delivery/template";
  static String urlSubCategory(String? dispCtrgNo) =>
      "cateservice/categoryAttributes/$dispCtrgNo";
  static String urlDetailProduct(String? prodNo) =>
      "prodservices/product/details/$prodNo";
  static String urlListProduct(int? pageNumber) =>
      "prodservices/product/listing?page=${pageNumber.toString()}";
}
