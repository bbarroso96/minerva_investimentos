
import 'dart:collection';
import 'dart:convert';

class MetadataDaily
{
  String information;

  String symbol;

  String lastRefeshed;

  String outputSize;

  String timeZone;

  MetadataDaily({
    this.information,
    this.symbol,
    this.lastRefeshed,
    this.outputSize,
    this.timeZone
  });

  factory MetadataDaily.fromJson(Map<String, dynamic> data) => MetadataDaily(
    information: data["1. Information"],
    symbol: data["2. Symbol"],
    lastRefeshed: data["3. Last Refreshed"],
    outputSize: data["4. Output Size"],
    timeZone: data["5. Time Zone"],
  );
}


class MetadataIntraDay
{
  String information;

  String symbol;

  String lastRefeshed;

  String interval;

  String outputSize;

  String timeZone;

  MetadataIntraDay({
    this.information,
    this.symbol,
    this.lastRefeshed,
    this.interval,
    this.outputSize,
    this.timeZone
  });

  factory MetadataIntraDay.fromJson(Map<String, dynamic> data) => MetadataIntraDay(
    information: data["1. Information"],
    symbol: data["2. Symbol"],
    lastRefeshed: data["3. Last Refreshed"],
    interval: data["4. Interval"],
    outputSize: data["5. Output Size"],
    timeZone: data["6. Time Zone"],
  );
}


class TimeSeries
{
  String open;

  String high;

  String low;

  String close;

  String volume;

    TimeSeries({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume
  });

  factory TimeSeries.fromJson(Map<String, dynamic> data) => TimeSeries(
    open: data["1. open"],
    high: data["2. high"],
    low: data["3. low"],
    close: data["4. close"],
    volume: data["5. volume"],
  );
}


class AlphaVantageDaily
{
  MetadataDaily metadata;

  List<TimeSeries> timeSeriesList;

  AlphaVantageDaily({
    this.metadata,
    this.timeSeriesList
  });

  
  factory AlphaVantageDaily.fromJson(Map<String, dynamic> data)
  {
    List<TimeSeries> timeSeriesList = List<TimeSeries>();

    LinkedHashMap linkedHashMap =  LinkedHashMap.from(data["Time Series (Daily)"]);

    linkedHashMap.forEach((k, v) => timeSeriesList.add(TimeSeries.fromJson(v)));

   return AlphaVantageDaily(
      metadata: MetadataDaily.fromJson(data["Meta Data"]),
      timeSeriesList: timeSeriesList,
    );
  }
}

class AlphaVantageIntraDay
{
  MetadataIntraDay metadata;

  List<TimeSeries> timeSeriesList;

  AlphaVantageIntraDay({
    this.metadata,
    this.timeSeriesList
  });

  
  factory AlphaVantageIntraDay.fromJson(Map<String, dynamic> data)
  {
    List<TimeSeries> timeSeriesList = List<TimeSeries>();

    LinkedHashMap linkedHashMap =  LinkedHashMap.from(data["Time Series (5min)"]);

    linkedHashMap.forEach((k, v) => timeSeriesList.add(TimeSeries.fromJson(v)));

   return AlphaVantageIntraDay(
      metadata: MetadataIntraDay.fromJson(data["Meta Data"]),
      timeSeriesList: timeSeriesList,
    );
  }
}
 