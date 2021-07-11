import '../std_lib.dart';

class BoxRegister extends StatefulWidget {
  const BoxRegister({
    Key? key,
    required this.child,
    required this.verticalContainer,
  }) : super(key: key);

  final Widget child;
  final double verticalContainer;

  @override
  _BoxRegisterState createState() => _BoxRegisterState();
}

class _BoxRegisterState extends State<BoxRegister> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: widget.verticalContainer),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black38,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: widget.child));
  }
}
