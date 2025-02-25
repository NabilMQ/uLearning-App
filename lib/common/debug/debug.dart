import 'dart:convert';

import 'package:flutter/material.dart';

void debug(dynamic text) {
  try {
    debugPrint("""
    ================== Debug Message ==================
    
    
    ${JsonEncoder.withIndent('      ').convert(JsonDecoder().convert(text))}


    ======================= End =======================
    """);
  }
  catch (_) {
    try {
      debugPrint("""
      ================== Debug Message ==================
      
      
      ${JsonEncoder.withIndent('      ').convert(text)}


      ======================= End =======================
      """);
    }
    catch (_) {
      debugPrint("""
      ================== Debug Message ==================
      
      
      ${text.toString()}


      ======================= End =======================
      """);
    }
  }
}