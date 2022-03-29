import 'package:intl/intl.dart';

class Helper {
  // parse integer to currency
  String formatRupiah(int value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    String result = formatter.format(value);
    return result;
  }

  static String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }
}
