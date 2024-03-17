import 'package:fitness_storm/core/extensions/extensions.dart';
import 'package:fitness_storm/router/app_router.dart';
import 'package:http/http.dart';

import '../app/app_widget.dart';
import '../util/abstraction.dart';
import '../util/shared_preferences.dart';
import '../util/snack_bar_message.dart';

class ErrorManager {
  static String getApiError(Response response) {
    switch (response.statusCode) {
      case 401:

        AppSharedPreference.logout();
        startLogin();

        return ' المستخدم الحالي لم يسجل الدخول ' '${response.statusCode}';

      case 503:
        return 'حدث تغيير في المخدم رمز الخطأ 503 ' '${response.statusCode}';
      case 481:
        return 'لا يوجد اتصال بالانترنت' '${response.statusCode}';
      case 482:
      // return ctx == null ? S().noInternet : S.of(ctx!).noInternet;

      case 404:
      case 500:
      default:
        final errorBody = ErrorBody.fromJson(response.jsonBodyPure);
        return '${errorBody.message}\n${errorBody.errors.join('\n')}\n ${response.statusCode}';
    }
  }
}

class ErrorBody {
  ErrorBody({
    required this.errors,
    required this.message,
  });

  final List<String> errors;
  final String message;

  factory ErrorBody.fromJson(Map<String, dynamic> json) {
    final item = json["errors"];
    return ErrorBody(
        errors: item == null
            ? []
            : item is Map
                ? [item['message'] ?? item.toString()]
                : List<String>.from(item!.map((x) => x)),
        message: json['message'] ?? '');
  }

  Map<String, dynamic> toJson() => {
        "errors": errors.map((x) => x).toList(),
      };
}

void showErrorFromApi(AbstractCubit state) {
  if (ctx == null) return;
  NoteMessage.showAwesomeError(context: ctx!, message: state.error);
}
