import 'package:intl/intl.dart';

String brasilCurrencyFormat(double value) {
  return NumberFormat.currency(locale: 'pt', symbol: 'R\$').format(value).toString();
} 