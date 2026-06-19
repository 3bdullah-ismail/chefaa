import 'package:intl/intl.dart';

class ScheduleDateHelper {
  // Backend week order starts on Saturday
  static const List<String> weekOrder = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  /// Converts Dart's built-in weekday (Mon=1...Sun=7)
  /// into our custom index (Saturday=0...Friday=6)
  static int _dartWeekdayToCustomIndex(int dartWeekday) {
    switch (dartWeekday) {
      case DateTime.saturday:
        return 0;
      case DateTime.sunday:
        return 1;
      case DateTime.monday:
        return 2;
      case DateTime.tuesday:
        return 3;
      case DateTime.wednesday:
        return 4;
      case DateTime.thursday:
        return 5;
      case DateTime.friday:
        return 6;
      default:
        throw Exception('Invalid weekday: $dartWeekday');
    }
  }

  /// Returns the next real-world date for a given day name
  /// (e.g. "Saturday" -> DateTime(2026, 6, 20))
  static DateTime getDateForDay(String dayName, {DateTime? referenceDate}) {
    final now = referenceDate ?? DateTime.now();

    final todayIndex = _dartWeekdayToCustomIndex(now.weekday);
    final targetIndex = weekOrder.indexOf(dayName);

    if (targetIndex == -1) {
      throw Exception('Invalid day name: $dayName');
    }

    final todayDateOnly = DateTime(now.year, now.month, now.day);
    final startOfWeek = todayDateOnly.subtract(Duration(days: todayIndex));

    var targetDate = startOfWeek.add(Duration(days: targetIndex));

    // If this day already passed this week, move to next week
    if (targetDate.isBefore(todayDateOnly)) {
      targetDate = targetDate.add(const Duration(days: 7));
    }

    return targetDate;
  }

  /// e.g. DateTime(2026,6,20) -> "20 Jun"
  static String formatScheduleDate(DateTime date) {
    return DateFormat('d MMM').format(date);
  }

  /// e.g. DateTime(2026,6,20) -> "Sat, 20 Jun"
  static String formatScheduleDateWithDay(DateTime date) {
    return DateFormat('EEE, d MMM').format(date);
  }

  /// e.g. 480 -> "8:00 AM"
  static String formatMinutesToTime(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h % 12 == 0 ? 12 : h % 12;
    return '$hour12:${m.toString().padLeft(2, '0')} $period';
  }

  /// Takes the raw `defaultSchedule.days` list from API
  /// and returns only active days, each enriched with
  /// a real date and formatted strings.
  static List<Map<String, dynamic>> buildActiveDaysWithDates(
      List<dynamic> days, {
        DateTime? referenceDate,
      }) {
    final activeDays = days
        .where((d) => d['isActive'] == true)
        .map<Map<String, dynamic>>((d) {
      final date = getDateForDay(d['day'], referenceDate: referenceDate);
      return {
        'day': d['day'],
        'open': d['open'],
        'close': d['close'],
        'breaks': d['breaks'],
        'slotDuration': d['slotDuration'],
        'dailyCapacity': d['dailyCapacity'],
        'patientsPerSlot': d['patientsPerSlot'],
        'isDayLocked': d['isDayLocked'],
        'isBookingLocked': d['isBookingLocked'],
        'date': date,
        'displayDate': formatScheduleDate(date),
        'displayDateWithDay': formatScheduleDateWithDay(date),
        'openTime': formatMinutesToTime(d['open']),
        'closeTime': formatMinutesToTime(d['close']),
      };
    }).toList();

    // Sort chronologically (soonest date first)
    activeDays.sort((a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime));

    return activeDays;
  }
}