import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:si_proto/components/info_dialog.dart';
import 'package:si_proto/pages/setting/update_email_page.dart';
import 'package:si_proto/pages/setting/update_password_page.dart';
import 'package:si_proto/pages/setting/update_profile_page.dart';
import 'package:si_proto/pages/signin/signin_page.dart';
import 'package:si_proto/utils/constants_text.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String version = '';

  Future getApplicationVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    getApplicationVersion();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      platform: DevicePlatform.iOS,
      sections: [
        SettingsSection(
          title: const Text(ConstantsText.userSetting),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.account_circle),
              title: const Text(ConstantsText.profileEdit),
              onPressed: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfilePage()),
                );
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.mail),
              title: const Text(ConstantsText.changeEmail),
              onPressed: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateEmailPage()),
                );
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.lock_open),
              title: const Text(ConstantsText.changePassword),
              onPressed: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePasswordPage()),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text(ConstantsText.applicationSetting),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text(ConstantsText.enableDarkTheme),
              initialValue: false,
              onToggle: (value) {},
            ),
            SettingsTile.switchTile(
              leading: const Icon(Icons.notifications),
              title: const Text(ConstantsText.enableNoticeSetting),
              initialValue: false,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: const Text(ConstantsText.aboutApplication),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.not_started_outlined),
              title: const Text(ConstantsText.howToStartApplication),
            ),
            SettingsTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text(ConstantsText.faq),
            ),
            SettingsTile(
              leading: const Icon(Icons.rule_folder_outlined),
              title: const Text(ConstantsText.termsOfService),
            ),
            SettingsTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text(ConstantsText.privacyPolicy),
            ),
            SettingsTile(
              leading: const Icon(Icons.label_important_outline),
              title: const Text(ConstantsText.openSourceLicense),
            ),
          ],
        ),
        SettingsSection(
          title: const Text(ConstantsText.applicationInformation),
          tiles: <SettingsTile>[
            SettingsTile(
                leading: const Icon(Icons.info),
                title: const Text(ConstantsText.applicationVersion),
                value: Text(version))
          ],
        ),
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.login_outlined),
              title: const Text(ConstantsText.logout),
              onPressed: (value) async => {
                await FirebaseAuth.instance.signOut(),
                InfoDialog.snackBarSuccess(context, ConstantsText.loggedOut),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                )
              },
            ),
          ],
        ),
      ],
    );
  }
}
