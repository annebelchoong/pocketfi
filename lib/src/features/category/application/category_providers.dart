import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketfi/src/features/category/domain/default_categories.dart';
import 'package:pocketfi/src/features/category/data/category_state_notifier.dart';
import 'package:pocketfi/src/features/category/domain/category.dart';
import 'package:pocketfi/src/features/timeline/transactions/application/transaction_provider.dart';
import 'package:pocketfi/src/features/timeline/transactions/domain/transaction.dart';

final selectedCategoryProvider = StateProvider<Category?>(
  (ref) {
    final transactionTypeIndex = ref.watch(transactionTypeProvider);

    if (transactionTypeIndex == TransactionType.expense) {
      return expenseCategories.first;
    } else if (transactionTypeIndex == TransactionType.income) {
      return incomeCategories.first;
    } else {
      return null;
    }
  },
);

final categoriesProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>(
  (_) => CategoryNotifier(),
);

final expenseCategoriesProvider = Provider<List<Category>>(
  (ref) => expenseCategories,
);

final incomeCategoriesProvider = Provider<List<Category>>(
  (ref) => incomeCategories,
);
