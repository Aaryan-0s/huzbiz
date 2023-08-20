import 'package:huzbiz_app/core/data/failure.dart';
import 'package:huzbiz_app/core/data/table_repository.dart';
import 'package:huzbiz_app/core/use_case.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:dartz/dartz.dart';

class GetTableDetailsUseCase extends UseCase<List<TableDetails>, NoParams> {
  final TableRepository repository;

  GetTableDetailsUseCase({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<TableDetails>>> call(NoParams params) {
    return repository.getTableDetails();
  }
}
