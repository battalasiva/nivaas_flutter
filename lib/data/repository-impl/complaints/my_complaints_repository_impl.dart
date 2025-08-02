import 'package:flutter/foundation.dart';
import 'package:nivaas/data/provider/network/api/complaints/my_complaint_data_source.dart';
import 'package:nivaas/domain/repositories/complaints/my_complaints_repository.dart';
import '../../models/complaints/my_complaints_model.dart';

class MyComplaintsRepositoryImpl implements MyComplaintsRepository {
  final MyComplaintsDataSource dataSource;

  MyComplaintsRepositoryImpl({required this.dataSource});

  @override
  Future<MyComplaintsModel> getComplaints({
    required int apartmentId,
    required int pageNo,
    required int pageSize,
  }) async {
    try {
      return await dataSource.fetchComplaints(
        apartmentId: apartmentId,
        pageNo: pageNo,
        pageSize: pageSize,
      );
    } catch (e) {
      debugPrint('Error fetching complaints: $e');
      rethrow;
    }
  }
}
