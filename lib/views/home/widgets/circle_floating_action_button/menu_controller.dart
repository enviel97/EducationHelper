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

  Future<void> closeMenu() async {
    try {
      await _state!._closeMenu();
    } catch (_) {
      debugPrint('[MenuController] $_');
    }
  }

  Future<void> openMenu() async {
    try {
      await _state!._openMenu();
    } catch (_) {
      debugPrint('[MenuController] $_');
    }
  }
}
