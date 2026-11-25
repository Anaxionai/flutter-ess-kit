// Saving habits and check-ins on the phone with SQLite (sqflite).
//
// TODO(task 20): run `flutter pub add sqflite path` and
// `flutter pub add dev:sqflite_common_ffi`, then write the HabitStore:
// - static Future<HabitStore> open(DatabaseFactory factory, String path)
// - onCreate: table `habits` (id TEXT PRIMARY KEY, name, created_on) and
//   table `check_ins` (habit_id, day, PRIMARY KEY (habit_id, day))
// - loadHabits, loadCheckIns, saveHabit (replace on conflict),
//   deleteHabit (its check-ins too, in one transaction), addCheckIn, removeCheckIn
class HabitStore {
  // TODO(task 20): the database and the methods above.
}
