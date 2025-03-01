extension VietnameseMoney on num {
  String toVietnameseMoney() {
    if (this < 1000) {
      return toString();
    } else if (this < 1000000) {
      return "${(this / 1000).toStringAsFixed(0)}k";
    } else if (this < 1000000000) {
      return "${(this / 1000000).toStringAsFixed(1)}tr";
    } else if (this < 1000000000000) {
      return "${(this / 1000000000).toStringAsFixed(1)} tỷ";
    } else {
      return "${(this / 1000000000000).toStringAsFixed(1)} nghìn tỷ";
    }
  }
}
