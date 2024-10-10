import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/ui/memberInfo/member_info_view_model.dart';
import 'package:journal_app/features/shared/services/string_service.dart';

import '../../../../support/test_helpers.dart';

void main() {
  MemberInfoViewModel getModel() => MemberInfoViewModel();

  setUpAll(() async => await registerSharedServices()); // register required depenencies);
  group('MemberInfoViewModel - ', () {
    test('when model initialized, temp user is created, mindful image, first name, last mame, phone number, and email are not null',
        () async {
      // Arrange - Setup
      getAndRegisterImageServiceMock();

      final model = getModel();

      // Act

      await model.initialize();

      // Assert - Result
      var actual = model.mindfulImage != null;

      var expected = true;

      expect(actual, expected);

      actual = model.firstName != null && model.firstName!.isEmpty;

      expect(actual, expected);

      actual = model.lastName != null && model.lastName!.isEmpty;

      expect(actual, expected);

      actual = model.phoneNumber != null && model.phoneNumber!.isEmpty;

      expect(actual, expected);

      actual = model.email != null && model.email!.isEmpty;

      expect(actual, expected);
    });

    test('when model initialized and set state methods called, first name, last mame, phone number, and email are not null nor empty',
        () async {
      // Arrange - Setup
      getAndRegisterImageServiceMock();

      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act

      await model.initialize();

      model.setFirstName('Shunryu');

      model.setLastName('Suzuki');

      model.setPhoneNumber('+11234567890');

      model.setEmail('beginnersMind@soto.io');

      // Assert - Result
      var actual = model.ready;

      var expected = true;

      expect(actual, expected);
    });

    test('when setObscure called with false argument, obscurePassword returns false', () {
      // Arrange - Setup

      final model = getModel();

      // Act

      model.setObscure(false);

      // Assert - Result

      var actual = model.obscurePassword;

      var expected = false;

      expect(actual, expected);
    });

    test('when checkAvailableEmail called, response returns status ok', () async {
      // Arrange - Setup

      const email = 'beginnersMind@soto.io';

      getAndRegisterAuthServiceMock(availableEmail: email);

      final model = getModel();

      // Act

      final result = await model.checkAvailableEmail(email: email);

      // Assert - Result
      var actual = result;

      var expected = true;

      expect(actual, expected);
    });
  });
}
