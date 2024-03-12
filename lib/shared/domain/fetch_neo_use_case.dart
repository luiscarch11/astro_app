import 'package:astro_app/shared/domain/neo.dart';

abstract interface class FetchNeoUseCase {
  Future<List<NEO>> execute(
    DateTime from,
    DateTime until,
  );
}
