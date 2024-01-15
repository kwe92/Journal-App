import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/ui/signUp/ui/signup_view_model.dart';
import 'package:journal_app/features/shared/services/string_service.dart';
import 'package:journal_app/features/shared/services/toast_service.dart';

import '../../../../../support/test_data.dart';
import '../../../../../support/test_helpers.dart';

void main() {
  SignUpViewModel getModel() => SignUpViewModel();
  group('SignUpViewModel - ', () {
    setUpAll(() async {
      await registerSharedServices();
    });
  });

  test('when model created and initialized, then mindfulImage and email properties are not null', () {
    // Arrange - Setup

    getAndRegisterImageServiceMock();

    var model = getModel();

    // Act

    model.initialize();

    // Assert - Result

    var actual = model.mindfulImage != null;

    var expected = true;

    expect(actual, expected);

    actual = model.email != null;

    expected = true;

    expect(actual, expected);
  });

  test('when model created and passwords are the same, then passwordMatch method returns true', () {
    // Arrange - Setup

    var model = getModel();

    // Act

    const password = 'begin';

    model.setPassword(password);

    model.setConfirmPassword(password);

    // Assert - Result

    var actual = model.passwordMatch;

    var expected = true;

    expect(actual, expected);
  });

  test('when model created and email, password, and confirmPassword are set, then the ready property returns true', () {
    // Arrange - Setup

    var model = getModel();

    // Act

    const password = 'begin';

    model.setEmail('donotbedidvided@standstrong.io');

    model.setPassword(password);

    model.setConfirmPassword(password);

    // Assert - Result

    var actual = model.ready;

    var expected = true;

    expect(actual, expected);
  });

  test('when model created and password criteria meet, then the passwordCriteriaSatisfied method returns true', () {
    // Arrange - Setup

    var model = getModel();

    // Act

    getAndRegisterService<StringService>(StringService());

    const password = 'ThisShouldWork11!!';

    model.setPassword(password);

    // Assert - Result

    var actual = model.passwordCriteriaSatisfied;

    var expected = true;

    expect(actual, expected);
  });

  test('when model created and signupWithEmail called, then the signupWithEmail method returns true', () async {
    // Arrange - Setup

    var model = getModel();

    // Act

    getAndRegisterService<StringService>(StringService());
    getAndRegisterService<ToastService>(ToastService());
    getAndRegisterAuthServiceMock(user: testCurrentUser);

    // Assert - Result

    var actual = await model.signupWithEmail(user: testCurrentUser);

    var expected = true;

    expect(actual, expected);
  });
}
