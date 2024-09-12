import 'package:get_it/get_it.dart';

import 'call_message_mail_location_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}