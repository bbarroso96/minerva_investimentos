

class FNET
{
  String infoDate;
  String baseDate;
  String paymentDate;
  double dividend;
  String referenceDate;
  String year;
  String ticker;


  FNET({
    this.infoDate,
    this.baseDate,
    this.paymentDate,
    this.dividend,
    this.referenceDate,
    this.year,
    this.ticker
  });

  
  factory FNET.fromJson(Map<String, dynamic> data) => FNET(
    infoDate: data["infoDate"],
    baseDate: data["baseDate"],
    paymentDate: data["paymentDate"],
    dividend: data["dividend"],
    referenceDate:data["referenceDate"],
    year: data["year"],
    ticker: data["ticker"]
  );

  Map<String, dynamic> toMap() => {
        "infoDate": infoDate,
        "baseDate": baseDate,
        "paymentDate": paymentDate,
        "dividend": dividend,
        "referenceDate": referenceDate,
        "year": year,
        "ticker": ticker
    };
}