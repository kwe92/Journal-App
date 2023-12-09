import 'package:http/http.dart';
import 'package:journal_app/features/authentication/models/user.dart';
import 'package:journal_app/features/authentication/ui/mixins/password_mixin.dart';
import 'package:journal_app/features/shared/services/services.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel with PasswordMixin {
  bool get ready {
    return email != null &&
        email!.isNotEmpty &&
        password != null &&
        password!.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword!.isNotEmpty;
  }

  bool get passwordMatch {
    return password == confirmPassword;
  }

  String? confirmValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "password cannot be empty";
    } else if (value != password) {
      return "passwords do not match";
    } else {
      return null;
    }
  }

  Future<Response> signupWithEmail({required User user}) async {
    setBusy(true);
    final Response response = await authService.register(user: user);
    setBusy(false);
    return response;
  }
}
