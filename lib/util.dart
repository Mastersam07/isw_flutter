import 'enums.dart';

String nameOf(Environment env) {
  final name = env.toString();
  return name.substring(name.indexOf('.') + 1);
}
