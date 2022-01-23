part of 'menu_button.dart';

class MenuController {
  late _MenuButtonState? _state;

  MenuController();

  void _setView(_MenuButtonState view) {
    _state = view;
  }

  void dispose() {
    _state = null;
  }

  void closeMenu() {
    try {
      if (_state!._controller.isCompleted &&
          _state!._iconController.isCompleted) {
        _state!._controller.reverse();
        _state!._iconController.reverse();
      }
    } catch (_) {}
  }

  void openMenu() {
    try {
      if (_state!._controller.isDismissed &&
          _state!._iconController.isCompleted) {
        _state!._controller.forward();
        _state!._iconController.forward();
      }
    } catch (_) {}
  }
}
