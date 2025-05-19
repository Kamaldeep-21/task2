import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PassGenerator {
  String generatePass(int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+-=[]{}|;:,.<>?';
    final Random rnd = Random.secure();
    return List.generate(length, (index) => chars[rnd.nextInt(chars.length)]).join();
  }
}
