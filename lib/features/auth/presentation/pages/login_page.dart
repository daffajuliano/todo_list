import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/utils/dimens.dart';
import 'package:todo_list/features/auth/presentation/states/auth_cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            loaded: (data) {},
            failed: (message) {
              log(message);
            },
          );
        },
        builder: (context, state) {
          Widget button = SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).login(
                  _usernameController.text,
                  _passwordController.text,
                );
              },
              child: const Text('Login'),
            ),
          );

          button = state.when<Widget>(
            initial: () => button,
            loading: () {
              return const SizedBox(
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            loaded: (data) => button,
            failed: (message) => button,
          );

          return Container(
            padding: const EdgeInsets.all(AppDimen.marginPaddingMedium),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login User',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: AppDimen.marginPaddingSmall),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: AppDimen.marginPaddingSmall),
                button,
              ],
            ),
          );
        },
      ),
    );
  }
}
