part of 'table_bloc.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableError extends TableState {
  final String message;

  const TableError({required this.message});
}

class TableLoaded extends TableState {
  final List<TableDetails> loadedTableModel;

  const TableLoaded({required this.loadedTableModel});

  @override
  List<Object> get props => [loadedTableModel];
}
