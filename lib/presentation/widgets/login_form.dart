import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../presentation/initialhome.dart';
import '../../presentation/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../blocs/lugarbloc/lugarbloc_bloc.dart';
import 'input_text.dart';
import '../../presentation/pages/home.dart';
import '/resources/Registro.dart';

class LoginForm extends StatefulWidget{
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  final registro = Registro();
  GlobalKey<FormState> _formkey = GlobalKey();
  String _email = "", _password = "";

  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  String _alertaText = '';
  bool _esEmail(String str)
  {
    return _emailRegExp.hasMatch(str.toLowerCase());
  }


  @override
  Widget build (BuildContext context){

    final Responsive responsive = Responsive.of(context);

    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: responsive.isTablet?430 : 360,
        ),
        child: Form(
          key: _formkey,
          child: Column (
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "Dirección de Email",
                fondSize: responsive.dp(responsive.isTablet?1.3 : 1.5),
                onChanged: (text){
                  _email = text;
                },
                validator: (text){
                  if(text != null && !_esEmail(text.toString())){
                    return "Email incorrecto";
                  }
                  return null;
                },
              ),
              SizedBox(height: responsive.dp(2.5),),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        label: "Contraseña",
                        obscureText: true,
                        borderEnabled: false,
                        fondSize: responsive.dp(responsive.isTablet?1.3 : 1.5),
                        onChanged: (text){
                          _password = text;
                        },
                        validator: (text){
                          if(text != null && text.trim().length == 0){
                            return "Contraseña inválida";
                          }
                          return null;
                        },
                      ),
                    ),

                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        "¿Olvidó la contraseña?",
                        style: TextStyle(fontWeight:
                          FontWeight.bold,
                          fontSize: responsive.dp(responsive.isTablet?1.3 : 1.5),
                        ),
                      ),
                      onPressed: (){},
                    ),
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5),),
              SizedBox(
                width: double.infinity,
                child: BotonIngresar(responsive),
              ),
              SizedBox(height: responsive.dp(2),),
              Text(
                _alertaText,
                style: TextStyle(color: Colors.redAccent),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "¿Viajero nuevo?",
                    style: TextStyle(
                      fontSize: responsive.dp(1.55),
                    ),
                  ),
                  TextButton(
                    child: Text("Regístrate",),
                    style: TextButton.styleFrom(
                      primary: Color(0xFF00ac83),
                    textStyle: TextStyle(fontSize: responsive.dp(1.55),),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, "register");
                    },
                  ),
                ],
              ),
              SizedBox(height: responsive.dp(7),)
            ],
          ),
        ),
      ),
    );
  }

  Widget BotonIngresar(responsive){
    return TextButton(
      child: Text(
        'Ingresar',
        style: TextStyle(
            color: Colors.black,
            fontSize: responsive.dp(1.5),
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Color.fromRGBO(220, 219, 211, 1.0),
        primary: Colors.black,
      ),
      onPressed: () async
      {
        if (_formkey.currentState!.validate())
        {
          var textodeprueba = await registro.ingresar(_email, _password);
          debugPrint(textodeprueba);
          if (textodeprueba != 'a') {
            context.read<LugarblocBloc>().add(LoadLugarTuristicos(token: textodeprueba));
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InitialHomePage(token: textodeprueba)),
            );
          } else {
            setState((){
              _alertaText = 'Usuario o contraseña incorrecto';
            });
          }
        } else {

        }
      },
    );
  }
}

// onPressed: this._submit,