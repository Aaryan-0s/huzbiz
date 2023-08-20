import 'package:huzbiz_app/core/data/provider/table_bloc.dart';
import 'package:huzbiz_app/core/data/table_repo_impl.dart';
import 'package:huzbiz_app/core/data/table_repository.dart';
import 'package:huzbiz_app/core/data/table_use_case.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  injectTable();
}

void injectTable() {
  sl.registerFactory<TableBloc>(
    () => TableBloc(
      tableDetailsUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => GetTableDetailsUseCase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<TableRepository>(
    () => TableRepoImpl(),
  );
}
