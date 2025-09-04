import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/core/constants/colors.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/get_hostel_data.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/screens/hostel_detail_screen.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../widgets/custom_my_hostel_card.dart';

class HostelScreen extends StatelessWidget {
  HostelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBarWidget(
            title: 'My Hostels',
          ),
          height20,
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                context.read<HostelBloc>().add(FetchHostelsData());
                return Future.delayed(const Duration(seconds: 1));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: BlocBuilder<HostelBloc, HostelState>(
                  builder: (context, state) {
                    if (state is HostelLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: mainColor,
                        ),
                      );
                    } else if (state is HostelLoaded) {
                      if (state.hostels.isEmpty) {
                        return Center(child: Text('Hostels not available'));
                      }

                      return LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount;
                          if (constraints.maxWidth > 1200) {
                            crossAxisCount = 4;
                          } else if (constraints.maxWidth > 800) {
                            crossAxisCount = 3;
                          } else if (constraints.maxWidth > 500) {
                            crossAxisCount = 2;
                          } else {
                            crossAxisCount = 1;
                          }

                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                            ),
                            itemCount: state.hostels.length,
                            itemBuilder: (context, index) {
                              final hostel = state.hostels[index];
                              return InkWell(
                                onTap: () {
                                  print('width================$screenWidth');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HostelDetailScreen(hostel: hostel),
                                    ),
                                  );
                                },
                                child: CustomMyHostelCard(
                                  imageUrl: hostel.mainImageUrl ?? imagePlaceHolder,
                                  title: hostel.name,
                                  location: hostel.placeName,
                                  rent: hostel.rooms[0]['rate'],
                                  rating: hostel.rating ?? 0.0,
                                  distance: 0,
                                  status: hostel.status,
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is HostelError) {
                      return Center(child: Text(state.message));
                    }
                    return const Center(child: Text('No hostels available'));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
