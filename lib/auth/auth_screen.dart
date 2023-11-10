import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/assets.dart';
import '../app/dimens.dart';
import '../app/routes.dart';
import '../app/utils/strings.dart';
import 'auth_screen_controller.dart';
import 'auth_screen_state.dart';
import 'auth_type.dart';

class AuthScreen extends ConsumerStatefulWidget {
  final AuthScreenType type;

  const AuthScreen({super.key, this.type = AuthScreenType.login});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _form = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  final _controller =
      NotifierProvider.autoDispose<AuthScreenController, AuthScreenState>(
    AuthScreenController.new,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.padding),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _title(),
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (widget.type == AuthScreenType.register) ...{
                  const SizedBox(height: AppDimens.padding),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your username',
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                },
                const SizedBox(height: AppDimens.secondaryPadding),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                if (widget.type == AuthScreenType.login) ...{
                  const SizedBox(height: AppDimens.secondaryPadding),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  )
                },
                const SizedBox(height: AppDimens.secondaryPadding),
                SizedBox(
                  width: double.infinity,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final isLoading = ref.watch(
                        _controller.select((state) => state.loading),
                      );
                      return FilledButton(
                        onPressed: isLoading ? null : _submitForm,
                        child: Text(
                          isLoading ? 'please wait...' : _buttonText(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppDimens.padding),
                _AuthDivider(widget.type),
                const SizedBox(height: AppDimens.secondaryPadding),
                const _OAuth(),
                const SizedBox(height: AppDimens.secondaryPadding),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: '${_bottomLeftAction()} ',
                      style: theme.textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: _rightActionText(),
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _rightAction,
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    // cancel if the form is not valid
    if (_form.currentState?.validate() != true) {
      return;
    }
    // hide the keyboard so errors can be seen
    FocusScope.of(context).unfocus();
    final action = ref.read(_controller.notifier).submit(
          email: _emailController.text,
          username: _usernameController.text,
          type: widget.type,
        );
    action.then((value) {
      if (!value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.read(_controller).error ?? 'An error occurred',
            ),
          ),
        );
      } else {
        Navigator.pushNamed(context, AppRoutes.otp);
      }
    });
  }

  /// Returns the title based on [widget.type].
  String _title() {
    return switch (widget.type) {
      AuthScreenType.login => 'Welcome back, please log in',
      AuthScreenType.register => 'Join us and get started!'
    };
  }

  /// Returns the button text based on [widget.type].
  String _buttonText() {
    return switch (widget.type) {
      AuthScreenType.login => 'Login',
      AuthScreenType.register => 'Register'
    };
  }

  /// Returns the left bottom action text based on [widget.type].
  String _bottomLeftAction() {
    return switch (widget.type) {
      AuthScreenType.login => "Don't have an account?",
      AuthScreenType.register => 'Already have an account?'
    };
  }

  /// Returns the right bottom action text based on [widget.type].
  String _rightActionText() {
    return switch (widget.type) {
      AuthScreenType.login => 'Register now',
      AuthScreenType.register => 'Login Now'
    };
  }

  /// Performs the right action based on [widget.type].
  Future<void> _rightAction() async {
    await switch (widget.type) {
      AuthScreenType.login => Navigator.pushReplacementNamed(
          context,
          AppRoutes.register,
        ),
      AuthScreenType.register => Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        )
    };
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class _AuthDivider extends StatelessWidget {
  const _AuthDivider(this.type);

  final AuthScreenType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.padding / 2,
          ),
          child: Text(
            switch (type) {
              AuthScreenType.login => 'Or Login with',
              AuthScreenType.register => 'Or Register with'
            },
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6A707C),
                ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _OAuth extends StatelessWidget {
  const _OAuth();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _button(AppAssets.facebookIcon, () {}),
        const SizedBox(width: AppDimens.padding / 2),
        _button(AppAssets.googleIcon, () {}),
        const SizedBox(width: AppDimens.padding / 2),
        _button(AppAssets.appleIcon, () {}),
      ],
    );
  }

  Widget _button(String image, VoidCallback onPressed) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: Color(0xFFE5E5E5)),
        ),
        onPressed: onPressed,
        child: SvgPicture.asset(image),
      ),
    );
  }
}