import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopsavvy/core/widgets/back_button.dart';
import 'package:shopsavvy/presentation/profile/view/widgets/profile_detail.dart';

import '../../../core/bloc/auth_bloc.dart';
import '../../../core/model/user_model.dart';
import '../../../core/utils/assets.dart';
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
                        Positioned(
                          top: constraints.maxHeight * 0.175,
                          left: constraints.maxWidth * 1 / 6,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffD8D8D8),
                              borderRadius: BorderRadius.circular(20),
                              image: user.photo == null
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        Assets.profilePlaceholder,
                                      ),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(user.photo!),
                                    ),
                            ),
                            constraints: BoxConstraints(
                              maxHeight: constraints.maxWidth * 0.675,
                              maxWidth: constraints.maxWidth * 0.675,
                            ),
                          ),
                        ),
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
