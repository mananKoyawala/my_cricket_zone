import 'package:flutter/material.dart';
import 'package:interview/utils/common/loader.dart';

class DismissLoader extends StatelessWidget {
  const DismissLoader({
    super.key,
    required this.child,
    this.onBack = _emptyCallback,
    this.canPop,
  });
  final Widget child;
  final VoidCallback onBack;
  final bool? canPop;

  static void _emptyCallback() {}
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop ?? true,
      onPopInvokedWithResult: (didPop, result) {
        AppLoader.dismissLoader();
        onBack();
      },
      child: child,
    );
  }
}
