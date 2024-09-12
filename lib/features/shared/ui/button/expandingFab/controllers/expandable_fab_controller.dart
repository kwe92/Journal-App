import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExpandableFabController extends TickerProvider with ChangeNotifier {
  final bool? _initialOpen;

  late final AnimationController _animationController;

  late final Animation<double> _expandAnimation;

  bool _open = false;

  AnimationController get animationController => _animationController;

  Animation<double> get expandAnimation => _expandAnimation;

  bool get open => _open;

  ExpandableFabController({bool? initialOpen}) : _initialOpen = initialOpen {
    initialize();
  }

  void initialize() {
    _open = _initialOpen ?? false;

    _animationController = AnimationController(
      vsync: this,
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
    );

    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
    );
  }

  void toggle() {
    _open = !_open;

    _open ? _animationController.forward() : _animationController.reverse();

    notifyListeners();
  }

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
