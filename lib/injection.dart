import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/dio_client.dart';
import 'core/services/storage_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<StorageService>(
      () => StorageService(sharedPreferences));

  sl.registerLazySingleton<DioClient>(
    () => DioClient(baseUrl: 'https://api.tourtrack.com/v1'),
  );
}
