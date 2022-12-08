import 'package:core/core.dart';
import 'package:series/presentation/pages/series_page.dart';
import 'package:series/presentation/pages/watchlist_series_page.dart';
import 'package:flutter/material.dart';

class DashboardSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/dashboard-series';

  const DashboardSeriesPage({Key? key}) : super(key: key);

  @override
  State<DashboardSeriesPage> createState() => _DashboardSeriesPageState();
}

int currentIndex = 0;

class _DashboardSeriesPageState extends State<DashboardSeriesPage> {
  @override
  Widget build(BuildContext context) {
    Widget customDashboardSeries() {
      return BottomNavigationBar(
        backgroundColor: kRichBlack,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Series',
            icon: Icon(Icons.movie),
          ),
          BottomNavigationBarItem(
            label: 'Watchlist',
            icon: Icon(Icons.save_alt),
          )
        ],
      );
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return SeriesPage();

        case 1:
          return WatchlistSeriesPage();

        default:
          return SeriesPage();
      }
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: customDashboardSeries(),
    );
  }
}
