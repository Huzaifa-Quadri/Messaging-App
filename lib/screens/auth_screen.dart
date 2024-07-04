import 'package:flutter/material.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({super.key});

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final _form = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  var _email_id = '';
  var _password = '';

  void _onpressedsave(){
    if(_form.currentState!.validate()){
      _form.currentState!.save();
      print(_email_id);
      print(_password);
    }
  }

  var _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chaticon.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
              
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [                                                  
                          TextFormField(                                                                           //!  Email Textfield                                                      
                            decoration: const InputDecoration(
                              labelText: 'Email Address'
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if(value == null || value.trim().isEmpty || !value.contains('@')){
                                return 'Enter a valid e-mail Address';
                              }
                              return null;
                            },
                            onSaved: (value) => _email_id = value.toString(),
                          ),
                          TextFormField(                                                                                //!   Password Textfield
                            decoration: const InputDecoration(
                              labelText: 'Password'
                            ),
                            obscureText: true,
                            validator: (value) {
                            if(value == null || value.trim().length < 6 ){
                                return 'Enter a valid Password';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value.toString(),
                          ),
                          const SizedBox(height: 16,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer),
                            onPressed: _onpressedsave, 
                            child: Text(_isLogin ? 'Login' : "Sign Up"),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              setState(() {
                                _isLogin = !_isLogin; //* if _islogin == true => it will yeild false & if _islogin == false => it will yeild true
                              });
                            }, 
                            child: Text(_isLogin ? "Create an Account or Login" : 'I already have an account.'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}