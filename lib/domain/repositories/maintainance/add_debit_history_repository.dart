// abstract class AddDebitMaintainanceRepository {
//   Future<String> postAddDebitMaintainance(int apartmentId, String amount,
//       String description, String transactionDate, String type);
// }
abstract class AddDebitMaintainanceRepository {
  Future<String> postAddDebitMaintainance(
      int apartmentId, String amount, String description, String transactionDate, String type);
}
