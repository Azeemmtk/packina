import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../provide/bloc/dashboard/dashboard_bloc.dart';
import 'build_status_card.dart';

class HomeDashBoardWidget extends StatelessWidget {
  const HomeDashBoardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is DashboardLoaded) {
          final data = state.adminDashboardData;
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // First row
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BuildStatusCard(
                          icon: Icons.people_alt_outlined,
                          value: data.hostelsCount.toString(),
                          label: 'Hostels',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BuildStatusCard(
                          icon: Icons.person,
                          value: data.pendingReportsCount
                              .toString(),
                          label: 'Pending Reports',
                          pending: true,
                        ),
                      ),
                    ),
                  ],
                ),
                // Second row
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BuildStatusCard(
                          icon: Icons.person,
                          value:
                          data.blockedHostelsCount.toString(),
                          label: 'Blocked Hostels',
                          pending: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BuildStatusCard(
                          icon: Icons.people,
                          value: data.occupantsCount.toString(),
                          label: 'Occupants',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is DashboardError) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No data available'));
      },
    );
  }
}
