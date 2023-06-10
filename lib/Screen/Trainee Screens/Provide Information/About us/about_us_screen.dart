import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('about_us'.tr, style: TextStyle(color: Colors.white)),
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
//                 padding: const EdgeInsets.only(right: 15.0),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'من نحن',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.only(right: 15.0),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     'ابدأ صفحة جديدة في حياتك، ارتق بنفسك وأحب حياتك أكثر بحصولك على الجسم الذي تحلم/تحلمين به مع فيتنس ستورم!',
//                     textAlign: TextAlign.justify,
//                     textDirection: TextDirection.rtl,
//                     maxLines: 10,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                 child: Text('''
//
// عاصفة اللياقة (فيتنس ستورم) منصة الكترونية صحية ورياضية تهدف لخلق أشخاص سعداء وأصحاء يتمتعون بلياقة بدنية عالية ووزن مثالي طالما حلموا بامتلاكه.
//
// سواء كان هدفك زيادة الكتلة العضلية، إنقاص الوزن أو المحافظة على لياقة الجسم، مع فيتنس ستورم بإمكانك ممارسة التمارين الرياضية المفضلة لديك برفقة أفضل المدربين العالميين في اي مكان وزمان من خلال فيديوهات عالية الجودة مصورة بأسلوب شيق.
//
// لضمان تحقيق هدفك، نوفر لك جميع أنواع التمارين الرياضية التي تستهدف كافة عضلات الجسم وبما يتناسب مع مستوى اللياقة لديك، وبناءا على معلوماتك الشخصية التي تقم بإدخالها عند تسجيلك مع فيتنس ستورم يتم تزويدك بعدة خطط تدريبية مع أفضل المدربين لتقم بدورك اختيار الخطة او التمارين التي ترغب بممارستها، وتبدأ فورا ممارستها مع المدرب خطوة بخطوة لتحصل على جسم منحوت وعضلات أقوى مع نهاية الخطة.
//
// ولأننا نسعى لتقديم أفضل خدمة لك على الإطلاق، وفرنا حصص تدريبية خاصة أو (one to one session ) مع المدرب حيث بإمكانك اختيار التدرب مع مدرب خاص يحفزك على ممارسة التمارين الملائمة لك والتي سيتجيب لها عضلات جسمك بفعالية أكثر وبشكل أسرع.
//
// كما يمكنك ايضا الإشتراك مع أخصائى التغذية للحصول على جدول التغذية المناسب لصحتك ولجسمك للوصول الى هدفك بسهولة
//
// من خلال تطبيقنا ستجد كل الدعم والتحفيز والتشجيع التي تحتاجه لتصبح أكثر قوة وجمالاَ وثقة بنفسك! فقط خصص وقت لنفسك واشترك بأحد باقاتنا لمدة 3 أشهر أو 6 أشهر أو 12 شهر.
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
                    'about_us'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('fitness_storm_message'.tr,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.ltr,
                    maxLines: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
