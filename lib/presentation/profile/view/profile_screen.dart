import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/widgets/back_button.dart';
import 'package:shopsavvy/presentation/profile/view/widgets/profile_detail.dart';
import 'package:shopsavvy/presentation/profile/view/widgets/profile_image.dart';

import '../../../core/bloc/auth_bloc.dart';
import '../../../core/model/user_model.dart';
import '../../../core/widgets/background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen._();

  static Widget routeBuilder(BuildContext context, GoRouterState state) {
    return const ProfileScreen._();
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = context.select<AuthBloc, UserModel>(
      (value) => value.state.user,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.loose,
                      children: [
                        Background(
                          constraints: constraints,
                          height: constraints.maxHeight * 0.375,
                        ),
                        CustomBackButton(),
                        ProfileImage(
                          constraints: constraints,
                          imageUrl: user.photo,
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                    fit: FlexFit.loose,
                    child: ProfileDetail(user: user, constraints: constraints))
              ],
            ),
          );
        },
      ),
    );
  }
}
