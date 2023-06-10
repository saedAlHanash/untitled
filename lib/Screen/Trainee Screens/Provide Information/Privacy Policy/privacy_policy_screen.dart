import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('privacy_policy'.tr, style: TextStyle(color: Colors.white)),
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
//                     'سياسة الخصوصية',
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
// تطبيق فيتنس ستورم ملتزم بحماية بيانات المشتركين والحفاظ على سريتها  وعدم مشاركتها مع الأشخاص الغير مصرح لهم بالإطلاع عليها. توضح  سياسة خصوصية تطبيق فتنس ستورم ما هي البيانات التي نجمعها عنك ، وكيف نجمعها ، وماذا نفعل بها وكيف نحمي هذه المعلومات.
//
// ما هي المعلومات التي نجمعها!
// معلومات نجمعها عنك بشكل مباشر عند التسجيل بالتطبيق:
// ●	الاسم الكامل وعنوان البريد الإلكتروني
// ●	الجنس وتاريخ الميلاد
// ●	هدفك
// ●	طولك ووزنك
// ●	عنوان IP ومعلومات المتصفح
// ●	بطاقة الائتمان / أو تفاصيل الدفع الأخرى
// ●	صورة الملف الشخصي
//   وأي معلومات أخرى ضرورية للاستفادة من خدماتنا.
//
// المعلومات نجمعها بشكل غير مباشر:
// ●	نقوم بجمع معلومات عن استخدامك للتطبيق مثل وقت الدخول والتاريخ، والتمارين التي تم التدرب عليها، والصفحات التي قمت بزيارتها.
// ●	نوع الجهاز / الكمبيوتر ونظام التشغيل
// ●	نوع المتصفح
// ●	الصفحات التي تمت زيارتها وإجراءاتك على التطبيق وسجل المشاهدة واختيارات التمارين.
// ●	معلومات حول اشتراكاتك مثل حالة الاشتراك وتاريخ الشراء والصلاحية والإلغاء
// ●	خصائص الجهاز والبرمجيات
// ●	معلومات عن شبكة الاتصال
// ●	المستعرض ومعلومات سجل خادم الويب
//
// ماذا نفعل بهذه البيانات؟
// نستخدم بياناتك لعرض فيديوهات التمارين أو برامج اللياقة البدنية  التي تناسبك بناءا على نشاطك البدني وهدف اللياقة البدنية الي تطمح للوصول اليه. قد نستخدم أيضًا البريد الالكتروني ورقم الجوال للتواصل معك والاستفسار عن اشتراكك ورأيك بالبرامج التي نقدمها وان كلن لديك اي ملاحظات او افكار لتطوير خدماتنا.
// من ناحية أخرى ولتحسين كفاءة التطبيق؛ قد يتم استخدام بعض البيانات للتحليل الإحصائي والتسويقي ، واختبار الأنظمة ، واستطلاعات الرأي للمشتركين، و وتقديم الخدمات واعرض التنارين التي نعتقد أنها قد تهمك.
// للأستسفار حول استخدامنا لمعلوماتك الشخصية (بما في ذلك الأسس القانونية وآليات النقل التي نعتمد عليها) أو ملفات تعريف الارتباط أو التقنيات المماثلة ، يرجى الاتصال بمسؤول حماية البيانات / مكتب الخصوصية لدينا عبر البريد الإلكتروني المسجل على التطبيق.
//
// هل يتم مشاركة بياناتك مع جهات اخرى؟
// نحن نتبع إجراءات أمنية صارمة في تخزين معلومات المستخدم وعدم الكشف عنها.
// ومع ذلك ، قد نشارك بياناتك الشخصية لأغراض قانونية وأغراض تتعلق بالحماية والأمان وذلك بعد ارسال اخطار مسبق لك. يتضمن ذلك تبادل المعلومات مع الشركات والمؤسسات الأخرى للحماية من الاحتيال وسرقة المعلومات.
// أيضًا ، قد نشارك بياناتك مع خبرائنا لتحسين تجربة المستخدم وكفاءة التطبيق.
//
// قد يتم تغيير أو تحديث سياسات التطبيق والشروط والأحكام من حين لآخر لذلك ، يتم يفضل زيارة هذها القسم بشكل متكرر للإطلاع على أخر التحديثات.
// إذا كان لديك أي استفسارات بشأن الخصوصية، يرجى مراسلتنا على عنوان البريد الاكترونى الموضح على التطبيق.
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
                    'privacy_policy'.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text('privacy_policy_message'.tr,
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
