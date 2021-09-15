import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.height / 3,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class FullScreenLoadingWidget extends StatelessWidget {
  const FullScreenLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
