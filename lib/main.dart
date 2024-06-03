import 'package:flutter/material.dart';
import './ui/phone/app.dart';
import './shared/global_objects.dart';

// The part of core shared things like the database whose child is the app.
class CoreState extends StatelessWidget{
  const CoreState({super.key});

  @override
  Widget build(BuildContext context){
    return SharedDatabase(child: const MobileApp());
  }
}

// The logic to choose the proper UI and the core shared data.
// So far only the mobile UI works.
void main() {
  runApp(const CoreState());
}