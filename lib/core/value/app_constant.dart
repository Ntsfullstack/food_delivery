class AppConstants {
  static const double controlPanelWidth = 50.0;
  static const Duration animationDuration = Duration(milliseconds: 100);

  static const Map<String, DrumConfig> drumConfigs = {
    'KICK': DrumConfig(size: 100, x: 150, y: 300),
    'SNARE': DrumConfig(size: 80, x: 50, y: 200),
    'TOM': DrumConfig(size: 80, x: 270, y: 200),
    'CRASH': DrumConfig(size: 60, x: 50, y: 100),
    'RIDE': DrumConfig(size: 60, x: 290, y: 100),
  };
}

class DrumConfig {
  final double size;
  final double x;
  final double y;

  const DrumConfig({
    required this.size,
    required this.x,
    required this.y,
  });
}