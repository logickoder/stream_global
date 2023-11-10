import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/assets.dart';
import '../app/dimens.dart';
import 'auth_account_verified_dialog.dart';
import 'auth_otp_controller.dart';
import 'auth_otp_state.dart';

final _controller =
    NotifierProvider.autoDispose<AuthOtpController, AuthOtpState>(
  AuthOtpController.new,
);

class AuthOtpScreen extends ConsumerStatefulWidget {
  const AuthOtpScreen({super.key});

  @override
  ConsumerState<AuthOtpScreen> createState() => _AuthOtpScreenState();
}

class _AuthOtpScreenState extends ConsumerState<AuthOtpScreen> {
  final _controllers = List.generate(5, (index) => TextEditingController());
  final _form = GlobalKey<FormState>();
  final _retryOtp = StateProvider((ref) => true);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.576,
              child: SvgPicture.asset(AppAssets.otpIcon),
            ),
            const SizedBox(height: AppDimens.padding),
            Text(
              'Verify your email',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.secondaryPadding),
            FractionallySizedBox(
              widthFactor: 0.74,
              child: Text(
                'Enter the verification code we just sent on your email address.',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppDimens.padding),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Form(
                key: _form,
                child: _VerificationInput(
                  controllers: _controllers,
                  onError: (error) {
                    ref.read(_controller.notifier).setError(error);
                  },
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final error = ref.watch(
                  _controller.select((state) => state.error),
                );
                return error != null
                    ? Text(
                        error,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
            const SizedBox(height: AppDimens.padding),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: Consumer(
                builder: (_, ref, __) {
                  final loading = ref.watch(
                    _controller.select((state) => state.loading),
                  );
                  return FilledButton(
                    onPressed: loading ? null : _submitForm,
                    child: Text(loading ? 'please wait...' : 'Verify'),
                  );
                },
              ),
            ),
            const SizedBox(height: AppDimens.padding),
            _ResendOtp(_retryOtp),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // cancel if the form is not valid
    if (_form.currentState?.validate() != true) {
      return;
    }

    final action = ref.read(_controller.notifier).verifyOtp(
          otp: _controllers.map((e) => e.text).join(),
        );
    action.then((success) {
      if (success) {
        showAdaptiveDialog(
          context: context,
          builder: (_) => const AuthAccountVerifiedDialog(),
          barrierDismissible: false,
        );
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _VerificationInput extends StatefulWidget {
  const _VerificationInput({
    Key? key,
    required this.controllers,
    this.onError,
  }) : super(key: key);

  final List<TextEditingController> controllers;
  final ValueChanged<String?>? onError;

  @override
  State<_VerificationInput> createState() => _VerificationInputState();
}

class _VerificationInputState extends State<_VerificationInput> {
  late final nodes = List.generate(
    widget.controllers.length,
    (index) => FocusNode(),
  );

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        final number = value ?? '';
        String? message;
        if (number.isEmpty) {
          message = 'Please enter the otp you received';
        } else if (number.length < nodes.length) {
          message = 'Please enter the full otp';
        }

        widget.onError?.call(message);
        return message;
      },
      builder: (state) {
        return Row(
          children: List.generate(
            nodes.length,
            (index) {
              final previous = index == 0 ? null : nodes[index - 1];
              final next = index < (nodes.length - 1) ? nodes[index + 1] : null;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.secondaryPadding / 4,
                  ),
                  child: _Input(
                    controller: widget.controllers[index],
                    previous: previous,
                    current: nodes[index],
                    next: next,
                    onChanged: (_) {
                      state.didChange(
                        widget.controllers.map((e) => e.text).toList().join(),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (final node in nodes) {
      node.dispose();
    }
    super.dispose();
  }
}

class _Input extends StatelessWidget {
  const _Input({
    Key? key,
    this.previous,
    this.current,
    this.next,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode? previous, current, next;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final focus = FocusScope.of(context);
    return FormField<String>(
      validator: (value) {
        final number = value ?? '';
        if (number.isEmpty) {
          return 'A code is required for this field';
        } else {
          return null;
        }
      },
      builder: (state) {
        return TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          focusNode: current,
          textAlign: TextAlign.center,
          maxLength: 1,
          onChanged: (input) {
            // makes sure that the input is always a number
            if (input != '' && int.tryParse(input) == null) {
              controller.text = '';
              return;
            }
            state.didChange(input);
            onChanged?.call(input);
            // moves to the next or previous input depending on if the user
            // typed or cleared a number
            if (input.isNotEmpty) {
              focus.requestFocus(next);
            } else {
              focus.requestFocus(previous);
            }
          },
          decoration: const InputDecoration(
            counterText: '',
            fillColor: Colors.transparent,
          ),
        );
      },
    );
  }
}

class _ResendOtp extends ConsumerStatefulWidget {
  const _ResendOtp(this._retryOtp);

  final StateProvider<bool> _retryOtp;

  @override
  ConsumerState<_ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends ConsumerState<_ResendOtp> {
  static const _retryTimeout = Duration(minutes: 1);

  late final _retryCountdown = StreamProvider((ref) async* {
    final retry = ref.watch(widget._retryOtp);
    var duration = _retryTimeout;
    const countdown = Duration(seconds: 1);
    if (retry) {
      while (!duration.isNegative) {
        await Future.delayed(countdown);
        duration -= countdown;
        if (duration == Duration.zero) {
          ref.read(widget._retryOtp.notifier).state = !retry;
        }
        yield duration;
      }
    } else {
      yield Duration.zero;
    }
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final retry = ref.watch(widget._retryOtp);
    final duration = ref.watch(_retryCountdown);

    return RichText(
      text: TextSpan(
        text: "Didn't receive code? ",
        style: theme.textTheme.bodyLarge,
        children: [
          TextSpan(
            text: retry
                ? duration.when(
                    error: (error, stackTrace) => 'Error $error',
                    loading: () => _duration(_retryTimeout),
                    data: (data) => _duration(data),
                  )
                : 'Resend Code',
            style: TextStyle(
              color: theme.colorScheme.inversePrimary,
              fontWeight: FontWeight.w700,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (!retry) {
                  // ref.read(_controller.notifier).sendOtp();
                  ref.read(widget._retryOtp.notifier).state = true;
                }
              },
          ),
        ],
      ),
    );
  }

  String _duration(Duration duration) {
    return 'Resend in ${duration.inMinutes.toString().padLeft(2, '0')}:${duration.inSeconds.toString().padLeft(2, '0')}';
  }
}
