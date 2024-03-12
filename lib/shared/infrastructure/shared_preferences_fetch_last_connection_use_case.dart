import 'package:astro_app/shared/domain/fetch_last_connection_use_case.dart';
import 'package:astro_app/shared/domain/save_last_connection_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFetchLastConnectionUseCase implements FetchLastConnectionUseCase {
  final SharedPreferences sharedPreferences;
  final SaveLastConnectionUseCase saveLastConnectionUseCase;
  SharedPreferencesFetchLastConnectionUseCase(
    this.sharedPreferences,
    this.saveLastConnectionUseCase,
  );
  @override
  Future<DateTime?> call() async {
    final lastConnection = sharedPreferences.getInt('last_connection');
    saveLastConnectionUseCase.call();
    if (lastConnection == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(lastConnection);
  }
}
