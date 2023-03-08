// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;

import 'package:pocketfi/src/constants/firebase_field_name.dart';
import 'package:pocketfi/src/constants/typedefs.dart';
import 'package:pocketfi/src/features/authentication/domain/collaborators_info.dart';
// import 'package:pocketfi/src/features/authentication/domain/user_info_model.dart';

@immutable
class Wallet {
  final String walletId;
  final String walletName;
  // final double walletBalance;
  final DateTime createdAt;
  // TODO maybe a list idk
  final UserId userId;
  final List<dynamic>? collaborators;
  // TODO add final Category category;

  Wallet(Map<String, dynamic> json)
      : walletId = json[FirebaseFieldName.walletId],
        walletName = json[FirebaseFieldName.walletName],
        // walletBalance = json[FirebaseFieldName.walletBalance],
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        userId = json[FirebaseFieldName.userId] as UserId,
        collaborators = json[FirebaseFieldName.collaborators];
  // Wallet(Map<String, dynamic> json, {required this.walletId})
  //     : walletName = json[FirebaseFieldName.walletName],
  //       walletBalance = json[FirebaseFieldName.walletBalance],
  //       createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
  //       userId = json[FirebaseFieldName.userId] as UserId;

  @override
  bool operator ==(covariant Wallet other) =>
      runtimeType == other.runtimeType &&
      other.walletId == walletId &&
      other.walletName == walletName &&
      // other.walletBalance == walletBalance &&
      other.createdAt == createdAt &&
      // other.collaborators == collaborators &&
      other.userId == userId;

  @override
  int get hashCode => Object.hashAll(
        [
          walletId,
          walletName,
          // walletBalance,
          createdAt,
          userId,
        ],
      );
}
