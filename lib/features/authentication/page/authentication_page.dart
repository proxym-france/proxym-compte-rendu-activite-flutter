import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycra_timesheet_app/core/utils/state.dart';
import 'package:mycra_timesheet_app/features/authentication/controller/authentication_controller.dart';
import 'package:mycra_timesheet_app/generated/l10n.dart';

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key});

  @override
  ConsumerState<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  late String mail;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    final authenticationController = ref.watch(authenticationControllerProvider);
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            width: size.width,
            height: size.height,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: size.width * .9,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
                          child: Image.asset(Theme.of(context).brightness == Brightness.light
                              ? 'assets/images/full_logo_light.png'
                              : 'assets/images/full_logo_dark.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, bottom: 8),
                          child: Text(
                            'Email',
                            style: textTheme.titleMedium,
                          ),
                        ),
                        TextFormField(
                          onSaved: (newValue) => setState(() => mail = newValue ?? ''),
                          initialValue: 'sofien.touati@proxym-it.com',
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return RegExp(
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                    .hasMatch(value ?? '')
                                ? null
                                : S.of(context).checkYourEmail;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            label: Text(S.of(context).mailPlaceHolder),
                            labelStyle: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, bottom: 8),
                          child: Text(
                            S.of(context).password,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value?.isNotEmpty == true ? null : S.of(context).pleaseProvideAPassword;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            filled: true,
                            label: const Text('••••••••••••••••'),
                            labelStyle: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          maxLines: 1,
                          onFieldSubmitted: (value) {
                            // setState(() {
                            submitLoginForm(ref.read(authenticationControllerProvider.notifier),
                                (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: error)));
                            // });
                          },
                        ),
                        SizedBox(
                          height: size.height * .05,
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 64.0),
                            child: FilledButton(
                                onPressed: () {
                                  // setState(() {
                                  if (authenticationController is Initial || authenticationController is Error) {
                                    submitLoginForm(ref.read(authenticationControllerProvider.notifier),
                                        (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: error)));
                                  }
                                  // });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: switch (authenticationController) {
                                    Success() || Loading() => CircularProgressIndicator(color: colorScheme.onPrimary),
                                    _ => Text('login'.toUpperCase()),
                                  },
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitLoginForm(AuthenticationController controller, Function onError) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      controller.getCollabByEmail(mail).catchError((error, stackTrace) {
        onError(error);
      });
    }
  }
}
