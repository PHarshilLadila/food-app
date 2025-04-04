import 'package:hive/hive.dart';

Future<void> populateTranslations() async {
  var box = Hive.box('translations');

  await box.put('app_title', {
    'en': 'Food App',
    'es': 'Aplicación de Comida',
    'he': 'אפליקציית אוכל',
  });

  await box.put('welcome_message', {
    'en': 'Welcome to our Food App!',
    'es': '¡Bienvenido a nuestra aplicación de comida!',
    'he': 'ברוכים הבאים לאפליקציית האוכל שלנו!',
  });
}
