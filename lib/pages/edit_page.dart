import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:single_patient_profile/model/riverpod/state_notifier_provider.dart';
import 'package:single_patient_profile/themes/button.dart';
import 'package:single_patient_profile/themes/calendar_theme.dart';
import 'package:single_patient_profile/themes/colors.dart';
import 'package:single_patient_profile/themes/text.dart';

class EditPage extends ConsumerStatefulWidget {
  const EditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends ConsumerState<EditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String patientName = ref.watch(userProvider).name;
    String dateOfBirth = ref.watch(userProvider).dateOfBirth;

    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime birthday = DateTime.parse(dateOfBirth);

    nameController.text = patientName;
    dobController.text = dateFormat.format(birthday);

    Future<void> saveUserData() async {
      ref.read(userProvider.notifier).updateUserData(patientName, dateOfBirth);
      ref.read(userProvider.notifier).saveUser();
    }

    Future<void> selectDate() async {
      DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ProfileCalendar.calendarColorScheme,
                textButtonTheme: ProfileCalendar.calendarTextButtonTheme,
              ),
              child: child!);
        },
        context: context,
        initialDate: birthday,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        birthday = picked;
        dateOfBirth = birthday.toIso8601String();
        dobController.text = dateFormat.format(birthday);
      }
    }

    return Scaffold(
        backgroundColor: ProfileColors.background,
        appBar: AppBar(
          title: Text(
            "Edit Profile",
            style: ProfileText.titleScaffold,
          ),
          centerTitle: true,
          backgroundColor: ProfileColors.transparent,
          foregroundColor: ProfileColors.textSecondary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                color: ProfileColors.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: ProfileText.fieldTitle,
                        ),
                        controller: nameController,
                        onChanged: (value) => patientName = value,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          labelStyle: ProfileText.fieldTitle,
                        ),
                        controller: dobController,
                        readOnly: true,
                        onTap: () {
                          selectDate();
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            saveUserData();
                            Navigator.pop(context, true);
                          },
                          style: ProfileButton.optionButton,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.save,
                                size: 20.0,
                                color: ProfileColors.textSecondary,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Save",
                                style: ProfileText.buttonText,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
