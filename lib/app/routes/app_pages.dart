import 'package:get/get.dart';

import '../modules/ask_leave/bindings/ask_leave_binding.dart';
import '../modules/ask_leave/views/ask_leave_view.dart';
import '../modules/bench/bindings/bench_binding.dart';
import '../modules/bench/bindings/enter_school/enter_school_binding.dart';
import '../modules/bench/bindings/schedule_binding.dart';
import '../modules/bench/views/bench_view.dart';
import '../modules/bench/views/enter_school/enter_school_view.dart';
import '../modules/bench/views/schedule/schedule_view.dart';
import '../modules/campus_mail/bindings/campus_mail_binding.dart';
import '../modules/campus_mail/views/campus_mail_view.dart';
import '../modules/campus_news/bindings/campus_news_binding.dart';
import '../modules/campus_news/views/campus_news_view.dart';
import '../modules/contacts/bindings/contacts_binding.dart';
import '../modules/contacts/views/contacts_view.dart';
import '../modules/health_report/bindings/health_report_binding.dart';
import '../modules/health_report/views/health_report_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/index/bindings/index_binding.dart';
import '../modules/index/views/index_view.dart';
import '../modules/live_class/bindings/live_class_binding.dart';
import '../modules/live_class/views/live_class_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/controllers/search_mess_controller.dart';
import '../modules/message/views/message_view.dart';
import '../modules/message/views/search_mess_view.dart';
import '../modules/micro_disk/bindings/micro_disk_binding.dart';
import '../modules/micro_disk/views/micro_disk_view.dart';
import '../modules/network/bindings/network_binding.dart';
import '../modules/network/views/network_view.dart';
import '../modules/notice/bindings/notice_binding.dart';
import '../modules/notice/views/notice_view.dart';
import '../modules/personal/bindings/personal_binding.dart';
import '../modules/personal/controllers/personal_info_controller.dart';
import '../modules/personal/views/personal_info_view.dart';
import '../modules/personal/views/personal_view.dart';
import '../modules/school_calendar/bindings/school_calendar_binding.dart';
import '../modules/school_calendar/views/school_calendar_view.dart';
import '../modules/survey/bindings/survey_binding.dart';
import '../modules/survey/views/survey_view.dart';
import '../modules/timetable/bindings/timetable_binding.dart';
import '../modules/timetable/views/timetable_view.dart';
import '../modules/wit_classroom/bindings/wit_classroom_binding.dart';
import '../modules/wit_classroom/views/wit_classroom_view.dart';
import 'route_auth_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INDEX;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.MESSAGE,
        page: () => const MessageView(),
        binding: MessageBinding(),
        children: [
          GetPage(
              name: '/search',
              page: () => SearchMessView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => SearchMessController());
              })),
        ]),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BENCH,
      page: () => const BenchView(),
      binding: BenchBinding(),
    ),
    GetPage(
        name: _Paths.INDEX,
        page: () => const IndexView(),
        binding: IndexBinding(),
        middlewares: [RouteAuthMiddleware()]),
    GetPage(
      name: _Paths.CONTACTS,
      page: () => const ContactsView(),
      binding: ContactsBinding(),
    ),
    GetPage(
      name: Routes.EnterSchool,
      page: () => const EnterSchoolView(),
      binding: EnterSchoolBinding(),
    ),
    GetPage(
      name: Routes.Schedule,
      page: () => const SchedulePageView(),
      binding: SchedulePageBinding(),
    ),
    GetPage(
      name: _Paths.HEALTH_REPORT,
      page: () => const HealthReportView(),
      binding: HealthReportBinding(),
    ),
    GetPage(
      name: _Paths.CAMPUS_NEWS,
      page: () => const CampusNewsView(),
      binding: CampusNewsBinding(),
    ),
    GetPage(
      name: _Paths.NOTICE,
      page: () => const NoticeView(),
      binding: NoticeBinding(),
    ),
    GetPage(
      name: _Paths.NETWORK,
      page: () => const NetworkView(),
      binding: NetworkBinding(),
    ),
    GetPage(
      name: _Paths.ASK_LEAVE,
      page: () => const AskLeaveView(),
      binding: AskLeaveBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_CLASS,
      page: () => const LiveClassView(),
      binding: LiveClassBinding(),
    ),
    GetPage(
      name: _Paths.CAMPUS_MAIL,
      page: () => const CampusMailView(),
      binding: CampusMailBinding(),
    ),
    GetPage(
      name: _Paths.WIT_CLASSROOM,
      page: () => const WitClassroomView(),
      binding: WitClassroomBinding(),
    ),
    GetPage(
      name: _Paths.MICRO_DISK,
      page: () => const MicroDiskView(),
      binding: MicroDiskBinding(),
    ),
    GetPage(
      name: _Paths.SCHOOL_CALENDAR,
      page: () => const SchoolCalendarView(),
      binding: SchoolCalendarBinding(),
    ),
    GetPage(
      name: _Paths.TIMETABLE,
      page: () =>  TimetableView(),
      binding: TimetableBinding(),
    ),
    GetPage(
        name: _Paths.PERSONAL,
        page: () => const PersonalView(),
        binding: PersonalBinding(),
        children: [
          GetPage(
              name: '/info',
              page: () => PersonalInfoView(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => PersonalInfoController());
              })),
        ]),
    GetPage(
      name: _Paths.SURVEY,
      page: () => const SurveyView(),
      binding: SurveyBinding(),
    ),
  ];
}
