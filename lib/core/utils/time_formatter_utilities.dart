// Utils
class TimeFormatter {
  static String formatDuration(Duration duration, {bool showHours = true}) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (showHours) {
      final String hours = twoDigits(duration.inHours);
      final String minutes = twoDigits(duration.inMinutes.remainder(60));
      final String seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$hours:$minutes:$seconds';
    } else {
      final String minutes = twoDigits(duration.inMinutes);
      final String seconds = twoDigits(duration.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }
  }
}