import 'package:evently_c20_online/core/toast_service/toast.dart';
import 'package:evently_c20_online/l10n/app_localizations.dart';
import 'package:evently_c20_online/modules/auth/manager/auth_provider.dart';
import 'package:evently_c20_online/modules/auth/screens/forget_password_screen.dart';
import 'package:evently_c20_online/modules/auth/screens/resgister_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";
   LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;

    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/logo/app_logo.png",
                        width: 140,
                        color: theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 48),
                    Text(
                      local.loginTitle,
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset("assets/icons/sms.png"),
                        hintText: local.emailHint,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset("assets/icons/lock.png"),
                        hintText: local.passwordHint,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {

                          Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                        },
                        child: Text(
                          local.forgetPassword,
                          style: theme.textTheme.titleMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                            provider.login(email: emailController.text, password: passwordController.text, context: context);

                        },
                        child: provider.isLoading
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            :Center(child: Text(local.login)),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          local.dontHaveAccount,
                          style: theme.textTheme.bodyMedium,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, RegisterScreen.routeName);

                          },
                          child: Text(
                            local.signup,
                            style: theme.textTheme.titleMedium!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: theme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}