import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/widgets/custom_bottom_menu_widget.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/enum/today_entry_type.dart';
import 'package:refocus_app/features/create/presentation/bloc/create_bloc.dart';

class AddTimeBlockWidget extends StatefulWidget {
  const AddTimeBlockWidget({Key? key}) : super(key: key);

  @override
  State<AddTimeBlockWidget> createState() => _AddTimeBlockWidgetState();
}

class _AddTimeBlockWidgetState extends State<AddTimeBlockWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateBloc, CreateState>(
      builder: (context, state) {
        final _type = state.todayEntryType ?? TodayEntryType.task;
        return PlatformTextButton(
          child: Text(
            _getItemString(_type),
            style: context.subtitle1.copyWith(
              color:
                  _type == TodayEntryType.task ? kcPrimary200 : kcTertiary300,
            ),
          ),
          onPressed: () async {
            final _result = await showCustomBottomMenu<TodayEntryType>(
              context: context,
              menuOptionBuilder: () => {
                'Timeblock With Title': TodayEntryType.timeblock,
                'Timeblock Without Title': TodayEntryType.timeblockPrivate,
                'Remove Timeblock': TodayEntryType.task,
              },
            );

            if (_result != null) {
              // ignore: use_build_context_synchronously
              context
                  .read<CreateBloc>()
                  .add(CreateEvent.typeEntryChanged(_result));
            }
          },
        );
      },
    );
  }

  String _getItemString(TodayEntryType item) {
    switch (item) {
      case TodayEntryType.timeblock:
        return 'Timeblock Added';
      case TodayEntryType.timeblockPrivate:
        return 'Private Timeblock Added';
      default:
        return 'Create a Timeblock';
    }
  }
}
