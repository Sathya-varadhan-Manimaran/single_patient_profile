import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:single_patient_profile/data_sources/data_source.dart';
import 'package:single_patient_profile/model/data_types/user.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(" ", DateTime.now().toIso8601String()));

  void updateUserData(String newName, String newDateOfBirth) {
    state = User(newName, newDateOfBirth);
  }

  void saveUser() {
    saveUserDataToMemory(state);
  }

  bool birthdayChecker() {
    final dateOfBirthString = state.dateOfBirth;
    final dateOfBirth = DateTime.parse(dateOfBirthString);
    final today = DateTime.now();

    bool isMonthSame = (dateOfBirth.month == today.month);
    bool isDaySame = (dateOfBirth.day == today.day);

    if (isMonthSame && isDaySame) {
      return true;
    } else {
      return false;
    }
  }
}
