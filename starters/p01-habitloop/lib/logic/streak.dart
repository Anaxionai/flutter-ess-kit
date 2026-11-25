// Streaks on calendar days. Read the kit's data/habits/README.md first:
// it has the rule and the six cases your tests must pass.

/// The calendar day of [moment] on the phone's clock, as a date-only value.
///
/// TODO(task 21): DateTime.utc of the moment's LOCAL year, month and day.
/// Never use moment.toUtc() here: that is the midnight bug.
DateTime dayOf(DateTime moment) {
  throw UnimplementedError('TODO(task 21): dayOf');
}

/// Days in a row back from [today] if today is ticked, else from yesterday;
/// otherwise 0. Two check-ins on one day count once.
///
/// TODO(task 21): write it. Step back one calendar day at a time
/// (watch the month end), never by subtracting 24 hours.
int currentStreak(Iterable<DateTime> days, DateTime today) {
  throw UnimplementedError('TODO(task 21): currentStreak');
}

/// The longest run of days in a row anywhere in [days].
///
/// TODO(task 21): write it.
int longestStreak(Iterable<DateTime> days) {
  throw UnimplementedError('TODO(task 21): longestStreak');
}
