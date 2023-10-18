import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_fusion/Constants/app_colors.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(100, (index) => "Item $index");
    return Scaffold(
      backgroundColor: AppColors.colorSecondaryLight,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PIXEL", style: TextStyle(color: AppColors.colorPrimary, fontWeight: FontWeight.bold,fontSize: 24.sp),),
            Text("FUSION",style: TextStyle(fontSize: 24.sp),),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.colorRed, AppColors.colorPink], // Replace with your desired colors
              begin: Alignment.topLeft, // Adjust the alignment as needed
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 50,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset("assets/images/don't_panic.png",
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
