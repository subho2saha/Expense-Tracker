import 'package:gsheets/gsheets.dart';
import 'package:flutter/material.dart';

import 'start_pro.dart';

class GooglesheetApi_sign {
   static const _credentialssign = r'''
{
  "type": "service_account",
  "project_id": "flutter-sign-in-350805",
  "private_key_id": "f53cef4f2f2d81bacecfba3189a6be290c93c098",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCEGKVyZSUjdCH7\nLwMN4qDg+Z02YrxuZ4SHZ+lZk9sbm+l1BLbECILZ5H8wgfAhLPs1xnQ0j6AdtydW\ncjIQMdL/6nd5lSnFTh6Bylo+N6HUs5KBSOh4YJXbzqUvSVMIp01sbxhTfoSKnyIt\nnQ76bqoNchjyWBgNO9yB/REsUiy+lyeSlPokh6u4g3CF4cShSO15JZbHeyt8cKsi\nIFhr4N9EfpzIS9dLZ1fxoNbUju3osMo2BN5C/iKRH6owKwUUWdQ2pfdXTk44tCer\nQDC4fbIun1rM51CXMDyHiWOXpp+LzeR7CLwewds+CBGeHDpxyLpF/4Prv8k201Tt\n719HeTWpAgMBAAECggEAOpRPcm6GTLWoiCKuAQ9adspbPI4GsBM6A25CXlYiWZkH\nq7webMq1dHlPKizFV4ECGjPavqBeyi65xC06JFJkFtdcik9qybO99aLN6D91hcTo\nmGrDpPZ4HpUCTfj/WJwQyqBtskEt9+dgGchHpylCQlox0+7bI6tDO2YFopkCfLYa\nWbS1b6qE7fLpL0gfvJqaBhb3WmNCqugOnMYSdfuc0keiLC3v1xsrycqE/eCU+tQ7\n27gXgsoTHDCPYX/N84SjxkeX5fgB3H0vONMmmEuXKFbK28alBLbXe6rgPuR3/U3Q\nJrD1cd5chZ6p5a/AhQskqRlrYG4A5pbbP7LihA/MHQKBgQC6c7ruZOTbY9gnU5xx\nyMl7PbVjfgf+ZxcOVMxp/MQA+ZtNSJPy25DYvmqkyBXJwjVNwTd13s/hJ1n8W+A4\nmYbVOOa+1GAMv8h4Y3mAKyv8AhPFWRFd7xrEYlYascQwr96OSLuapv3DkBRJhUV1\nP72mk0SBmZuQgnlwVe/xAl5W+wKBgQC1Xn4F03SU8KaJeE3XWoZzxH9z4o2Q1C3C\nbKhrg3fsSkRv9a4dYhQ392iOKfw61ldZC/SxAl3ScSXTuQLCX6dbPijwLiiziZO3\nnPNYRRIVjXKMZrTrAfduRn48k7aGIg+Lkj3xmq80R9xWeUbmafiZc81e2J3jxKhg\nrqtnsMSUqwKBgHEQDrHTMsgq8n9ef0asaCk4kU7ktPo7D0scdtxqb3zb36XstfKV\n3G7igQ6tWjD/eI1O9k+erlYtI68ZE42e45lWqO3dIOV6QplmUN48z65AoDaSvSpF\n/OhLbUVAuOSBMSb8ye6NBuLY8sRmcWkZHurs8KTaPfBSfkt1gUuXkReTAoGAEWP6\nGXzpFM7uaQgMDrYzZi5VOjti75wotxfMHmMAwLtuTH32MAMThTpH4DnOYaXjwjoP\nQFnFvUP0KJT42sJpPap8KmuCo5RxgY2fF7unvEFP1n6SomYR35UKzawsODhT3UIs\nhloaqpypV/FRBw7qM2yTKKEEoq5cpsiYztx4PPkCgYAgJEk/M02kIH8dJFmcye5o\nPJZJzCvSyz5On0q1Ftvu0qRx5hta0Q+rWf0Ol3GdYZXxANO8H/27FhhkiuWC+lVl\nkdmNXGU75LPh6Aplu87DOmHea7FUJaVMTRGGcz4xBTJ5Uf4YWG+r09qsCIKJXP0D\nnxie9Li1CNr0u4x2MzvV/g==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-sign-in@flutter-sign-in-350805.iam.gserviceaccount.com",
  "client_id": "107483938135209370122",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-sign-in%40flutter-sign-in-350805.iam.gserviceaccount.com"
}''';

static final _spreadsheetIdsign = '1F29OGlxdLiaOgZBJeATsDYAVCLDu8pHm6onAnO_jOjA';
static final _gsheetssign = GSheets(_credentialssign);
static Worksheet? _worksheetsign;
static bool loading = true;

static int numberOfTransactions = 0;
static List<List<dynamic>> currentTransactions = [];


 Future init() async {
    final ss = await _gsheetssign.spreadsheet(_spreadsheetIdsign);
    _worksheetsign = ss.worksheetByTitle('worksheet_sign-in');
    
  }
  

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheetsign!.values.value(column: 1, row: numberOfTransactions + 1)) !='') {
      numberOfTransactions++;
    }
  }

   // insert a new transaction step-3
  static Future insert(String username, String password, ) async {
    if (_worksheetsign == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      username,
      password,
    ]);
    await _worksheetsign!.values.appendRow([
      username,
      password,
    ]);
  }

 // search a transation step-3
  static Future search(
    String username_from_login, String password_from_login )  async {
    while ((await _worksheetsign!.values.value(column: 1, row: numberOfTransactions + 1)) !='') {
      numberOfTransactions++;
    }
    if (_worksheetsign == null) return;
    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionuserName = await _worksheetsign!.values.value(column: 1, row: i + 1);
       if (transactionuserName == username_from_login )
       {
         final String transactionpass = await _worksheetsign!.values.value(column: 2, row: i + 1);
         if(password_from_login == transactionpass)
         {
           return("successfull");
         }
         else{
           return("incorrect password given");
         }
       }
       else {
       return("user not exist");
       }
    }
    loading = false;
  }
}