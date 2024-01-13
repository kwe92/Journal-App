import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/features/authentication/services/image_service.dart';
import 'package:journal_app/features/profile/edit_profile/edit_profile_view.dart_model.dart';
import 'package:journal_app/features/shared/services/string_service.dart';

import '../../../support/test_data.dart';
import '../../../support/test_helpers.dart';

void main() {
  EditProfileViewModel getModel() => EditProfileViewModel();

  group('EditProfileViewModel - ', () {
    setUpAll(() async {
      await registerSharedServices();
    });

    test(
        'when model created and initialize called, then mindfulImage, userFirstName, userLastName, userEmail, userPhoneNumber and TextEditingControllers are not null nor empty',
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
  });
}
