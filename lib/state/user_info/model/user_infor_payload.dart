import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo_list/state/constants/firebase_field_name.dart';
import 'package:todo_list/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String>{
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email
  }):super(
    {
      FirebaseFieldName.userId: userId,
      FirebaseFieldName.email: email ?? '',
      FirebaseFieldName.displayName: displayName ?? ''
    }
  );
}