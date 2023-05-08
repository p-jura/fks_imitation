import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';

part 'single_category_event_state.dart';

class SingleCategoryEventCubit extends Cubit<SingleCategoryEventState> {
  final GetEventsDataFromRemote _getEventsData;

  SingleCategoryEventCubit({required getEventsData})
      : _getEventsData = getEventsData,
        super(SingleCategoryEventInitial());

  void getData(categoryId) async {
    emit(const SingleCategoryLoadingState());
    final eventEitherResponse = await _getEventsData.call(categoryId);
    eventEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
      },
      (eventsDataList) {
        if (categoryId != null) {
          // removes clasifications and other non-match event
          eventsDataList.eventData
              .removeWhere((element) => element.eventType! != 1);

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
