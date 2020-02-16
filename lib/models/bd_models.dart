




class BdAsset
{
  final String nome;

  final String ticker;

  final String fundo;

  BdAsset({this.nome, this.ticker, this.fundo});
}

class BdPortfolio
{
  final String ticker;

  final int amount;

  BdPortfolio(this.ticker, this.amount);
}