import 'package:gsheets/gsheets.dart';

class GooglesheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "new-flutter-project-350415",
  "private_key_id": "e3bc3ff8ed4e15d001d19436dea0efceb413a08a",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC+Ru4k7RSouBIf\n/YeJVbl8Lvb3oA2BHlr3wA9Bvk9KdvFfZ8RjfBD38WThncUxOvRTtueVutUNVmP4\nUXgYWyeYmRgzNHI/+JdW7AGDT2BQhwtEkP8LSs51wDpBvaFhQYSKUN7dXEZVzyAL\nKdw3CdM2zMeOUxOmluvoDJMgQZ/8V8bsKSWUsi0oed8NxQ1i5nhSZBfO0MQBRbT0\n0/LQ39SoDy2Ozolp6K5yMb4IOmGH64vPdNAsNhxqxcyzN0TCXt0byfa/5nxuc77Z\nAO+4fxWmeVWyykI42Q+Vg9W8vFpkcQJp8JEidgojEbUszZxmPLwHahBDUpM7Kmzx\nPGpF/5+hAgMBAAECggEABzirbJjX1iBoRbEKTg7EE5+3rUW0hYA4rRrrqU/W9AlI\nF1oZlLn+bd6KONrTQ09Muwmfx+m3kMJE2IWFBI2fFtZGmhjlNiLR4ZFi7FAcpGm/\npnpHR68u3z6sp1aSU53YMSSpFKceHz8VZP8RdcBIdRW4BCGIhyPGr7+cbNa4wuuk\nJrlbvrrHVi5H+bcxQFUlG5e/3xtGeIOJKQgqcLz8tAiUBJR8w6m9X2ZrUy85lLs9\nZMTAmdaMOArMmdJ4PrppvD2xGNEzLs4OPyL5qZl0WQ9VNZvPXRWIug1wq0xJt7x0\nw2E0y6ySuVxgHqI1p4fQCh9hU9lXe/K5xBLzzk5rcQKBgQDfxtQIWG1np2VVDJsD\n7RMj849cwW1k7p+aMvMNid+NcmIgwXoj14oqXV4zHXhL46smLmVdJdHVeM1w2Gnu\n3mPNtRgCJpkpBn1HMbo3Svn1QGuEg+lwj0YJApb12EDBdSrGGiyOdRTwRpBi0Snr\nnoO7SkLZNInoKT9hWZRObHH06QKBgQDZrTE/gBf+Cjcu1tGt5+2vOon1mwyZA/s7\nMow3jMqpCaWH/KYcBDQonkClR+ZqWnJ1A/td3VXI2ljWEMdpENBgNQQA2JIAoNR4\nnIYDoewo6gldFv9j+ycg3MG56hi8hLqrYmyILuXpDlYYYnM1gLvM5amTGbpaZgMO\nZFoUDWeB+QKBgDER5X7q/Rqkr2jF+dwTiYXxq7c4RyfB18e1cmy+lgHrWi86nfDs\nG8UMclKdHLrvcqFNvTZ+y5OXCN285wXVSGdcVaZrFlzTqncJJX9odoVcGfeWAYOI\nN2BUbAv+3rxNWBLWvHyEmhHSN2kj2qBrQxG3yA7fIXqCSP6s6QOFbju5AoGAaGVW\ntDSzzQOLOayPPU95P8vcdG1bGlu9dsOkWdPtMirNN63k4JTniv9y05HrIOCl+hbh\nzD+lr8GAT5IWgP4uYaWreNhlFWYM4Jd48m8K+whbW0j3TTUbq/gT9R0fpfImMKHw\nmVOcsixNAD7fMC7AYuFWdZUmOcqo9pMMXIedN8kCgYEAtUK7X7EoPk1MI+5HmeNs\njpyLu3gierC+kYVqxtQsi41AAaxjnj8wtoYobPY0fERH8Cz0jlvDahZIgs9RYa3U\naLoRw1VXAenKTjwh0lL0TJLTxzaX0ZiPB/BIQofNWZ92nKkIjBiGeSgHfHFwM++K\nyQly6IAGyRwYQrDKAegdXRg=\n-----END PRIVATE KEY-----\n",
  "client_email": "new-flutter-gsheet@new-flutter-project-350415.iam.gserviceaccount.com",
  "client_id": "109997175415541675351",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/new-flutter-gsheet%40new-flutter-project-350415.iam.gserviceaccount.com"
}
''';

  static final _spreadsheetId = '1ifzBSGoj-1MBD5mQG0UVvAPtbGbwfNN6jxl3MjSI1WU';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('worksheet2');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    // this will stop the circular loading indicator
    loading = false;
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }

   // insert a new transaction step-3
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }
}
