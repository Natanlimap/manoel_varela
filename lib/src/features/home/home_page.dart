import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manoel_varela/constant/colors.dart';
import 'package:manoel_varela/constant/texts.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/entities/user_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserEntity userEntity = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text("Bom dia,", style: titleh2),
                Text(userEntity.name, style: titleh1),
                const SizedBox(height: 32),
                Text("Suas reservas", style: actionLabel),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("Churrasqueira", style: secondaryTitle),
                    subtitle: Text("27/08/2023", style: textBody),
                    trailing: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text("Reservas", style: actionLabel),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed('/booking',
                          arguments: BookType.churrasqueira);
                    },
                    title: Text(
                      'Churrasqueira',
                      style: actionText,
                    ),
                    subtitle: Text(
                      'Reservar a churrasqueira',
                      style: actionSubtitleText,
                    ),
                    leading: Icon(
                      FontAwesomeIcons.utensils,
                      color: primaryColor,
                      size: 24,
                    ),
                    trailing: Icon(
                      FontAwesomeIcons.arrowRightLong,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.toNamed('/booking', arguments: BookType.salao);
                    },
                    title: Text(
                      'Salão de festas',
                      style: actionText,
                    ),
                    subtitle: Text(
                      'Reservar o salão de festas',
                      style: actionSubtitleText,
                    ),
                    leading: Icon(
                      FontAwesomeIcons.buildingFlag,
                      color: primaryColor,
                      size: 24,
                    ),
                    trailing: Icon(
                      FontAwesomeIcons.arrowRightLong,
                      color: primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text("Avisos", style: actionLabel),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      'Administração do condomínio',
                      style: actionText,
                    ),
                    subtitle: Text(
                      'Por razões técnicas, a piscina encontra-se temporariamente interditada. Pedimos desculpas pelo incômodo e estamos trabalhando para solucionar o problema o mais rápido possível. Agradecemos a compreensão de todos!',
                      style: actionSubtitleText,
                    ),
                    leading: Icon(
                      FontAwesomeIcons.message,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
