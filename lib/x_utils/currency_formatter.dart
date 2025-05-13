import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final _formatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  /// Format a number to Vietnamese currency format
  /// Example: 1000000 -> 1.000.000 ₫
  static String format(double amount) {
    return _formatter.format(amount);
  }

  /// Format a number to Vietnamese currency format without the currency symbol
  /// Example: 1000000 -> 1.000.000
  static String formatWithoutSymbol(double amount) {
    return _formatter.format(amount).replaceAll(' ₫', '');
  }

  /// Parse a string to a double value
  /// Example: "1.000.000 ₫" -> 1000000.0
  static double parse(String value) {
    try {
      // Remove currency symbol and dots
      String cleanValue = value.replaceAll(' ₫', '').replaceAll('.', '');
      return double.parse(cleanValue);
    } catch (e) {
      return 0.0;
    }
  }

  /// Format a number to Vietnamese currency format with compact notation
  /// Example: 1000000 -> 1M ₫
  static String formatCompact(double amount) {
    if (amount >= 1000000000) {
      return '${(amount / 1000000000).toStringAsFixed(1)}B ₫';
    } else if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M ₫';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K ₫';
    }
    return format(amount);
  }
} 