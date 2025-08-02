import 'package:nivaas/data/models/complaints/my_complaints_model.dart';

abstract class MyComplaintsRepository {
  Future<MyComplaintsModel> getComplaints({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  });
}
