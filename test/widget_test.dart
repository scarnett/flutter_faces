import 'package:flutter_faces/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App should be created', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}
