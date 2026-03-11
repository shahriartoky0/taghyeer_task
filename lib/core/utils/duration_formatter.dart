String formatDurationString(String durationStr) {
  // Handle empty or null input
  if (durationStr.isEmpty) {
    return "0S";
  }

  try {
    // Parse the duration string
    final List<String> parts = durationStr.split(':');

    if (parts.length != 3) {
      throw const FormatException('Invalid duration format');
    }

    final int hours = int.parse(parts[0]);
    final int minutes = int.parse(parts[1]);

    // Handle seconds and microseconds
    final List<String> secondsPart = parts[2].split('.');
    final int seconds = int.parse(secondsPart[0]);
    final int microseconds = secondsPart.length > 1
        ? int.parse(secondsPart[1].padRight(6, '0').substring(0, 6))
        : 0;

    // Create Duration object
    final Duration duration = Duration(
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      microseconds: microseconds,
    );

    return _formatDuration(duration);
  } catch (e) {
    // If parsing fails, return a default format
    return "0s";
  }
}

String _formatDuration(Duration duration) {
  final int totalSeconds = duration.inSeconds;

  // Handle zero duration
  if (totalSeconds == 0) {
    return "0s";
  }

  final int hours = duration.inHours;
  final int minutes = duration.inMinutes % 60;
  final int seconds = duration.inSeconds % 60;

  final List<String> parts = <String>[];

  if (hours > 0) {
    parts.add('${hours}h');
  }

  if (minutes > 0) {
    parts.add('${minutes}m');
  }

  if (seconds > 0 || parts.isEmpty) {
    parts.add('${seconds}s');
  }

  return parts.join(' ');
}

/// ================> String to Duration Method =================>
Duration parseDurationString(String durationStr) {
  if (durationStr.isEmpty) {
    return Duration.zero;
  }

  try {
    final List<String> parts = durationStr.split(':');
    if (parts.length != 3) {
      return Duration.zero;
    }

    final int hours = int.parse(parts[0]);
    final int minutes = int.parse(parts[1]);

    final List<String> secondsPart = parts[2].split('.');
    final int seconds = int.parse(secondsPart[0]);
    final int microseconds = secondsPart.length > 1
        ? int.parse(secondsPart[1].padRight(6, '0').substring(0, 6))
        : 0;

    return Duration(hours: hours, minutes: minutes, seconds: seconds, microseconds: microseconds);
  } catch (e) {
    return Duration.zero;
  }
}
