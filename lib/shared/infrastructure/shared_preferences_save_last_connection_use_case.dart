import 'package:astro_app/shared/domain/save_last_connection_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSaveLastConnecionUseCase implements SaveLastConnectionUseCase {
  final SharedPreferences sharedPreferences;

  SharedPreferencesSaveLastConnecionUseCase(this.sharedPreferences);
  @override
  Future<void> call() async {
    sharedPreferences.setInt(
      'last_connection',
      DateTime.now().millisecondsSinceEpoch,
    );
  }
}
