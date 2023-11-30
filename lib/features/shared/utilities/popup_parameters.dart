// TODO: Create a generic popup menu parameter utility class

class PopupMenuParameters<T> {
  /// the title of a popup menu.
  final String title;

  /// the content body of a popup menu.
  final String? content;

  /// required in case the user does not select an option and exits the modal.
  final T defaultResult;

  /// for every key/value pair in options each key/value will be mapped
  /// to a button as the button text and popup menu return value respectively.
  final Map<String, T> options;

  const PopupMenuParameters({
    required this.title,
    this.content,
    required this.defaultResult,
    required this.options,
  });
}
