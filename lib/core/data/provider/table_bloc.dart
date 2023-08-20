import 'package:huzbiz_app/core/data/table_use_case.dart';
import 'package:huzbiz_app/core/use_case.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  final GetTableDetailsUseCase tableDetailsUseCase;

  TableBloc({required this.tableDetailsUseCase}) : super(TableInitial()) {
    on<TableInit>(
      (event, emit) async {
        final result = await tableDetailsUseCase(NoParams());

        result.fold((failure) {
          emit(
            TableError(
              message: failure.error,
            ),
          );
        }, (tableModel) {
          emit(
            TableLoaded(loadedTableModel: tableModel),
          );
        });
      },
    );
  }
}
