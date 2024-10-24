import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/features/today/domain/today_entry.dart';

part 'tomorrow_event.dart';
part 'tomorrow_state.dart';

@injectable
class TomorrowBloc extends Bloc<TomorrowEvent, TomorrowState> {
  TomorrowBloc() : super(TomorrowLoading()) {
    on<TomorrowEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
