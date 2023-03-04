import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketfi/src/constants/firebase_collection_name.dart';
import 'package:pocketfi/src/constants/typedefs.dart';
import 'package:pocketfi/src/features/budget/domain/budget_payload.dart';
import 'package:pocketfi/src/utils/document_id_from_current_date.dart';

class CreateNewBudgetNotifier extends StateNotifier<IsLoading> {
  CreateNewBudgetNotifier() : super(false);

  set isLoading(bool isLoading) => state = isLoading;

  Future<bool> createNewBudget({
    required String budgetName,
    required double budgetAmount,
    // required String walletId,
    required UserId userId,
  }) async {
    isLoading = true;

    final budgetId = documentIdFromCurrentDate();
    //! still need to fix to get the correct walletid
    final walletId = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .doc(userId)
        .collection(FirebaseCollectionName.wallets)
        .limit(1)
        .get()
        .then((value) => value.docs.first.id);

    final payload = BudgetPayload(
      budgetId: budgetId,
      budgetName: budgetName,
      budgetAmount: budgetAmount,
      usedAmount: 0.00,
      walletId: walletId,
    );

    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .doc(userId)
          .collection(FirebaseCollectionName.wallets)
          .doc(walletId)
          .collection(FirebaseCollectionName.budgets)
          .doc(budgetId)
          .set(payload);

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
