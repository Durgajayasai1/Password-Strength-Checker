import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Pwd extends StatefulWidget {
  const Pwd({super.key});

  @override
  State<Pwd> createState() => PwdState();
}

class PwdState extends State<Pwd> {
  TextEditingController _pwdController = TextEditingController();
  bool _isObsecured = true;
  double _strength = 0.0;

  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _hasDigits = false;
  bool _hasSpecialChars = false;
  bool _hasMinLength = false;

  void _checkPassword(String password) {
    setState(() {
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
      _hasDigits = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChars = password.contains(RegExp(r'[@#!]'));
      _hasMinLength = password.length >= 10;

      // Calculate strength based on met criteria
      int criteriaMet = [
        _hasUppercase,
        _hasLowercase,
        _hasDigits,
        _hasSpecialChars,
        _hasMinLength,
      ].where((criteria) => criteria).length;

      _strength = criteriaMet / 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            title: Text(
              "Password Creation",
              style: GoogleFonts.poppins(
                  color: Colors.grey[300], fontWeight: FontWeight.w600),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Create Password",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please create a strong password that meets the specified criteria.",
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    style: GoogleFonts.poppins(color: Colors.greenAccent),
                    controller: _pwdController,
                    obscureText: _isObsecured,
                    onChanged: _checkPassword,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecured = !_isObsecured;
                              });
                            },
                            icon: Icon(
                              _isObsecured ? Iconsax.eye_slash : Iconsax.eye,
                              color: Colors.greenAccent,
                            )),
                        hintText: 'Create password',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.greenAccent))),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(10),
                    value: _strength,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(_strength < 0.3
                        ? Colors.red
                        : _strength < 0.7
                            ? Colors.pink
                            : Colors.green),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildCriteriaRow("At least 10 characters", _hasMinLength),
                const SizedBox(
                  height: 10,
                ),
                _buildCriteriaRow("Contains Uppercase", _hasUppercase),
                const SizedBox(
                  height: 10,
                ),
                _buildCriteriaRow("Contains Lowercase", _hasLowercase),
                const SizedBox(
                  height: 10,
                ),
                _buildCriteriaRow("Contains at least 1 number", _hasDigits),
                const SizedBox(
                  height: 10,
                ),
                _buildCriteriaRow("Contains Symbols (!@#)", _hasSpecialChars),
              ],
            ),
            const SizedBox(height: 230,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  "CREATE PASSWORD",
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCriteriaRow(String criteria, bool met) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        Icon(
          Iconsax.tick_circle,
          color: met ? Colors.green : Colors.grey,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          criteria,
          style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 18),
        ),
      ],
    ),
  );
}
