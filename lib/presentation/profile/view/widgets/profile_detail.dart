import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/auth_bloc.dart';
import '../../../../core/model/user_model.dart';
import 'custom_decorated_box.dart';
import 'custom_label.dart';
import 'logout_button.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
    required UserModel user,
    required this.constraints,
  }) : _user = user;

  final UserModel _user;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
          ),
          CustomLabel(label: "Name"),
          SizedBox(
            height: 9,
          ),
          CustomDecoratedBox(
            title: _user.name,
            width: constraints.maxWidth,
          ),
          SizedBox(
            height: 20,
          ),
          CustomLabel(label: "Email id"),
          SizedBox(
            height: 9,
          ),
          CustomDecoratedBox(
            title: _user.email,
            width: constraints.maxWidth,
          ),
          SizedBox(
            height: 75,
          ),
          LogoutButton(
            width: constraints.maxWidth,
            onPressed: () => context.read<AuthBloc>().add(
                  AppLogoutRequested(),
                ),
          ),
          SizedBox(
            height: 31,
          ),
        ],
      ),
    );
  }
}
