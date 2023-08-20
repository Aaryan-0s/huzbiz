import 'package:huzbiz_app/core/data/failure.dart';
import 'package:huzbiz_app/core/data/table_repository.dart';
import 'package:huzbiz_app/core/data/tables_data_source.dart';
import 'package:huzbiz_app/model/table_details.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TableRepoImpl extends TableRepository {
  @override
  Future<Either<Failure, List<TableDetails>>> getTableDetails() async {
    try {
      final response = await getTableDetailsLocal();
      print(response);
      return Right(response);
    } on DioException catch (e) {
      print('ssssssssssss');
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
