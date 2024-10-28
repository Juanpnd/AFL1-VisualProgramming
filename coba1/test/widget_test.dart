import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:coba1/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Buat dummy service atau mock object jika perlu
    final mockUserService =
        MockUserService(); // Sesuaikan ini dengan service yang benar

    // Bangun aplikasi dan trigger frame.
    await tester.pumpWidget(MyApp(
      userService: mockUserService, // Isi dengan instance service yang benar
    ));

    // Verifikasi bahwa counter dimulai dari 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap ikon '+' dan trigger frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifikasi bahwa counter telah bertambah.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

class MockUserService {
  // Definisikan fungsi atau properti yang dibutuhkan jika userService memerlukan mock.
}
