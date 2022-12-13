// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Shared {
  static Future<HttpClient> customeHttpClient({bool isTestMode = false}) async {
    final context = SecurityContext(withTrustedRoots: false);

    try {
      List<int> certFileBytes = [];

      if (isTestMode) {
        certFileBytes = utf8.encode(_certificatedString);
      } else {
        try {
          certFileBytes =
              (await rootBundle.load('assets/certificates/ssl_pinning.pem'))
                  .buffer
                  .asInt8List();
          debugPrint('Successfully access and load ssl_pinning.pem file!');
        } catch (e) {
          certFileBytes = utf8.encode(_certificatedString);
          debugPrint(
              'Error access and load ssl_pinning.pem file.\n${e.toString()}');
        }
      }

      context.setTrustedCertificatesBytes(certFileBytes);
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        debugPrint('createHttpClient() - cert already trusted! Skipping.');
      } else {
        debugPrint(
            'createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      debugPrint('unexpected error $e');
      rethrow;
    }

    final httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client =
        IOClient(await Shared.customeHttpClient(isTestMode: isTestMode));
    return client;
  }
}

const _certificatedString = """-----BEGIN CERTIFICATE-----
MIID2DCCA12gAwIBAgISA7M7OQ83/SVbCHyxshLDsraDMAoGCCqGSM49BAMDMDIx
CzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQDEwJF
MTAeFw0yMjEwMjMwODQ1NDdaFw0yMzAxMjEwODQ1NDZaMB8xHTAbBgNVBAMMFCou
c29tZS1yYW5kb20tYXBpLm1sMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAENeGc
g2msf5icwy3WeulqtGu8HPeD9bclB/iBLDA3ZtT3HerJRyLFhZwaxaC5ROv6nFWn
WuXA3gNdegfx7R7pgaOCAmQwggJgMA4GA1UdDwEB/wQEAwIHgDAdBgNVHSUEFjAU
BggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUED3A
td/wIUp6JWH+Ato667asGmEwHwYDVR0jBBgwFoAUWvPtK/w2wjd5uVIw6lRvz1XL
LqwwVQYIKwYBBQUHAQEESTBHMCEGCCsGAQUFBzABhhVodHRwOi8vZTEuby5sZW5j
ci5vcmcwIgYIKwYBBQUHMAKGFmh0dHA6Ly9lMS5pLmxlbmNyLm9yZy8wMwYDVR0R
BCwwKoIUKi5zb21lLXJhbmRvbS1hcGkubWyCEnNvbWUtcmFuZG9tLWFwaS5tbDBM
BgNVHSAERTBDMAgGBmeBDAECATA3BgsrBgEEAYLfEwEBATAoMCYGCCsGAQUFBwIB
FhpodHRwOi8vY3BzLmxldHNlbmNyeXB0Lm9yZzCCAQUGCisGAQQB1nkCBAIEgfYE
gfMA8QB3ALc++yTfnE26dfI5xbpY9Gxd/ELPep81xJ4dCYEl7bSZAAABhAQ776oA
AAQDAEgwRgIhAJlPecy0EyNqb7rAY9E6NClxF65p+bhJJQS9VNIuw+FmAiEAopYw
kM3zSa30rOHrzG/ypZ5hjpO+zkhH4Udq4bBf8wQAdgDoPtDaPvUGNTLnVyi8iWvJ
A9PL0RFr7Otp4Xd9bQa9bgAAAYQEO++XAAAEAwBHMEUCIBEbCs6qDSx9R7EtRsh5
2qgGg2bermljCwWGiwP62yYZAiEAgvht3+h2bJJa9082aIz99A4Ee8lnpl4e1xn9
lvZxnWkwCgYIKoZIzj0EAwMDaQAwZgIxANq7lI13jjynCFwujkaWHMrPzlZ0j7lk
Gv2HFUDRhz/nNWiwOKLcF6locSdYUHIGHwIxAP51cach2Pj+KSd7rD9vICdibIFY
xPWhKycXJDbDCsFkZJhEG++TwgtMgELotpEjzA==
-----END CERTIFICATE-----""";
