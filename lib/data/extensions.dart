import 'person.dart';

extension ResponsibilityExtension on Responsibility {
  String toNameString() {
    return this.name.replaceAll('_', " ");
  }
}
