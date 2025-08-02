import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/enums.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/screens/services/service-popup/service_popup.dart';
import 'package:nivaas/screens/services/service-providers-list/ServicePrvidersList.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';

class AddServiceProviders extends StatefulWidget {
  final int? apartmentId;
  final bool? isLeftSelected,isAdmin,isReadOnly;
  const AddServiceProviders({super.key, this.apartmentId, this.isLeftSelected,this.isAdmin,this.isReadOnly});

  @override
  State<AddServiceProviders> createState() => _AddServiceProvidersState();
}

class _AddServiceProvidersState extends State<AddServiceProviders> {
  int? apartmentId;
  int? userId;
  bool? isAdmin;
  String? currentApartment;
  bool? isOwner;
  bool? isTenant;
  bool isLeftSelected = false;
  bool? isReadOnly;
  @override
  void initState() {
    super.initState();
    fetchCurrentCustomer();
  }
  Future<void> fetchCurrentCustomer() async {
    final splashState = context.read<SplashBloc>().state;
    if (splashState is SplashSuccess) {
      final currentUser = splashState.user;
      apartmentId = currentUser.currentApartment!.id;
      isAdmin = currentUser.currentApartment!.apartmentAdmin;
      isOwner = currentUser.user.roles.contains("ROLE_FLAT_OWNER");
      isTenant = currentUser.user.roles.contains("ROLE_FLAT_TENANT");
      isReadOnly = isAdmin! && !widget.isLeftSelected! ? false : true;
      print('ISREADONLY_OWNER : $isReadOnly');
    }
  }

  void _showServicePopup(serviceName, id, apartmentId) {
    showDialog(
      context: context,
      builder: (context) => ServicePopup(
          serviceName: serviceName, categoryId: id, apartmentId: apartmentId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Services'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: nivaasTrustedPartners.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final service = nivaasTrustedPartners[index];
            return GestureDetector(
              onTap: () => isReadOnly ?? true
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceProvidersList(
                          apartmentId: widget.apartmentId ?? apartmentId,
                          categoryId: service['id'],
                        ),
                      ),
                    )
                  : _showServicePopup(
                      service['name'], service['id'], widget.apartmentId),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
                color: AppColor.blueShade,
                child: Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        service['icon'],
                        color: AppColor.blue,
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        service['name'],
                        style: txt_14_500.copyWith(color: AppColor.black),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
