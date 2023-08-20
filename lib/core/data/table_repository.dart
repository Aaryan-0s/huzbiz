import 'package:huzbiz_app/core/data/failure.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:dartz/dartz.dart';

abstract class TableRepository {
  Future<Either<Failure, List<TableDetails>>> getTableDetails();
}
