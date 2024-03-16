import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:single_patient_profile/model/data_types/user.dart';
import 'package:single_patient_profile/model/riverpod/state_notifier.dart';

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
