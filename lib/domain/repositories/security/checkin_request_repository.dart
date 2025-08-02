abstract class CheckinRequestRepository {
  Future<bool> sendCheckinRequest(int apartmentId, int flatId, String type, String name, String mobileNumber);
}