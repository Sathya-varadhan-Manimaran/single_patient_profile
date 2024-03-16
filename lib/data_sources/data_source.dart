import 'package:single_patient_profile/model/data_types/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> loadUser() async {
  final userData = await SharedPreferences.getInstance();
  final userJson = userData.getString('user');

  if (userJson == null) {
    return User('Patient_xyz', DateTime.now().toIso8601String());
  }
  return User.fromJson(userJson);
}

Future<void> saveUserDataToMemory(User user) async {
  final userData = await SharedPreferences.getInstance();
  final userJson = user.toJson();
  await userData.setString('user', userJson);
}
