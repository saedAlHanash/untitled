import '../../generated/l10n.dart';

enum EmailType { password, confirm }

enum AttachmentType { image, youtube, video, d3 }

enum PricingMatrixType { day, date }

enum UserType { user, trainer, guest }

enum FilterItem { activity, group, country, city }

enum UpdateType { name, phone, email, address, pass }

enum BalanceType { day, week, month, year }

enum OrderStatus { pending, accepted, shipped, delivered, canceled }

enum DeviceStatus { pending, accepted, reject, notFound }

enum StartPage { login, home, otp }

enum ProfileCardType { profile, fav, payment, lang, appointment, files, diets }

enum ProfileButtonType { about, privacy, faq, terms }

enum PrivetSessionState { noEver, active, waiting, needBooking }

enum WalletType { income, invoice }

enum NeedUpdateEnum { no, withLoading, noLoading }

enum ThemeColor { dark, light }

enum MediaType { pdf, image }

enum FontManager { regular, semeBold, bold }

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
        return 'Advanced';
      case TrainingLevelEnum.intermediate:
        return 'Intermediate';
      case TrainingLevelEnum.beginner:
        return 'Beginner';
    }
  }

  String get name {
    switch (this) {
      case TrainingLevelEnum.advanced:
        return S().advanced;
      case TrainingLevelEnum.intermediate:
        return S().intermediate;
      case TrainingLevelEnum.beginner:
        return S().beginner;
    }
  }
}

enum TrainingLocationType {
  home,
  gym;

  String get name {
    switch (this) {
      case TrainingLocationType.home:
        return S().home;
      case TrainingLocationType.gym:
        return S().gym;
    }
  }

  String get nameRequest {
    switch (this) {
      case TrainingLocationType.home:
        return 'Home';
      case TrainingLocationType.gym:
        return 'Gym';
    }
  }
}

enum SortTypes {
  aToz,
  zToa,
  mostPopular,
  playDaysMoreFirst,
  playDaysLessFirst;

  String get name {
    switch (this) {
      case SortTypes.aToz:
        return S().alphabeticalAZ;
      case SortTypes.zToa:
        return S().alphabeticalZA;
      case SortTypes.mostPopular:
        return S().mostPopular;
      case SortTypes.playDaysMoreFirst:
        return S().playingDays_moreFirst;
      case SortTypes.playDaysLessFirst:
        return S().playingDays_lessFirst;
    }
  }

  String get nameRequest {
    switch (this) {
      case SortTypes.aToz:
        return 'aToz';
      case SortTypes.zToa:
        return 'zToa';
      case SortTypes.mostPopular:
        return '';
      case SortTypes.playDaysMoreFirst:
        return 'play_days_more_first';
      case SortTypes.playDaysLessFirst:
        return 'play_days_less_first';
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

enum SubscriptionType {
  day,
  month,
  year;

  String get getName {
    switch (this) {
      case SubscriptionType.day:
        return S().days;
      case SubscriptionType.month:
        return S().months;
      case SubscriptionType.year:
        return S().years;
    }
  }

  static SubscriptionType byName(String name) {
    if (name == 'day') return SubscriptionType.day;
    if (name == 'month') return SubscriptionType.month;
    return SubscriptionType.year;
  }
}
