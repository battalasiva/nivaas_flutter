import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/data/models/auth/current_customer_model.dart';
import 'package:nivaas/screens/coins-subscription/coins-wallet/bloc/coins_wallet_bloc.dart';
import 'package:nivaas/screens/coins-subscription/purchase-plan/Purchase_plan.dart';
import 'package:nivaas/screens/auth/splashScreen/bloc/splash_bloc.dart';
import 'package:nivaas/screens/coins-subscription/subscription/bloc/subscription_bloc.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:nivaas/widgets/others/ContactUsModel.dart';

class Subscription extends StatefulWidget {
  final int? apartmentId,userId;
  final String? mobileNumber,email,apartmentName;
  const Subscription({super.key, this.apartmentId,this.mobileNumber,this.email,this.userId,this.apartmentName});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int selectedPlan = 1;
  double walletBalance = 0.0;

  @override
  void initState() {
    super.initState();
    context
        .read<SubscriptionBloc>()
        .add(FetchSubscriptionPlansEvent(widget.apartmentId ?? 0));
    context.read<CoinsWalletBloc>().add(
          CoinsBalenceEvent(apartmentId: widget.apartmentId!),
    );
  }
  void showContactUsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ContactUsModal(),
    );
  }
  @override
  Widget build(BuildContext context) {
    print('BALENCE : $walletBalance' 
        'APARTMENT ID : ${widget.apartmentId} '
        'USER ID : ${widget.userId} '
        'MOBILE NUMBER : ${widget.mobileNumber} '
        'EMAIL : ${widget.email} '
        'APARTMENT NAME : ${widget.apartmentName}');
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const TopBar(title: 'Subscription'),
      body: Padding(
        padding: EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CurrentPlanContainer(),
            const SizedBox(height: 20),
            BlocConsumer<CoinsWalletBloc, CoinsWalletState>(
              listener: (context, state) {
                if (state is CoinsBalanceLoaded) {
                  setState(() {
                    walletBalance = state.balance;
                  });
                }
              },
              builder: (context, state) {
                return Container(); 
              },
            ),

            BlocBuilder<SubscriptionBloc, SubscriptionState>(
              builder: (context, state) {
                if (state is SubscriptionLoadingState) {
                  return const Center(child: AppLoader());
                } else if (state is SubscriptionErrorState) {
                  return Center(child: Text("No Plans Available"));
                } else if (state is SubscriptionLoadedState) {
                  final plans = state.plans;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Plans",
                        style: txt_14_600.copyWith(color: AppColor.black2),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(plans.length, (index) {
                          final plan = plans[index];
                          final isSelected = index == selectedPlan;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPlan = index;
                              });
                            },
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.blueShade
                                    : AppColor.white,
                                border: Border.all(
                                  color: isSelected
                                      ? AppColor.primaryColor2
                                      : AppColor.greyText1,
                                  width: isSelected ? 3 : 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${plan['months']}",
                                    style: txt_22_700.copyWith(color: AppColor.black1)),
                                  Text(
                                    "month${plan['months'] > 1 ? 's' : ''}",
                                    style: txt_14_400.copyWith(color: AppColor.black1)
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "₹${plan['totalPlanCost'].toInt()}",
                                    style:txt_18_700.copyWith(color: AppColor.black1)
                                  ),
                                  Text(
                                    "₹${plan['perFlatCost']}/mo",
                                    style:txt_12_400.copyWith(color: AppColor.black1)
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      // Purchase Button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: CustomizedButton(
                          label: 'Purchase Plan',
                          style: txt_11_500.copyWith(color: AppColor.white),
                          onPressed: () {
                            final selected = plans[selectedPlan];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PurchasePlan(
                                    apartmentID: widget.apartmentId ?? 0,
                                    months: selected['months'],
                                    coins: selected['totalPlanCost'],
                                    balance: walletBalance,
                                    mobileNumber:widget.mobileNumber,
                                    email:widget.email,
                                    apartmentName:widget.apartmentName),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Contact Us Section
                      Center(
                        child: Text(
                            "Still Having Doubt About Plans?\nFeel Free To Contact Us!",
                            textAlign: TextAlign.center,
                            style: txt_14_600.copyWith(color: AppColor.black1)),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                          left: getWidth(context) * 0.2,
                          right: getWidth(context) * 0.2,
                        ),
                        child: CustomizedButton(
                          label: 'Contact Us',
                          style: txt_11_500.copyWith(color: AppColor.white),
                          onPressed: (){
                            showContactUsModal(context);
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text("No Plans Available"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


class CurrentPlanContainer extends StatelessWidget {
  const CurrentPlanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        if (state is SplashSuccess) {
          CurrentCustomerModel currentUser = state.user;
          final currentPlan = currentUser.currentApartment?.subscriptionType;
          final startDate = currentUser.currentApartment?.startDate;
          final endDate = currentUser.currentApartment?.endDate;
          print('CURRENT PLAN : $currentPlan $startDate');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Plan",
                style: txt_14_600.copyWith(color: AppColor.black2),
              ),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColor.blueShade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.blueShade,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentPlan ?? 'BASIC',
                              style: txt_16_600.copyWith(
                                  color: AppColor.primaryColor1),
                            ),
                            Text(
                              "Start Date :",
                              style:
                                  txt_12_600.copyWith(color: AppColor.black2),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "End Date :",
                              style:
                                  txt_12_600.copyWith(color: AppColor.black2),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              getMonthDifference(startDate.toString(),endDate.toString()),
                              style: txt_16_600.copyWith(color: AppColor.blue),
                            ),
                            Text(
                              formatDate(startDate?.toString() ?? 'NA'),
                              style: txt_12_600.copyWith(color: AppColor.primaryColor2),
                            ),
                            Text(
                              formatDate(endDate?.toString() ?? 'NA'),
                              style: txt_12_600.copyWith(color: AppColor.primaryColor2),
                            ),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}