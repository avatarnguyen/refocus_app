import 'dart:async';

import 'package:flutter/material.dart';
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
    required this.changePage,
  }) : super(key: key);

  final VoidCallback changePage;

  @override
  _SlidingHeaderWidgetState createState() => _SlidingHeaderWidgetState();
}

class _SlidingHeaderWidgetState extends State<SlidingHeaderWidget> {
  final PageStream _pageStream = getIt<PageStream>();
  late StreamSubscription<int> _pageSubscription;

  int _currentPage = 1;

  @override
  void initState() {
    _pageSubscription = _pageStream.pageStream.listen(_pageIndexReceived);
    super.initState();
  }

  void _pageIndexReceived(int currentPage) {
    setState(() {
      _currentPage = currentPage;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageSubscription.cancel();
  }

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
        Icon(
          _currentPage == 0 ? Icons.list : Icons.calendar_today,
          color: kcSecondary100,
          size: 24,
        ).gestures(onTap: () {
          widget.changePage();
        }),
        [
          const Icon(
            Icons.arrow_left,
            size: 32,
            color: kcSecondary100,
          ),
          horizontalSpaceMedium,
          SizedBox(
            height: 32,
            width: 56,
            child: CustomPaint(painter: LinePainter()),
          ),
          horizontalSpaceMedium,
          const Icon(
            Icons.arrow_right,
            size: 32,
            color: kcSecondary100,
          ),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
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
            // isScrollControlled: true,
            // isDismissible: false,
            // elevation: 8,
            // enterBottomSheetDuration: 200.milliseconds,
            // exitBottomSheetDuration: 150.milliseconds,
            // backgroundColor: Colors.black54,
          ),
        ),
      ].toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = kcSecondary100
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    var startingPoint = Offset(0, size.height / 2);
    var endingPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
