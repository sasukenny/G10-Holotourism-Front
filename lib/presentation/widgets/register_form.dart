import '../../presentation/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../resources/Registro.dart';
import '../pages/login_page.dart';
import 'input_text.dart';
import 'login_form.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final registro = Registro();
  GlobalKey<FormState> _formkey = GlobalKey();
  String _email = "",
      _password = "",
      _password2 = "",
      _nombre = "",
      _phone = "",
      _apellido = "";

  _submit() {
    final isOk = _formkey.currentState?.validate();
    print("form isOk $isOk");
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final registro = Registro();

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 430 : 360,
        ),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Nombre",
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _nombre = text;
                },
                validator: (text) {
                  if (text != null && text.trim().length < 2) {
                    return "Nombre invalido.";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Apellido",
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _apellido = text;
                },
                validator: (text) {
                  if (text != null && text.trim().length < 2) {
                    return "Apellido invalido.";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Direcci??n de Email",
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _email = text;
                },
                validator: (text) {
                  if (text != null && !text.contains("@")) {
                    return "invalid email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Tel??fono M??vil",
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _phone = text;
                },
                validator: (text) {
                  if (text != null && text.trim().length < 9) {
                    return "Tel??fono M??vil incorrecto";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Contrase??a",
                obscureText: true,
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _password = text;
                },
                validator: (text) {
                  if (text != null && text.trim().length < 8) {
                    return "Contrase??a inv??lida";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.2),
              ),
              InputText(
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                label: "Repita la contrace??a",
                fondSize: responsive.dp(responsive.isTablet ? 1.3 : 1.5),
                onChanged: (text) {
                  _password2 = text;
                },
                validator: (text) {
                  if (text != _password) {
                    return "Las contrase??a no coinciden";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: responsive.dp(1.5),
              ),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      "Registrarse",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      registro.registrar(
                          _nombre, _apellido, _phone, _email, _password);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Color.fromRGBO(220, 219, 211, 1.0),
                      primary: Colors.black,
                    ),
                  )),
              SizedBox(
                height: responsive.dp(2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "??Tienes una cuenta?",
                      style: TextStyle(
                        fontSize: responsive.dp(1.55),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      child: Text(
                        "Ingresa aqu??",
                      ),
                      style: TextButton.styleFrom(
                        primary: Color(0xFF00ac83),
                        textStyle: TextStyle(
                          fontSize: responsive.dp(1.55),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: responsive.dp(5.5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
