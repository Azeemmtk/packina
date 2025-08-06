import 'package:flutter/cupertino.dart';
late double height;
late double width;

void getSize(BuildContext context){
  height= MediaQuery.of(context).size.height;
  width= MediaQuery.of(context).size.width;
}

const height20 = SizedBox(height: 20,);
const height10 = SizedBox(height: 10,);
const width20 = SizedBox(width: 20,);
const width10 = SizedBox(width: 10,);
const width5 = SizedBox(width: 5,);
const height5 = SizedBox(height: 5,);
final padding = width * 0.04;

const imagePlaceHolder= 'https://lh3.googleusercontent.com/aida-public/AB6AXuBSfG5TOl4RG5fvOcGZAewnVQFFtnPgLfAJu_lCJp4TAoRSOEmJNsgi723NM7KmZB48BRgjugJpo3hkiSIDfB4nyjX5gaf5A8LkkiDojl5mlWyNAVmF2SEBSNXjaqER6D5WObVHSDqWFbQgNjpr6simyF5VwUt5IEczDBe50J744_qTQmvBz4yn_g0ac-_OP-WzdTe8Ok7GSd919mhUWkLi3PjWtSD609gO5rw_57kj3Hknl5pj8efmvN1zyzrDJWwq_8JR5hHruouE';