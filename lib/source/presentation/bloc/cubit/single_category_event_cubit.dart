import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';

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
