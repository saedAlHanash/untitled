import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('FAQs'.tr, style: TextStyle(color: Colors.white)),
        backgroundColor: Get.theme.primaryColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Get.theme.primaryColor,
              Get.theme.colorScheme.secondary,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: Get.width / 8,
                  left: Get.width / 8,
                  top: 20,
                  bottom: 20,
                ),
                child: Image.asset(
                  "asset/Images/white_logo.png",
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(right: 10.0),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'أسئلة مكررة',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: Text('''
//
// -	ما هو تطبيق فيتنس ستورم؟
// فيتنس ستورم منصة الكترونية عربية ومتوفر باللغة الانجليزية تمكن المشتركين من التدرب مع اهم المدربين الرياضيين العالميين من خلال سلسلة فيديوهات مصورة عالية الجودة .
//
// -	هل يمكنني التواصل مع المدرب مباشرة ؟
// نعم من خلال خاصية الشات داخل التطبيق يمكنك التواصل مع المدرب و ايضا حجز حصص تدريب خاصة مع المدرب.
//
// هل بإمكاني الإشتراك من خارج السعودية؟
// نعم يمكنك ذلك، جميع برامجنا متوفرة أونلاين ولا تتطلب وجودك في بلد معين.
//
// -	ما الباقات المتوفرة للاشتراك؟
// نوفر 3 باقات أساسية:
// ✔	برنامج لمدة 3 اشهر
// ✔	برنامج لمدة 6 أشهر
// ✔	برنامج لمدة 12 شهر
// ✔	برنامج تدريبي مع مدرب خاص / أخصائى تغذية   (one to one session)
//
// -	هل هنالك برامج للمبتدئين ؟
// نعم، بناءا على معلوماتك الشخصية التي تزودنا بها عند اشتراكك ، يتم عرض  فيديوهات  التمارين الرياضية التي تتناسب مع مستوى اللياقة لديك. إذ نوفر برامج لكافة المستويات من المبتدئين ولغاية المحترفين.
//
// -	هل بإمكان الإناث الإشتراك ؟
// نعم ، كلا الجنسين بإمكانهم الإشتراك ذكوراً واناثاً.
//
// -	ما أقل عمر مسموح له بالإشتراك؟
// 18 عاماَ
//
// -	هل بإمكاني الإطلاع على برامجكم قبل الإشتراك؟
// قبل عملية الاشتراك والدفع، بإمكانك الإستمتاع والإستفادة من برامجنا مجانا لمدة 7 أيام.
//
// -	كيف بإمكاني الدفع والاشتراك ؟
// بإمكانك الدفع لأحد باقات الإشتراك أونلاين عن طريق وسائل الدفع المتاحة على التطبيق.
//
// -	هل الفيديوهات باللغة العربية؟
// نعم باللغة العربية وقد يتم استخدام بعض المصطلحات باللغة الانجليزية.
//
//                      ''',
//                     style: TextStyle(color: Colors.white),
//                     textAlign: TextAlign.justify,
//                     textDirection: TextDirection.rtl,
//                     maxLines: 100),
//               ),
//               SizedBox(height: 10),
//               Divider(color: Colors.white),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FAQs'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuestionAndAnswer(
                          question: '-	' + 'What_is_Fitness_Storm?'.tr,
                          answer: '\n' +
                              'It_is_a_dynamic_application_in_both_Arabic'.tr +
                              '\n'),
                      QuestionAndAnswer(
                          question:
                              '-	' + 'Can I contact the coach directly?'.tr,
                          answer: '\n' +
                              'No, this option is not available yet.'.tr +
                              '\n'),
                      QuestionAndAnswer(
                          question: '-	' +
                              'Can_I_Subscribe_if_I_live_outside_Saudi_Arabia?'
                                  .tr,
                          answer: '\n' +
                              'Sure_you_can_subscribe_from_anywhere_in_the_globe'
                                  .tr +
                              '\n'),
                      QuestionAndAnswer(
                          question: '-	' +
                              '-What_plans_do_you_offer_to_subscribe?'.tr,
                          answer: '\n' + 'We_offer_3_basic_plans'.tr + '\n'),
                      QuestionAndAnswer(
                          question:
                              '-	' + 'Are_there_exercises_for_beginners?'.tr,
                          answer: '\n' +
                              'Yes_sure_Based_on_your_personal'.tr +
                              '\n'),
                      QuestionAndAnswer(
                          question: '-	' +
                              'Can_females_get_benefit_from_your_services?'.tr,
                          answer: '\n' + 'Yes_they_can'.tr + '\n'),
                      QuestionAndAnswer(
                          question: '-	' +
                              'Can_I_try_your_programs_before_subscribing?'.tr,
                          answer: '\n' +
                              'Yes,_sure_there_is_7_days_free_trial'.tr +
                              '\n'),
                      QuestionAndAnswer(
                          question: '-	' + 'How_can_I_subscribe_and_pay?'.tr,
                          answer: '\n' + 'You_can_subscribe_and_pay'.tr + '\n'),
                      QuestionAndAnswer(
                          question: '-	' +
                              '_What_language_is_spoken_in_the_videos?'.tr,
                          answer: '\n' +
                              'Arabic_and_some_expressions_inEnglish'.tr +
                              '\n'),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionAndAnswer extends StatelessWidget {
  const QuestionAndAnswer(
      {Key? key, required this.answer, required this.question})
      : super(key: key);

  final String answer;
  final String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            answer,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
          ),
        )
      ],
    );
  }
}
