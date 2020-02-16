


import 'package:flutter/scheduler.dart';

class Asset
{
  String nome;
  String ticker;
  String fundo;

}


class B3Asset
{
  String name;
  String ticker;
  String fund;

  B3Asset({
    this.name,
    this.ticker,
    this.fund
  });

  String get assetName => name;
  String get assetTicker => ticker;
  String get assetFund => fund;

  factory B3Asset.fromJson(Map<String, dynamic> data) => B3Asset(
    name: data["name"],
    ticker: data["ticker"],
    fund: data["fund"]
  );

   Map<String, dynamic> toMap() => {
        "name": name,
        "ticker": ticker,
        "fund": fund
    };
}



class PortfolioAsset
{
  String ticker;
  int amount;

  PortfolioAsset({
    this.ticker,
    this.amount
  });

  String get assetTicker => ticker;
  int get assetAmount => amount;

  factory PortfolioAsset.fromJson(Map<String, dynamic> data) => PortfolioAsset(
    ticker: data["ticker"],
    amount: data["amount"]
  );

   Map<String, dynamic> toMap() => {
        "ticker": ticker,
        "amount": amount
    };
}