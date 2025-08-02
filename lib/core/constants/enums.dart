import 'package:nivaas/core/constants/img_consts.dart';

const complaintStatusTypes = [
  {'name': 'OPEN'},
  {'name': 'IN_PROGRESS'},
  {'name': 'RESOLVED'},
  {'name': 'CLOSED'},
  {'name': 'REJECTED'},
];
final MaintenanceTypes = [
  {'name': 'UTILITIES'},
  {'name': 'SERVICES'},
  {'name': 'REPAIRS'},
  {'name': 'SALARY'},
  {'name': 'OTHER'},
];
final List<Map<String, dynamic>> nivaasTrustedPartners = [
    {'id': 1, 'name': 'Electrician', 'icon': electrician},
    {'id': 2, 'name': 'Plumbing', 'icon': plumbing},
    {'id': 3, 'name': 'Carpenter', 'icon': carpenter},
    {'id': 4, 'name': 'Cleaning', 'icon': mopIcon},
    {'id': 5, 'name': 'Painting', 'icon': painting},
    {'id': 6, 'name': 'Lift Service', 'icon': elevater},
];
final List<Map<String, dynamic>> gateManagementServices = [
    {'id': 1, 'name': 'Guest','value':'GUEST', 'icon': guestIcon},
    {'id': 2, 'name': 'Service','value':'SERVICE','icon': housewifeIcon},
];
String nivaasSupportMobileNumber = '9177333547';