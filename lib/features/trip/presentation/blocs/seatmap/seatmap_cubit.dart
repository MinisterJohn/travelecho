import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../trip_exports.dart';
part 'seatmap_state.dart';

class SeatmapCubit extends Cubit<SeatmapState> {
  final GetSeatmapUseCase _getSeatmapUseCase = sl<GetSeatmapUseCase>();

  SeatmapCubit() : super(SeatmapInitial());

  Future<void> getSeatmap(dynamic flightOffer) async {
    try {
      emit(SeatmapLoading());
      final seatmapData = await _getSeatmapUseCase(flightOffer);
      emit(SeatmapLoaded(seatmapData));
    } catch (e) {
      emit(SeatmapError(e.toString()));
    }
  }
}
