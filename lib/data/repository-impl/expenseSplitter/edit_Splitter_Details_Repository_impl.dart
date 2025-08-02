import 'package:nivaas/data/provider/network/api/expenseSplitter/edit_splitter_details_datasource.dart';
import 'package:nivaas/domain/repositories/expenseSplitter/edit_Splitter_Details_Repository.dart';

class EditSplitterDetailsRepositoryImpl implements EditSplitterDetailsRepository {
  final EditSplitterDetailsDatasource datasource;

  EditSplitterDetailsRepositoryImpl(this.datasource);

  @override
  Future<void> editSplitterDetails(int id, Map<String, dynamic> payload) {
    return datasource.putEditSplitterDetails(id, payload);
  }
}