import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app_api2/core/enum/loading_state.dart';
import 'package:riverpod_app_api2/features/activity/controller/activity_controller.dart';
import 'package:riverpod_app_api2/models/activity_model.dart';

class ActivityView extends ConsumerStatefulWidget {
  const ActivityView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ActivityView();
}

class _ActivityView extends ConsumerState<ActivityView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(activityControllerSNProvider.notifier).getActivity();
    });
  }

  void _goToHome() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(activityControllerSNProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: _handler(response),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: response.loadingState == LoadingState.progress
                    ? null
                    : _goToHome,
                child: const Text('Go to Home'))
          ],
        ),
      ),
    );
  }

  Widget _handler(ActivityModel response) {
    final loadingState = response.loadingState;

    Widget result = switch (loadingState) {
      LoadingState.progress => const CircularProgressIndicator(),
      LoadingState.success => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Activity: ${response.activity}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Type: ${response.type}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Participants: ${response.participants.toString()}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      LoadingState.error => Text(response.activity),
      // _ => const Text('Not Working...')
    };

    return result;
  }
}
