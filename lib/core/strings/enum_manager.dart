import '../../generated/l10n.dart';


enum EmailType { password, confirm}

enum AttachmentType { image, youtube, video, d3 }

enum PricingMatrixType { day, date }

enum UserType { user, trainer, guest }

enum FilterItem { activity, group, country, city }

enum UpdateType { name, phone, email, address, pass }

enum BalanceType { day, week, month, year }

enum OrderStatus { pending, accepted, shipped, delivered, canceled }

enum DeviceStatus { pending, accepted, reject, notFound }

enum StartPage { login, home, otp }

enum FontFamily { roboto, robotoSimBold, robotoBold }

enum ProfileCardType { profile, fav, payment, lang, appointment, files, diets }

enum ProfileButtonType { about, privacy, faq, terms }

enum PrivetSessionState { noEver, active, waiting, needBooking }

enum WalletType { income, invoice }

enum NeedUpdateEnum { no, withLoading, noLoading }

enum ThemeColor { dark, light }

enum MediaType { pdf, image }

enum TrainingTypeEnum {
  weightlifting,
  hIITTraining,
  strengthTraining,
  functionalTraining,
  mobilityTraining,
  sportsTraining,
  dynamicTraining,
  bodyBuilding,
  prenatalTraining,
  handsFree;

  String get nameRequest {
    switch (this) {
      case TrainingTypeEnum.weightlifting:
        return 'Weightlifting';
      case TrainingTypeEnum.hIITTraining:
        return 'HIIT training';
      case TrainingTypeEnum.strengthTraining:
        return 'Strength training';
      case TrainingTypeEnum.functionalTraining:
        return 'Functional training';
      case TrainingTypeEnum.mobilityTraining:
        return 'Mobility training';
      case TrainingTypeEnum.sportsTraining:
        return 'Sports training';
      case TrainingTypeEnum.dynamicTraining:
        return 'Dynamic training';
      case TrainingTypeEnum.bodyBuilding:
        return 'Body building';
      case TrainingTypeEnum.prenatalTraining:
        return 'Prenatal training';
      case TrainingTypeEnum.handsFree:
        return 'Hands-free';
    }
  }

  String get name {
    switch (this) {
      case TrainingTypeEnum.weightlifting:
        return S().weightlifting;
      case TrainingTypeEnum.hIITTraining:
        return S().hiitTraining;
      case TrainingTypeEnum.strengthTraining:
        return S().strengthTraining;
      case TrainingTypeEnum.functionalTraining:
        return S().functionalTraining;
      case TrainingTypeEnum.mobilityTraining:
        return S().mobilityTraining;
      case TrainingTypeEnum.sportsTraining:
        return S().sportsTraining;
      case TrainingTypeEnum.dynamicTraining:
        return S().dynamicTraining;
      case TrainingTypeEnum.bodyBuilding:
        return S().bodyBuilding;
      case TrainingTypeEnum.prenatalTraining:
        return S().prenatalTraining;
      case TrainingTypeEnum.handsFree:
        return S().handsfree;
    }
  }
}

enum TrainingLevelEnum {
  advanced,
  intermediate,
  beginner;

  String get nameRequest {
    switch (this) {
      case TrainingLevelEnum.advanced:
        return S().advanced;
      case TrainingLevelEnum.intermediate:
        return S().intermediate;
      case TrainingLevelEnum.beginner:
        return S().beginner;
    }
  }

  String get name {
    switch (this) {
      case TrainingLevelEnum.advanced:
        return 'Advanced';
      case TrainingLevelEnum.intermediate:
        return 'Intermediate';
      case TrainingLevelEnum.beginner:
        return 'Beginner';
    }
  }
}

enum TrainingLocationTypeEnum {
  home,
  gym;

  String get nameRequest {
    switch (this) {
      case TrainingLocationTypeEnum.home:
        return S().home;
      case TrainingLocationTypeEnum.gym:
        return S().gym;
    }
  }

  String get name {
    switch (this) {
      case TrainingLocationTypeEnum.home:
        return 'home';
      case TrainingLocationTypeEnum.gym:
        return 'gym';
    }
  }
}

enum ApiType {
  get,
  post,
  put,
  patch,
  delete,
}
