
part of 'seatmap_cubit.dart';


abstract class SeatmapState {}

class SeatmapInitial extends SeatmapState {}

class SeatmapLoading extends SeatmapState {}

class SeatmapLoaded extends SeatmapState {
  final Map<String, dynamic> seatmapData;

  SeatmapLoaded(this.seatmapData);
}

class SeatmapError extends SeatmapState {
  final String message;

  SeatmapError(this.message);
}
