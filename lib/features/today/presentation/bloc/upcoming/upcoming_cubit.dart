import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';

part 'upcoming_state.dart';

@injectable
class UpcomingCubit extends Cubit<UpcomingState> {
  UpcomingCubit() : super(const UpcomingLoading());
}
