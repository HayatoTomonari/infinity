import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si_proto/welcomePage/ConstantsColor.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _CustomTextField(
          labelText: 'メールアドレス',
          hintText: 'メールアドレスを入力してください。',
          obscureText: false,
        ),
        const SizedBox(height: 48),
        const _CustomTextField(
          labelText: 'パスワード',
          hintText: 'パスワードを入力してください。',
          obscureText: true,
        ),
        const SizedBox(height: 4),
        Text(
          'パスワードを忘れた場合はコチラ',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: ConstantsColor.kTextColorSecondary),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: ConstantsColor.kButtonTextColorPrimary, backgroundColor: ConstantsColor.kButtonColorPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: Text(
              'ログイン',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: ConstantsColor.kButtonTextColorPrimary, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
            Container(
              color: ConstantsColor.kTextColorSecondary,
              width: 1,
              height: 16,
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;

  const _CustomTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(color: ConstantsColor.kTextColorSecondary),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kAccentColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: ConstantsColor.kTextColorSecondary,
          ),
        ),
      ),
      obscureText: obscureText,
      onTap: () {},
    );
  }
}