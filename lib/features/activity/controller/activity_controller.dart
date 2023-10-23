import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app_api2/core/enum/loading_state.dart';
import 'package:riverpod_app_api2/features/activity/provider/activity_provider.dart';
import 'package:riverpod_app_api2/features/activity/repository/activity_repository.dart';
import 'package:riverpod_app_api2/models/activity_model.dart';

final activityControllerSNProvider =
    StateNotifierProvider.autoDispose<ActivityController, ActivityModel>(
        (ref) => ActivityController(ref));

class ActivityController extends StateNotifier<ActivityModel> {
  final ActivityRepository _repository;
  ActivityController(Ref ref)
      : _repository = ref.read(activityRepositoryProvider),
        super(const ActivityModel());

  Future<void> getActivity() async {
    state = state.copyWith(loadingState: LoadingState.progress);

    final result = await _repository.getActivity();

    result.fold(
        (failure) => state = state.copyWith(
            loadingState: LoadingState.error, activity: failure.message),
        (response) => state = state.copyWith(
            loadingState: LoadingState.success,
            activity: response.activity,
            type: response.type,
            participants: response.participants));
  }

  Future<void> reloadActivity() async {
    await getActivity();
  }
}
