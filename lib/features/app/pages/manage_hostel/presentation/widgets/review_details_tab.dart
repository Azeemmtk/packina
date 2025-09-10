import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../../domain/entity/hostel_entity.dart';
import '../provider/bloc/review/review_bloc.dart';
import 'hostel_details/review_container.dart';

class ReviewDetailsTab extends StatelessWidget {
  const ReviewDetailsTab({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
      child: Builder(
        builder: (blocContext) => BlocConsumer<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state is ReviewAdded) {
              // Refresh reviews after adding a new one
              blocContext.read<ReviewBloc>().add(FetchReviews(hostel.id));
            }
          },
          builder: (context, state) {
            print('Current ReviewBloc state: $state'); // Debugging
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height20,
                const TitleTextWidget(title: 'Review and rating'),
                height10,
                if (state is ReviewLoading)
                  const Center(child: CircularProgressIndicator())
                else if (state is ReviewLoaded)
                  state.reviews.isNotEmpty
                      ? Column(
                    children: state.reviews
                        .map((review) => ReviewContainer(review: review))
                        .toList(),
                  )
                      : const Center(child: Text('No reviews yet'))
                else if (state is ReviewError)
                    Center(child: Text('Error: ${state.message}'))
                  else
                    const Center(child: Text('No reviews yet')),
                height20,
              ],
            );
          },
        ),
      ),
    );
  }
}