import 'package:flutter/material.dart';
import 'package:packina/core/widgets/custom_green_button_widget.dart';
import 'package:packina/features/app/pages/manage_report/presentation/screens/report_screen.dart';
import '../../../../../../core/constants/const.dart';
import '../../../manage_hostel/presentation/screens/hostel_screen.dart';
import '../widgets/build_status_card.dart';
import '../widgets/home_custom_appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const HomeCustomAppbarWidget(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [

                  height10,
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // First row: 2 cards
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: BuildStatusCard(
                                  icon: Icons.people_alt_outlined,
                                  value: '20',
                                  label: 'Hostels',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: BuildStatusCard(
                                  icon: Icons.person,
                                  value: '400',
                                  label: 'Reports',
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Second row: 2 cards
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: BuildStatusCard(
                                  icon: Icons.person,
                                  value: '20',
                                  label: 'Blocked Hostel',
                                  pending: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5.0),
                                child: BuildStatusCard(
                                  icon: Icons.money,
                                  value: '40000',
                                  label: 'Active users',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  height20,
                  CustomGreenButtonWidget(
                    name: 'Manage hostels',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HostelScreen(),
                          ));
                    },
                  ),
                  height20,
                  CustomGreenButtonWidget(
                    name: 'Manage Reports',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportScreen(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
