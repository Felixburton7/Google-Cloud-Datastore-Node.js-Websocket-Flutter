import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController nameController;
  final String hintText;

  const TextFieldWidget(
      {super.key, required this.nameController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(labelText: 'Enter name'),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// class Authfield extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;
//   final bool isObscureText;

//   const Authfield(
//       {super.key,
//       required this.hintText,
//       required this.controller,
//       this.isObscureText = false});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       // controller s a defined property of TextFormField, that takes an instance of TextEditingController, which is a specail class designed to manage, read and amanipulate the text being edited in a text field. (has .text, .value, .clear, .addLister, .removeLister(). )
//       controller: controller,
//       decoration: InputDecoration(
//         // Makes sense to take this from the constructor as we want a new hintText each time
//         hintText: hintText,
//       ),
//       // Takes in a value and as a result validates the whole TextFormField
//       validator: (value) {
//         if (value!.isEmpty) {
//           return '$hintText is missing';
//         }
//         return null;
//       },
//       obscureText: isObscureText,
//       // obscuringCharacter: String,
//     );
//   }
// }
