import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:single_patient_profile/data_sources/data_source.dart';
import 'package:single_patient_profile/model/riverpod/state_notifier_provider.dart';
import 'package:single_patient_profile/pages/edit_page.dart';
import 'package:single_patient_profile/themes/button.dart';
import 'package:single_patient_profile/themes/colors.dart';
import 'package:single_patient_profile/themes/text.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends ConsumerState<Profile> {
  bool isLoading = true;
  bool isTodayBithday = false;

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  Future<void> loadUserData() async {
    final user = await loadUser();
    ref.read(userProvider.notifier).updateUserData(user.name, user.dateOfBirth);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    String patientName = ref.watch(userProvider).name;
    String dateOfBirth = ref.watch(userProvider).dateOfBirth;

    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    isTodayBithday = ref.read(userProvider.notifier).birthdayChecker();

    Future<void> navigateToEditScreen(BuildContext context) async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditPage()),
      );
      if (!context.mounted) return;
      if (result ?? false) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(
              const SnackBar(content: Text('User Profile updated !')));
      }
    }

    return Scaffold(
        backgroundColor: ProfileColors.background,
        appBar: AppBar(
          title: Text(
            "Patient Profile",
            style: ProfileText.titleAppName,
          ),
          centerTitle: true,
          backgroundColor: ProfileColors.transparent,
          foregroundColor: ProfileColors.text,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                isTodayBithday
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.celebration,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Happy Birthday !",
                            style: ProfileText.greetingText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.celebration,
                            color: Colors.orange,
                          )
                        ],
                      )
                    : const SizedBox(
                        width: 0,
                      ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: media.size.width * 0.9,
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    color: ProfileColors.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: ProfileColors.text,
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                    "Profile",
                                    style: ProfileText.titleCard,
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/user.png")),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            text: "Name : ",
                                            style: ProfileText.fieldTitle,
                                            children: <TextSpan>[
                                          TextSpan(
                                              text: patientName,
                                              style: ProfileText.bodyText),
                                        ])),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: "Date of Birth : ",
                                            style: ProfileText.fieldTitle,
                                            children: <TextSpan>[
                                          TextSpan(
                                            text: dateFormat.format(
                                                DateTime.parse(dateOfBirth)),
                                            style: ProfileText.bodyText,
                                          )
                                        ])),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      navigateToEditScreen(context);
                                    },
                                    style: ProfileButton.optionButton,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.edit,
                                          size: 20.0,
                                          color: ProfileColors.textSecondary,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Edit",
                                          style: ProfileText.buttonText,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
