part of 'services.dart';

class AppTransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection('transactions');

  static Future<void> saveTransaction(AppTransaction transaction) async {
    await _transactionCollection.doc().set({
      'userId': transaction.userId,
      'title': transaction.title,
      'subtitle': transaction.subtitle,
      'amount': transaction.amount,
      'time': transaction.time.millisecondsSinceEpoch,
      'picture': transaction.picture,
    });
  }

  static Future<List<AppTransaction>> getTransactions(String userId) async {
    QuerySnapshot snapshot = await _transactionCollection.get();

    var documents = snapshot.docs.where((doc) => doc['userId'] == userId);

    return documents
        .map((e) => AppTransaction(
              userId: e['userId'],
              title: e['title'],
              subtitle: e['subtitle'],
              amount: e['amount'],
              time: DateTime.fromMillisecondsSinceEpoch(e['time']),
              picture: e['picture'],
            ))
        .toList();
  }
}
