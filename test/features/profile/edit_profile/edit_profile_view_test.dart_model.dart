import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/profile/edit_profile/edit_profile_view.dart_model.dart';
import 'package:journal_app/features/shared/services/string_service.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  EditProfileViewModel getModel() => EditProfileViewModel();

  group('EditProfileViewModel - ', () {
    setUpAll(() async => await registerSharedServices());

    test(
        'when model created and initialize called, then mindfulImage, userFirstName, userLastName, userEmail, an userPhoneNumber are not null nor empty',
        () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);
      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.initialize();

      // Assert - Result

      var actual = model.mindfulImage != null;
      var expected = true;

      expect(actual, expected);

      actual =
          model.userFirstName.isNotEmpty && model.userLastName.isNotEmpty && model.userEmail.isNotEmpty && model.userPhoneNumber.isNotEmpty;

      expect(actual, expected);
    });

    test('when model created and initialize called, then all TextEditingController().text not null nor empty', () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);
      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.initialize();

      // Assert - Result

      var actual = model.firstNameController.text.isNotEmpty &&
          model.lastNameController.text.isNotEmpty &&
          model.emailController.text.isNotEmpty &&
          model.phoneNumberController.text.isNotEmpty;

      var expected = true;

      expect(actual, expected);
    });

    test('when model created and initialize called followed by a call to clearControllers, then all TextEditingController().text are empty',
        () {
      // Arrange - Setup
      getAndRegisterUserServiceMock(testCurrentUser);
      getAndRegisterService<ImageService>(ImageService());
      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.initialize();
      model.clearControllers();

      // Assert - Result

      var actual = model.firstNameController.text.isEmpty &&
          model.lastNameController.text.isEmpty &&
          model.emailController.text.isEmpty &&
          model.phoneNumberController.text.isEmpty;

      var expected = true;

      expect(actual, expected);
    });

    test('when model created and setReadOnly(false) called, then all readOnly property is false', () {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.setReadOnly(true);

      // Assert - Result

      var actual = model.readOnly;

      var expected = true;

      expect(actual, expected);
    });

    test(
        'when model created and updatedFirstName, updatedLastName, updatedEmail, updatedPhoneNumber are set and ready getter called, the ready returns true',
        () {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.setFirstName(testCurrentUser.firstName!);
      model.setLastName(testCurrentUser.lastName!);
      model.setEmail(testCurrentUser.email!);
      model.setPhoneNumber(testCurrentUser.phoneNumber!);

      // Assert - Result

      var actual = model.ready;

      var expected = true;

      expect(actual, expected);
    });

    test('when model created and user info has not changed, then isIdenticalInfo returns true', () {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());
      getAndRegisterUserServiceMock(testCurrentUser);

      final model = getModel();

      // Act

      model.initialize();

      // Assert - Result

      var actual = model.isIdenticalInfo;

      var expected = true;

      expect(actual, expected);
    });

    test(
        'when model created, updatedFirstName, updatedLastName, updatedEmail, updatedPhoneNumber are set and updateUserInfo called, returns true',
        () async {
      // Arrange - Setup

      getAndRegisterService<StringService>(StringService());

      final model = getModel();

      // Act
      model.setFirstName(testCurrentUser.firstName!);
      model.setLastName(testCurrentUser.lastName!);
      model.setEmail(testCurrentUser.email!);
      model.setPhoneNumber(testCurrentUser.phoneNumber!.substring(2));

      final result = await model.updateUserInfo();

      // Assert - Result

      var actual = result;

      var expected = true;

      expect(actual, expected);
    });
  });
}
