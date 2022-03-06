import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:practica_flutter/done_settings.dart';
import 'package:practica_flutter/done_settings_state.dart';

class ToDoDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsHeader(),
          DoneHeader(),
          DoneOptionsWidget(
            model: DoneSettings.shared,
          ),
        ],
      ),
    );
  }
}

class SettingsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Row(
        children: const [
          Icon(
            Icons.settings,
            size: 64,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Settings",
            style: TextStyle(fontSize: 42, color: Colors.white),
          ),
        ],
      ),
      decoration: const BoxDecoration(
          color: Colors.pink,
          image: DecorationImage(
              image: AssetImage("assets/LiquidBG.jpeg"), fit: BoxFit.cover)),
    );
  }
}

class DoneHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: const [
          Icon(
            Icons.done,
            size: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "What to do with 'done' tasks?",
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}

// class DoneOptions extends StatefulWidget {
//   @override
//   State<DoneOptions> createState() => _DoneOptionsState();
// }

// class _DoneOptionsState extends State<DoneOptions> {
//   final _flags = [
//     true,
//     false,
//     false,
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: ToggleButtons(
//         children: [
//           _button("Nothing"),
//           _button("GreyOut"),
//           _button("Delete", destructive: true),
//         ],
//         isSelected: _flags,
//         direction: Axis.vertical,
//         onPressed: _tapHandler,
//       ),
//     );
//   }

//   void _tapHandler(int index) {
//     if (_flags[index] == false) {
//       _setFlag(index, true);
//     } else {
//       _setFlag(index, false);
//     }
//     setState(() {});
//   }

//   void _setFlag(int position, bool newValue, {int defaultPosition = 0}) {
//     if (newValue == true) {
//       _turnAllOff();

//       _flags[position] = newValue;
//     } else {
//       _flags[position] = newValue;

//       _flags[defaultPosition] = true;
//     }
//   }

//   void _turnAllOff() {
//     for (int i = 0; i < _flags.length; i++) {
//       _flags[i] = false;
//     }
//   }

//   Widget _button(String caption, {bool destructive = false}) {
//     if (!destructive) {
//       return Text(caption);
//     } else {
//       return Row(
//         children: [
//           const Icon(
//             Icons.dangerous,
//             size: 15,
//             color: Colors.red,
//           ),
//           Text(caption)
//         ],
//         mainAxisAlignment: MainAxisAlignment.center,
//       );
//     }
//   }
// }
