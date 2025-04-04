import 'package:flutter/widgets.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/model/query_model.dart';
import 'package:food_app/services/rais%20query/db_helper.dart';

class QueryProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<QueryModel> _queries = [];

  List<QueryModel> get queries => _queries;

  Future<void> loadQueries() async {
    _queries = await DbHelper.getQueries();
    notifyListeners();
  }

  Future<void> addQueries(QueryModel query) async {
    await DbHelper.insertQuery(query);
    notifyListeners();
    await loadQueries();
  }

  Future<void> updateQueries(QueryModel query) async {
    await DbHelper.insertQuery(query);
    notifyListeners();
    await loadQueries();
  }

  Future<void> deleteQueries(String ticketId) async {
    await DbHelper.deleteQuery(ticketId);
    notifyListeners();
    await loadQueries();
  }
}
