class DrumSound {
  final String type;
  final String fileName;

  const DrumSound({
    required this.type,
    required this.fileName,
  });

  String get path => 'assets/audio/$fileName';
}