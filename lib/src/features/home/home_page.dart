import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/constant/colors.dart';
import 'package:manoel_varela/constant/texts.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/services/user_controller.dart';
import 'package:manoel_varela/src/features/booking/booking_controller.dart';
import 'package:manoel_varela/utils/date_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController userController = Get.find();
  BookingController bookingController = Get.find();
  @override
  void initState() {
    userController.getUserInfo();
    bookingController.getAllBooks();
    super.initState();
  }

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
                Row(
                  children: [
                    Text("Bom dia,", style: titleh2),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: Icon(Icons.logout),
                    )
                  ],
                ),
                ValueListenableBuilder(
                    valueListenable: userController.user,
                    builder: (context, value, _) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${value.name}', style: titleh1),
                          if (value.books.isNotEmpty) ...[
                            const SizedBox(height: 32),
                            Text("Suas reservas", style: actionLabel),
                            const SizedBox(height: 16),
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: value.books.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Cancelar reserva",
                                              textAlign: TextAlign.center,
                                              style: titleh2,
                                            ),
                                            content: Text(
                                              "Deseja cancelar o agendamento do(a) ${value.books[index].type.name} no dia ${value.books[index].dateTime.dayMonthYear}?",
                                              textAlign: TextAlign.center,
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  setState(() {});
                                                },
                                                child: const Text(
                                                  "Cancelar",
                                                  style: TextStyle(
                                                    color: primaryColor,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll(
                                                            primaryColor)),
                                                onPressed: () {
                                                  bookingController
                                                      .cancelBooking(value
                                                          .books[index].bookId);
                                                  userController.getUserInfo();
                                                  bookingController
                                                      .getAllBooks();

                                                  Get.back();
                                                  setState(() {});
                                                },
                                                child: const Text("Confirmar"),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(value.books[index].type.name,
                                          style: secondaryTitle),
                                      if (value.name == 'admin') ...[
                                        Text(value.books[index].name,
                                            style: secondaryTitle),
                                      ]
                                    ],
                                  ),
                                  subtitle: Text(
                                      value.books[index].dateTime.dayMonthYear,
                                      style: textBody),
                                  trailing: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    }),
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
