import 'package:flutter/material.dart';
import 'package:projetfinal/components/animated_toggle_button.dart';
import 'package:projetfinal/model/theme_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:projetfinal/noti_service.dart'; // Assurez-vous que ce fichier existe
import 'package:projetfinal/pages/category_expenses.dart';
import 'package:projetfinal/pages/homePage.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool isDarkMode = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ThemeColor lightMode = ThemeColor(
    gradient: [
      const Color.fromARGB(221, 218, 27, 173),
      const Color.fromARGB(221, 212, 18, 176),
    ],
    backgroundColor: const Color(0xFFFFFFFF),
    textColor: const Color(0xFF000000),
    toggleButtonColor: const Color(0xFFFFFFFF),
    toggleBackgroundColor: const Color(0xFFe7e7e8),
    shadow: const [
      BoxShadow(
        color: const Color(0xFFd8d7da),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  ThemeColor darkMode = ThemeColor(
    gradient: [
      const Color(0xFF8983F7),
      const Color(0xFFA3DAFB),
    ],
    backgroundColor: const Color(0xFF26242e),
    textColor: const Color(0xFFFFFFFF),
    toggleButtonColor: const Color(0xFf34323d),
    toggleBackgroundColor: const Color(0xFF222029),
    shadow: const <BoxShadow>[
      BoxShadow(
        color: const Color(0x66000000),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
    ],
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    super.initState();
  }

  changeThemeMode() {
    if (isDarkMode) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      key: _scaffoldKey,
      backgroundColor:
          isDarkMode ? darkMode.backgroundColor : lightMode.backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: width * 0.35,
                    height: width * 0.35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            isDarkMode ? darkMode.gradient : lightMode.gradient,
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(40, 0),
                    child: ScaleTransition(
                      scale: _animationController.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.decelerate),
                        ),
                      ),
                      alignment: Alignment.topRight,
                      child: Container(
                        width: width * 0.26,
                        height: width * 0.26,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? darkMode.backgroundColor
                              : lightMode.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.1),
              Text(
                'Choose a style',
                style: TextStyle(
                  color: isDarkMode ? darkMode.textColor : lightMode.textColor,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                width: width * 0.7,
                child: Text(
                  ' Day or night.',
                  style: TextStyle(
                    color:
                        isDarkMode ? darkMode.textColor : lightMode.textColor,
                    fontSize: width * 0.04,
                    fontFamily: 'Rubik',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.06),

              // Code pour le bouton d'envoi de notification
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    NotifService().showNotification(
                      title: "title",
                      body: "Body",
                    );
                  },
                  child: const Text("Send Notification"),
                ),
              ),

              AnimatedToggle(
                values: ['Light', 'Dark'],
                textColor:
                    isDarkMode ? darkMode.textColor : lightMode.textColor,
                backgroundColor: isDarkMode
                    ? darkMode.toggleBackgroundColor
                    : lightMode.toggleBackgroundColor,
                buttonColor: isDarkMode
                    ? darkMode.toggleButtonColor
                    : lightMode.toggleButtonColor,
                shadows: isDarkMode ? darkMode.shadow : lightMode.shadow,
                onToggleCallback: (index) {
                  isDarkMode = !isDarkMode;
                  setState(() {});
                  changeThemeMode();
                },
              ),
              SizedBox(height: height * 0.05, width: width),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                  buildDot(
                    width: width * 0.055,
                    height: width * 0.022,
                    color: !isDarkMode
                        ? darkMode.backgroundColor
                        : lightMode.backgroundColor,
                  ),
                  buildDot(
                    width: width * 0.022,
                    height: width * 0.022,
                    color: const Color(0xFFd9d9d9),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.025),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: isDarkMode
                              ? const Color(0xFF35303f)
                              : const Color(0xFFFFFFFF),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                        ),
                        onPressed: () {
                          // Ajoutez votre logique ici
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.purple,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 400),
        items: const <Widget>[
          Icon(Icons.bar_chart, size: 30, color: Colors.white),
          Icon(Icons.list, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) =>
                      ExpenseList()), // Assurez-vous que cette classe existe
            );
          } else if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => CategoryExpenses(
                        expenses: [],
                      )), // Assurez-vous que cette classe existe
            );
          }
        },
      ),
    );
  }

  Container buildDot(
      {double width = 15, double height = 15, Color color = Colors.black}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
      ),
    );
  }
}
