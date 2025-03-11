import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todos/features/auth/presentation/widgets/auth_button.dart';
import 'package:todos/features/auth/presentation/widgets/auth_field.dart';
import 'package:todos/main.dart' as app;
import 'package:todos/features/auth/presentation/pages/signin_page.dart';
import 'package:todos/features/blog/presentation/pages/blog_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Signin Page Integration Tests', () {
    testWidgets('Successful user sign-in flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      expect(find.byType(SigninPage), findsOneWidget);

      await tester.enterText(find.byType(AuthField).at(0), 'tester@gmail.com');
      await tester.enterText(find.byType(AuthField).at(1), '12345test');
      await tester.pump();

      await tester.tap(find.byType(AuthButton));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(BlogPage), findsOneWidget);
    });
  });
}
