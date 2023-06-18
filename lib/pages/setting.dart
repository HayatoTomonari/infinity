import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:si_proto/components/info_dialog.dart';
import 'package:si_proto/pages/update_email.dart';
import 'package:si_proto/pages/update_password.dart';
import 'package:si_proto/pages/welcome_page.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String version = '';

  Future getVer() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  void initState() {
    super.initState();
    getVer();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      platform: DevicePlatform.iOS,
      sections: [
        SettingsSection(
          title: const Text('ユーザー設定'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.account_circle),
              title: const Text('プロフィール編集'),
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.mail),
              title: const Text('メールアドレスの変更'),
              onPressed: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateEmail()),
                );
              },
            ),
            SettingsTile.navigation(
              leading: const Icon(Icons.lock_open),
              title: const Text('パスワードの変更'),
              onPressed: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdatePassword()),
                );
              },
            ),
          ],
        ),
        SettingsSection(
          title: const Text('アプリ設定'),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              leading: const Icon(Icons.color_lens_outlined),
              title: const Text('ダークテーマを有効にする'),
              initialValue: false,
              onToggle: (value) {},
            ),
            SettingsTile.switchTile(
              leading: const Icon(Icons.notifications),
              title: const Text('通知設定を有効にする'),
              initialValue: false,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: const Text('infinityについて'),
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.not_started_outlined),
              title: const Text('infinityの始め方'),
            ),
            SettingsTile(
              leading: const Icon(Icons.question_mark_outlined),
              title: const Text('よくあるご質問'),
            ),
            SettingsTile(
              leading: const Icon(Icons.rule_folder_outlined),
              title: const Text('利用規約'),
            ),
            SettingsTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('プライバシーポリシー'),
            ),
            SettingsTile(
              leading: const Icon(Icons.label_important_outline),
              title: const Text('オープンソースライセンス'),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('アプリ情報'),
          tiles: <SettingsTile>[
            SettingsTile(
                leading: const Icon(Icons.info),
                title: const Text('アプリバージョン'),
                value: Text(version))
          ],
        ),
        SettingsSection(
          tiles: <SettingsTile>[
            SettingsTile(
              leading: const Icon(Icons.login_outlined),
              title: const Text('ログアウト'),
              onPressed: (value) async => {
                await FirebaseAuth.instance.signOut(),
                InfoDialog.snackBarSuccess(context, "ログアウトしました。"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()),
                )
              },
            ),
          ],
        ),
      ],
    );
  }
}
