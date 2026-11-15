import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/navigation/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_form_container.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../application/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(email: _email, password: _password);
    } on StateError {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).authDebugOnly)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: AppFormContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizations.loginTitle,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        localizations.loginDescription,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      AppTextField(
                        labelText: localizations.emailLabel,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (value) => value == null || value.isEmpty
                            ? localizations.requiredFieldError
                            : null,
                        onSaved: (value) => _email = value!.trim(),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        labelText: localizations.passwordLabel,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validator: (value) => value == null || value.isEmpty
                            ? localizations.requiredFieldError
                            : null,
                        onSaved: (value) => _password = value!,
                        onFieldSubmitted: (_) => _signIn(),
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        onPressed: _signIn,
                        child: Text(localizations.loginAction),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => context.pushNamed(AppRoutes.register),
                        child: Text(localizations.registerPrompt),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
