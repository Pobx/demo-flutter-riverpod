import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app_api2/features/activity/repository/activity_repository.dart';

final activityRepositoryProvider = Provider<ActivityRepository>((ref) => ActivityRepository(Dio()));

