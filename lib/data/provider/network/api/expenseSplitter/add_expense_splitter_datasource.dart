import 'package:nivaas/core/constants/api_urls.dart';
import 'package:nivaas/core/error/exception_handler.dart';
import 'package:nivaas/data/models/expenseSplitter/add_expense_splitter_model.dart';
import 'package:nivaas/data/provider/network/service/api_client.dart';

class AddExpenseSplitterDatasource {
  final ApiClient apiClient;

  AddExpenseSplitterDatasource({required this.apiClient});

  Future<bool> createExpenseSplitter(AddExpenseSplitterModel splitDetails,) async{

    // final Map<String, dynamic> payload = {
    //   "apartmentId": apartmentId,
    //   "amount": amount,
    //   "splitType": splitType,
    //   "enabled": true,
    //   "splitterName": splitterName,
    //   "splitDetails": splitDetails,
    // };
    print('payload: -------- $splitDetails');

    try {
      final response = await apiClient.post(ApiUrls.addExpenseSplitter, splitDetails.toJson());
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode ==201) {
        return true;
      } else{
        throw ExceptionHandler.handleHttpException(response);
      }
    } catch (e) {
      throw ExceptionHandler.handleError(e.toString());
    }
  }
}