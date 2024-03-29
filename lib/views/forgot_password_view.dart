import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bluecheck/services/auth/bloc/auth_bloc.dart';
import 'package:bluecheck/services/auth/bloc/auth_event.dart';
import 'package:bluecheck/services/auth/bloc/auth_state.dart';
import 'package:bluecheck/utilities/dialogs/error_dialog.dart';
import 'package:bluecheck/utilities/dialogs/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(context,
                'We could not process your request. Please make sure you have created an account, if not, go back and sign up');
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Forgot Password'),
            centerTitle: true,
          ),
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                      'Enter your email and we will send a password reset link'),
                      TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                        helperText: 'A valid email e.g. joe.doe@gmail.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 25),
                                          child: Column(
                                            children: [
                                              ElevatedButton(
                                                              onPressed: () {
                                                                final email = _controller.text;
                                                                context.read<AuthBloc>().add(
                                                                      AuthEventForgotPassword(email: email),
                                                                    );
                                                              },
                                                              child: const Text('Reset Password'),
                                                            ),
                                                          TextButton(
                                                              onPressed: () {
                                                                context.read<AuthBloc>().add(
                                                                      const AuthEventLogOut(),
                                                                    );
                                                              },
                                                              child: const Text('Go back to Login')),                                          ],
                                          ),
                                        ),


                ],
              ))),
    );
  }
}
