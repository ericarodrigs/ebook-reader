import 'package:ebook_reader/domain/entities/book_entity.dart';
import 'package:ebook_reader/shared/colors.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:ebook_reader/shared/text_styles.dart';
import 'package:flutter/material.dart';

class GridViewBooks extends StatefulWidget {
  final List<BookEntity>? books;
  const GridViewBooks({
    Key? key,
    this.books,
  }) : super(key: key);

  @override
  State<GridViewBooks> createState() => _GridViewBooksState();
}

class _GridViewBooksState extends State<GridViewBooks> {
  final platform = const MethodChannel('erica.flutter.reader/ebook');
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 300,
        ),
        itemCount: widget.books?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => (widget.books?[index].downloadUrl != null)
                ? handleDownload(widget.books![index].downloadUrl!,
                    widget.books!.elementAt(index))
                : null,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Image.network(
                        widget.books?[index].coverUrl ?? '',
                        fit: BoxFit.cover,
                        cacheWidth: 150,
                        cacheHeight: 200,
                      ),
                    ),
                    const Icon(
                      Icons.bookmark,
                      color: AppColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Título: ${widget.books?[index].title ?? ''}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold14BlueGrey700(),
                ),
                const SizedBox(height: 8),
                Text(
                  'Autor: ${widget.books?[index].author ?? ''}',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold14BlueGrey700(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ANDROID VERSION
  Future<void> fetchAndroidVersion(String urlPath) async {
    final String? version = await getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await startDownload(urlPath);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await startDownload(urlPath);
        } else {
          await Permission.storage.request();
        }
      }
      debugPrint("ANDROID VERSION: $intValue");
    }
  }

  Future<String?> getAndroidVersion() async {
    try {
      final String version = await platform.invokeMethod('getAndroidVersion');
      return version;
    } on PlatformException catch (e) {
      print("FAILED TO GET ANDROID VERSION: ${e.message}");
      return null;
    }
  }

  download(String urlPath) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload(urlPath);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion(urlPath);
    } else {
      PlatformException(code: '500');
    }
  }

  startDownload(String urlPath) async {
    setState(() {
      loading = true;
    });
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/teste.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        urlPath,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          debugPrint('Download --- ${(receivedBytes / totalBytes) * 100}');
          setState(() {
            loading = true;
          });
        },
      ).whenComplete(() {
        setState(() {
          loading = false;
          filePath = path;
        });
        showSnackBar(context);
      });
    } else {
      setState(() {
        loading = false;
        filePath = path;
      });
    }
  }

  void showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'O seu download já foi concluído.\nPor favor, clique novamente para abrir!',
          style: AppTextStyles.bold14BlueGrey700(),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.primary,
        elevation: 20,
        padding: const EdgeInsets.all(24),
      ),
    );
  }

  handleDownload(String urlPath, BookEntity book) async {
    debugPrint("=====filePath======$filePath");
    if (filePath == "") {
      download(urlPath);
    } else {
      VocsyEpub.setConfig(
        themeColor: Theme.of(context).primaryColor,
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true,
      );

      VocsyEpub.locatorStream.listen((locator) {
        debugPrint('LOCATOR: $locator');
      });

      VocsyEpub.open(
        filePath,
        lastLocation: null,
      );
    }
  }
}
