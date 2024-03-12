import 'package:astro_app/shared/domain/fetch_last_connection_use_case.dart';
import 'package:astro_app/shared/domain/fetch_neo_use_case.dart';
import 'package:astro_app/shared/infrastructure/nasa_api_fetch_neo_use_case.dart';
import 'package:astro_app/shared/infrastructure/shared_preferences_fetch_last_connection_use_case.dart';
import 'package:astro_app/shared/infrastructure/shared_preferences_save_last_connection_use_case.dart';
import 'package:astro_app/shared/presentation/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  final fetchNEOUseCase = NasaAPIFetchNEOUseCase();
  final fetchLastConnectionUseCase = SharedPreferencesFetchLastConnectionUseCase(
    sharedPrefs,
    SharedPreferencesSaveLastConnecionUseCase(
      sharedPrefs,
    ),
  );
  runApp(
    MyApp(
      fetchLastConnectionUseCase: fetchLastConnectionUseCase,
      fetchNEOUseCase: fetchNEOUseCase,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.fetchNEOUseCase,
    required this.fetchLastConnectionUseCase,
  });

  final FetchNeoUseCase fetchNEOUseCase;
  final FetchLastConnectionUseCase fetchLastConnectionUseCase;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          background: Colors.black,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.bold,
            fontSize: 50,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Product Sans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Product Sans',
            fontSize: 12,
          ),
        ),
      ),
      home: DashboardPage(
        fetchLastConnectionUseCase: fetchLastConnectionUseCase,
        fetchNEOUseCase: fetchNEOUseCase,
      ),
    );
  }
}
