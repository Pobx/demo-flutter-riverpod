import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_app_api2/core/types/failure.dart';
import 'package:riverpod_app_api2/models/activity_model.dart';

class ActivityRepository {
  final Dio _dio;

  ActivityRepository(this._dio);

  Future<Either<Failure, ActivityModel>> getActivity() async {
    try {
      const path = 'http://www.boredapi.com/api/activity';
      final response = await _dio.get(path);
      final activity = ActivityModel.fromJson(response.data);

      return Right(activity);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
