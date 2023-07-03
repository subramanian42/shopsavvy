import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';

import 'app.dart';
import 'core/repository/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthRepository();
  final productRepository = ProductRepository();
  await authRepository.user.first;
  runApp(
ShopSavvy(
        authRepository: authRepository,
        productRepository: productRepository,
      ),
  );
}
