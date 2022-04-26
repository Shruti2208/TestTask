import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:nextbase_task/home_view_provider.dart';
import 'package:provider/provider.dart';

import '../data_model.dart';
import '../widgets/circular_progressbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final bool animate = false;

  @override
  void initState() {
    var homeViewProvider =
        Provider.of<HomeViewProvider>(context, listen: false);
    homeViewProvider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewProvider>(builder: (ctx, homeViewProvider, child) {
      List<charts.Series<Datum, double>> series = [
        charts.Series(
            id: "xAcc v/s yAcc",
            data: homeViewProvider.data.data!,
            domainFn: (Datum series, _) => series.xAcc!,
            measureFn: (Datum series, _) => series.yAcc,
            colorFn: (Datum series, _) =>
                charts.MaterialPalette.blue.shadeDefault),
        charts.Series(
            id: "xAcc v/s zAcc",
            data: homeViewProvider.data.data!,
            domainFn: (Datum series, _) => series.xAcc!,
            measureFn: (Datum series, _) => series.zAcc,
            colorFn: (Datum series, _) =>
                charts.MaterialPalette.red.shadeDefault)
      ];
      return AbsorbPointer(
          absorbing: homeViewProvider.loading ? true : false,
          child: Scaffold(
            body: Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    height: MediaQuery.of(context).size.height - 100,
                    child: homeViewProvider.data.data != null
                        ? charts.LineChart(series,
                            animate: animate,
                            behaviors: [
                                charts.SeriesLegend(desiredMaxColumns: 2)
                              ])
                        : Container(),
                  ),
                ),
                Positioned(
                  child: homeViewProvider.loading
                      ? const CircularProgressbarFullscreen(
                          title: 'Fetching Data')
                      : Container(),
                )
              ],
            ),
          ));
    });
  }
}
