// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Color;

import 'package:pocketfi/src/constants/app_colors.dart';
import 'package:pocketfi/src/constants/firebase_field_name.dart';
import 'package:pocketfi/src/constants/strings.dart';
import 'package:pocketfi/src/features/timeline/transactions/domain/transaction_key.dart';

enum TransactionType {
  expense(
    symbol: Strings.expenseSymbol,
    color: Color(AppColors.expenseColor),
  ),
  income(
    symbol: Strings.incomeSymbol,
    color: Color(AppColors.incomeColor),
  ),
  transfer(
    symbol: Strings.transferSymbol,
    color: Color(AppColors.transferColor),
  );

  final String symbol;
  final Color color;

  const TransactionType({
    required this.symbol,
    required this.color,
  });
}

@immutable
class Transaction {
  final String transactionId;
  final String userId;
  final String walletId;
  final double amount;
  final String categoryName;
  final TransactionType type;
  final DateTime? createdAt;
  final DateTime date;
  final bool isBookmark;
  final String? description;
  final String? thumbnailUrl; // image
  final String? fileUrl; // image
  final String? fileName; // image
  final double? aspectRatio; // image
  final String? thumbnailStorageId; // image
  final String? originalFileStorageId; // image
  // final List<Tag> tags;

  // Transaction({
  //   required this.transactionId,
  //   required Map<String, dynamic> json,
  // })  :
  //       // userId = json[TransactionKey.userId],
  //       amount = json[TransactionKey.amount],
  //       // categoryName = Category.fromJson(json[TransactionKey.category]),
  //       categoryName = json[TransactionKey.categoryName],
  //       description = json[TransactionKey.description],
  //       type = TransactionType.values.firstWhere(
  //         (transactionType) =>
  //             transactionType.name == json[TransactionKey.type],
  //         orElse: () => TransactionType.expense,
  //       ),
  //       date = (json[TransactionKey.date] as Timestamp?)?.toDate() ??
  //           DateTime.now(),
  //       isBookmark = json[TransactionKey.isBookmark] ?? false,
  //       createdAt = (json[TransactionKey.createdAt] as Timestamp).toDate(),
  //       thumbnailUrl = json[TransactionKey.thumbnailUrl],
  //       fileUrl = json[TransactionKey.fileUrl],
  //       filename = json[TransactionKey.fileName],
  //       aspectRatio = json[TransactionKey.aspectRatio],
  //       thumbnailStorageId = json[TransactionKey.thumbnailStorageId],
  //       originalFileStorageId = json[TransactionKey.originalFileStorageId];
  // // tags = [
  // //   for (final tag in json[TransactionKey.tags])
  // //     Tag(
  // //       tagId: tag['tagId'],
  // //       tagName: tag['tagName'],
  // //       tagColor: tag['tagColor'],
  // //       tagIcon: tag['tagIcon'],
  // //     ),
  // // ];

  const Transaction({
    required this.transactionId,
    required this.userId,
    required this.walletId,
    required this.amount,
    required this.categoryName,
    required this.description,
    required this.type,
    required this.date,
    this.isBookmark = false,
    this.createdAt,
    this.thumbnailUrl,
    this.fileUrl,
    this.fileName,
    this.aspectRatio,
    this.thumbnailStorageId,
    this.originalFileStorageId,
  });

  Transaction.fromJson({
    required String transactionId,
    required Map<String, dynamic> json,
  }) : this(
          transactionId: transactionId,
          userId: json[TransactionKey.userId],
          walletId: json[TransactionKey.walletId],
          amount: json[TransactionKey.amount],
          categoryName: json[TransactionKey.categoryName],
          description: json[TransactionKey.description],
          type: TransactionType.values.firstWhere(
            (transactionType) =>
                transactionType.name == json[TransactionKey.type],
            orElse: () => TransactionType.expense,
          ),
          date: (json[TransactionKey.date] as Timestamp?)?.toDate() ??
              DateTime.now(),
          isBookmark: json[TransactionKey.isBookmark] ?? false,
          createdAt: (json[TransactionKey.createdAt] as Timestamp).toDate(),
          thumbnailUrl: json[TransactionKey.thumbnailUrl],
          fileUrl: json[TransactionKey.fileUrl],
          fileName: json[TransactionKey.fileName],
          aspectRatio: json[TransactionKey.aspectRatio],
          thumbnailStorageId: json[TransactionKey.thumbnailStorageId],
          originalFileStorageId: json[TransactionKey.originalFileStorageId],
        );

  Map<String, dynamic> toJson() => {
        TransactionKey.userId: userId,
        TransactionKey.walletId: walletId,
        TransactionKey.amount: amount,
        TransactionKey.categoryName: categoryName,
        TransactionKey.type: type.name,
        TransactionKey.createdAt: FieldValue.serverTimestamp(),
        TransactionKey.date: date,
        TransactionKey.isBookmark: isBookmark,
        TransactionKey.description: description,
        TransactionKey.thumbnailUrl: thumbnailUrl,
        TransactionKey.fileUrl: fileUrl,
        TransactionKey.fileName: fileName,
        TransactionKey.aspectRatio: aspectRatio,
        TransactionKey.thumbnailStorageId: thumbnailStorageId,
        TransactionKey.originalFileStorageId: originalFileStorageId,
        // TransactionKey.tags: [
        //   for (final tag in tags)
        //     {
        //       'tagId': tag.tagId,
        //       'tagName': tag.tagName,
        //       'tagColor': tag.tagColor,
        //       'tagIcon': tag.tagIcon,
        //     },
        // ],
      };

  Transaction copyWith({
    String? transactionId,
    String? userId,
    String? walletId,
    double? amount,
    String? categoryName,
    TransactionType? type,
    DateTime? createdAt,
    DateTime? date,
    bool? isBookmark,
    String? description,
    String? thumbnailUrl,
    String? fileUrl,
    String? fileName,
    double? aspectRatio,
    String? thumbnailStorageId,
    String? originalFileStorageId,
  }) {
    return Transaction(
      transactionId: transactionId ?? this.transactionId,
      userId: userId ?? this.userId,
      walletId: walletId ?? this.walletId,
      amount: amount ?? this.amount,
      categoryName: categoryName ?? this.categoryName,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      date: date ?? this.date,
      isBookmark: isBookmark ?? this.isBookmark,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      fileUrl: fileUrl ?? this.fileUrl,
      fileName: fileName ?? this.fileName,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      thumbnailStorageId: thumbnailStorageId ?? this.thumbnailStorageId,
      originalFileStorageId:
          originalFileStorageId ?? this.originalFileStorageId,
    );
  }
}
