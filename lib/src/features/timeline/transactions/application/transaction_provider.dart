import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketfi/src/constants/firebase_collection_name.dart';
import 'package:pocketfi/src/constants/firebase_field_name.dart';
import 'package:pocketfi/src/constants/typedefs.dart';
import 'package:pocketfi/src/features/authentication/application/user_id_provider.dart';
import 'package:pocketfi/src/features/timeline/transactions/domain/transaction.dart';
import 'package:pocketfi/src/features/timeline/transactions/domain/transaction_key.dart';
import 'package:pocketfi/src/features/timeline/transactions/data/transaction_type_notifier.dart';

final transactionTypeProvider =
    StateNotifierProvider<TransactionTypeNotifier, TransactionType>(
        (ref) => TransactionTypeNotifier());

final createNewTransactionProvider =
    StateNotifierProvider<CreateNewTransactionNotifier, IsLoading>(
        (ref) => CreateNewTransactionNotifier());

final userTransactionsProvider =
    StreamProvider.autoDispose<Iterable<Transaction>>(
  (ref) {
    // get the user id.
    final userId = ref.watch(userIdProvider);

    // The StreamController is used to add the posts to the stream.
    // manages the iterable of posts.
    final controller = StreamController<Iterable<Transaction>>();

    // The onListen callback is called when the stream is listened to.
    controller.onListen = () {
      // add an empty iterable to the stream.
      controller.sink.add([]);
    };

    debugPrint(userId);

    // subscribe to the posts collection.
    final sub = FirebaseFirestore.instance
        // get the posts collection.
        .collection(
          FirebaseCollectionName.users,
        )
        .doc(userId)
        .collection(
          FirebaseCollectionName.wallets,
        )
        .doc('2023-02-27T23:18:16.426104')
        .collection(
          FirebaseCollectionName.transactions,
        )
        // sort the posts by the createdAt field.
        .orderBy(
          FirebaseFieldName.createdAt,
          descending: true, // descending order.
        )
        // filter the posts by the user id.
        // todo - this one no need to add right
        // .where(
        //   TransactionKey.userId,
        //   isEqualTo: userId,
        // )
        .snapshots()
        // listen for changes.
        .listen(
      (snapshot) {
        final documents = snapshot.docs; // get the documents of the snapshot
        final transactions = documents // get the posts from the documents.
            .where(
              // filter the documents that have no pending writes.
              // this is used to avoid displaying the posts that are being created.
              // the posts that are being created will have pending writes.
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              // map the documents to posts.
              (doc) => Transaction(
                transactionId: doc.id,
                json: doc.data(),
              ),
            );
        // add the posts to the stream.
        controller.sink.add(transactions);
      },
    );

    // cancel the subscription when the stream is closed.
    ref.onDispose(() {
      // cancel the subscription.
      sub.cancel();
      // close the stream.
      controller.close();
    });

    // return the stream of posts.
    return controller.stream;
  },
);
