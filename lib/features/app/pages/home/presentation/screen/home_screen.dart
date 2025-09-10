import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/core/di/injection.dart';
import 'package:packina/core/widgets/custom_green_button_widget.dart';
import 'package:packina/core/constants/const.dart';
import 'package:packina/features/app/pages/home/presentation/widgets/build_status_card.dart';
import 'package:packina/features/app/pages/home/presentation/widgets/home_custom_appbar_widget.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/screens/hostel_screen.dart';
import 'package:packina/features/app/pages/manage_report/presentation/screens/report_screen.dart';
import '../provide/bloc/dashboard/dashboard_bloc.dart';
import '../widgets/home_dashboard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardBloc>()..add(FetchDashboardData()),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, height * 0.28),
          child: HomeCustomAppbarWidget(),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<DashboardBloc>().add(FetchDashboardData());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  height10,
                  HomeDashBoardWidget(),
                  height20,
                  CustomGreenButtonWidget(
                    name: 'Manage hostels',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HostelScreen(),
                        ),
                      );
                    },
                  ),
                  height20,
                  CustomGreenButtonWidget(
                    name: 'Manage Reports',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
