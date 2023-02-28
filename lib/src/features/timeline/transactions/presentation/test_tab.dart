import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketfi/src/common_widgets/animations/empty_contents_with_text_animation_view.dart';
import 'package:pocketfi/src/common_widgets/animations/error_animation_view.dart';
import 'package:pocketfi/src/common_widgets/animations/loading_animation_view.dart';
import 'package:pocketfi/src/constants/strings.dart';
import 'package:pocketfi/src/features/timeline/posts/application/user_posts_provider.dart';
import 'package:pocketfi/src/features/timeline/transactions/application/transaction_provider.dart';
import 'package:pocketfi/src/features/timeline/transactions/presentation/transactions_list_view.dart';
import 'package:pocketfi/src/features/timeline/transactions/presentation/transactions_list_view_test.dart';

class TestTab extends ConsumerWidget {
  const TestTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // get the posts from the provider
    // stream provider will automatically update the UI when the data changes
    final transactions = ref.watch(userTransactionsProvider);

    // return a RefreshIndicator to allow the user to refresh the posts
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userTransactionsProvider);
        return Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      },
      // return a different widget depending on the state of the posts
      child: transactions.when(
        // if the posts are loaded, return a list of posts
        data: (trans) {
          if (trans.isEmpty) {
            // if there are no posts, return an empty widget
            return const EmptyContentsWithTextAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            // if there are posts, return a list of posts
            return Container(
              padding: const EdgeInsets.only(top: 20),
              color: Colors.grey,
              child: TransactionListViewTest(
                transactions: trans,
              ),
            );
          }
        },

        // if there is an error, return an error widget
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },

        // if the posts are loading, return a loading widget
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
