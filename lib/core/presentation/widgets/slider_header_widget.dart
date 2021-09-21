import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/task/presentation/bloc/project_bloc.dart';
import 'package:refocus_app/features/task/presentation/bloc/task_bloc.dart';
import 'package:refocus_app/injection.dart';

class SlidingHeaderWidget extends StatefulWidget {
  const SlidingHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SlidingHeaderWidgetState createState() => _SlidingHeaderWidgetState();
}

class _SlidingHeaderWidgetState extends State<SlidingHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 16,
        right: 24,
        left: 24,
      ),
      height: 72,
      child: [
        const Icon(
          Icons.calendar_today,
          color: kcSecondary100,
          size: 24,
        ).gestures(onTap: () {}),
        [
          Text(
            'All',
            style: context.textTheme.bodyText2!.copyWith(
              color: kcSecondary100,
              decoration: TextDecoration.underline,
            ),
          ),
          horizontalSpaceMedium,
          Text(
            'Personal',
            style: context.textTheme.bodyText2!.copyWith(
              color: kcSecondary100,
            ),
          ),
          horizontalSpaceMedium,
        ].toRow(),
        const Icon(
          Icons.add,
          color: kcSecondary100,
          size: 33,
        ).gestures(
          onTap: () => getx.Get.to<dynamic>(
            () => MultiBlocProvider(
              providers: [
                BlocProvider<ProjectBloc>.value(
                  value: BlocProvider.of<ProjectBloc>(context),
                ),
                BlocProvider<TaskBloc>.value(
                  value: BlocProvider.of<TaskBloc>(context),
                ),
              ],
              child: const QuickAddPage(),
            ),
            fullscreenDialog: true,
            transition: getx.Transition.fade,
          ),
        ),
      ].toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
