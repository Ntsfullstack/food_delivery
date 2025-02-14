extension StringExtension on String {
  String capitalize() {
    if (this == null || this.isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
