// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:estc_project/util/shared_preference_util.dart';
import 'package:flutter/widgets.dart';

/// A mock authentication service
class Auth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  set siginedIn(bool value) {
    _signedIn = value;
  }

  Future<void> init() async {
    _signedIn = SharedPreferenceUtil().getToken().isNotEmpty;
  }

  Future<void> signOut() async {
    //await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    SharedPreferenceUtil().setToken('');
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    //await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign in. Allow any password.
    _signedIn = true;
    SharedPreferenceUtil().setToken('token_fake');
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is Auth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class BookstoreAuthScope extends InheritedNotifier<Auth> {
  const BookstoreAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static Auth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BookstoreAuthScope>()!
      .notifier!;
}
