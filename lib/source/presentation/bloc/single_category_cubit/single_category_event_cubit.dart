import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit.dart';

part 'single_category_event_state.dart';

class SingleCategoryEventCubit extends Cubit<SingleCategoryEventState> {
  final GetEventsDataFromRemote _getEventsData;

  SingleCategoryEventCubit({required getEventsData})
      : _getEventsData = getEventsData,
        super(SingleCategoryEventInitial());

  void getData(categoryId) async {
    emit(const SingleCategoryLoadingState());

    // filter "WSZYSTKO" sets categiryID to 0 to prevent that I used condition with "1"
    final eventEitherResponse =
        await _getEventsData.call(categoryId == 0 ? 1 : categoryId);
    eventEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
      },
      (eventsDataList) {
        if (categoryId != null) {
          // removes clasifications and other non-match event
          eventsDataList.eventData
              .removeWhere((element) => element.eventType! != 1);
          eventsDataList.eventData.sort(
            (a, b) => a.category3Id.compareTo(b.category3Id),
          );
          emit(
            SingleCategoryEventsLoadedState(
              eventsDataList: eventsDataList,
              categoryId: categoryId,
            ),
          );
        }
      },
    );
  }

  void resetCubitState() => emit(SingleCategoryEventInitial());
}
