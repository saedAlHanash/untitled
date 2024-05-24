import 'package:fitness_storm/core/app/app_provider.dart';

class GetUrl {
  static const getHome = 'home';
  static const availableTimesTrainer = 'availableTimes';

  //--------------

  static const getAllCourses = 'courses';

  static const getAllLessons = 'lessons';

  static const getAllLessonsFree = 'lessons/free';

  static const getAllSeasons = 'seasons';

  static const getAllSummaries = 'summaries';

  static const getCourseProgress = 'courses/progress-user';
  static const getMe = 'auth/me';

  static const getAllNotifications = 'notifications';

  static const getSocialMedia = 'social-media';

  static const privacyPolicy = 'privacy-policy';

  static const getAnnouncements = 'announcements';

  static const favorite = 'favorites';

  static const productById = 'products';
  static const products = 'products';
  static const search = 'products/search';

  static const offers = 'products/offers';
  static const bestSeller = 'products/best-seller';
  static const setting = 'settings';

  static const orders = 'orders';

  static const categoryById = 'category';
  static const subCategoryById = 'subCategory';

  static const coupon = 'carts/redeem-coupon';

  static const flashDeals = 'products/flash-deals';

  static const categories = 'categories';
  static const banners = 'ads/banners';
  static const slider = 'ads/sliders';

  static const colors = 'colors';

  static const manufacturers = 'manufacturers';

  static const newArrivalProducts = 'products/new-arrivals';

  static const cart = 'carts';

  static const profile = 'profile';

  static const orderById = 'orders';

  static const subCategories = 'categories/sub';

  static const governors = 'governors';

  static const orderStatus = 'orders/statues';

  static const driverLocation = 'orders/coordinate';

  static const getMessages = 'drivers/messages';

  static const getSupportMessages = 'conversations';

  static const getRoomMessages = 'messages';

  static const faq = 'questions';

  static const termsAndConditions = 'pages';

  static const bookedAppointments = 'bookedAppointments';

  static const getTrainer = 'trainers';

  static const temp = '';

  static const bundles = 'bundles';

  static const wallet = 'wallet';

  static var bookmarked = 'plans/bookmarked';

  static String plans(int id) => 'trainers/$id/plans';

  static String availableTimes(int id) => 'trainers/$id/availableTimes';
}

class PostUrl {
  static const loginUrl = 'auth/login';

  static const signup = 'auth/register';

  static const forgetPassword = 'auth/resetPassword';

  static const survey = 'fitness-survey';

  static const resetPasswordCheckCode = 'auth/resetPassword/checkCode';

  static const closeVideo = 'lessons/close-video';

  static const insertFireBaseToken = 'auth/me/update-fcm-token';
  static const uploadFile = 'media';

  static const insertCode = 'courses/insert-code';
  static const logout = 'auth/logout';

  static const confirmCode = 'auth/confirmAccount';
  static const otpPassword = 'password/check';

  static const loginSocial = 'auth/social_login';

  static const resetPassword = 'auth/resetPassword/changePassword';

  static const createBundle = 'bundles/join';

  static const createSession = 'bookedAppointments';

  static const refreshToken = 'auth/refreshToken';

  static const addTime = 'availableTimes';

  static const rate = 'bookedAppointments/rate';

  static String addFavorite(int id) => 'plans/$id/addToBookmarkedPlans';

  static const restPass = 'reset-password';

  static const createOrder = 'checkout/cash';
  static const createEPaymentOrder = 'checkout/credit';

  static const resendCode = 'auth/resendConfirmationCode';

  static const addToCart = 'carts';

  static const updateProfile = 'profile';

  static const addSupportMessage = 'messages/add';
  static const apply = 'api/application-request';
  static const insertFcmToken = 'notifications/storeFcmToken';

  static String addMessage(int id) {
    return 'drivers/messages/$id/add';
  }

  static String increase(int id) {
    return 'carts/products/$id/quantity/increase';
  }

  static String decrease(int id) {
    return 'carts/products/$id/quantity/decrease';
  }
}

class PutUrl {
  static const updateName = 'update-name';
  static const updatePhone = 'update-phone';
  static const updateAddress = 'update-address';
}

class DeleteUrl {
  static var removeTime = 'availableTimes';

  static String removeFavorite(int id) => 'plans/$id/deleteFromBookmarkedPlans';

  static const removeFromCart = 'carts/products';

  static const clearCart = 'carts';
}

class PatchUrl {}

const additionalConstTrainer = 'mobile/trainer/';
const additionalConstUser = 'mobile/user/';

const baseUrl = 'api.fitnessstorm.org';

String get additionalConst =>
    AppProvider.isTrainer ? additionalConstTrainer : additionalConstUser;

