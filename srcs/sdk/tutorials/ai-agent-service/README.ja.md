# チュートリアル: Azure AI Agent Service と AutoGen を組み合わせてカスタムエージェントアプリを構築する

このチュートリアルでは、Azure AI Agent Service と AutoGen を使用してカスタムエージェントアプリを構築する方法を学びます。Azure AI Agent Service は、AI モデルを簡単にデプロイし、管理するためのサービスであり、AutoGen は自動生成されたコードを使用して迅速にアプリケーションを開発するためのツールです。この組み合わせにより、複雑な AI アプリケーションを効率的に構築することができます。

このサンプルでコードでは、Azure AI Agent Service と AutoGen を組み合わせて、カスタムエージェントアプリを作成して、実際のユースケースに適用する方法を学びます。このチュートリアルを通じて、Azure AI Agent Service と AutoGen を活用した効率的な AI アプリケーション開発の手法を習得することができます。

## コードの説明

このチュートリアルで提供されるコードでは、指定する銘柄の株式に対する投資を行うかどうかの判断をするカスタムアプリです（実際の投資の判断には利用しないでください 保証はいたしません！）。

投資の判断を行う情報を以下のエージェントが集めて、集めた情報を総合して投資判断を行うエージェントが結論を出します。これらのエージェントは、AutoGen の `AssistantAGent` を利用して実装されます。
このプロセス全体は AutoGen の `RoundRobinGroupChat` を使用して、自動化されており、迅速かつ効率的に実行されます。

- [agents/stock_price_trends_agent.py](./agents/stock_price_trends_agent.py): 指定した銘柄の株価のトレンドに関する情報を収集するエージェント
- [agents/news_analysis_agent.py](./agents/news_analysis_agent.py): 指定した銘柄に関するニュースや最新情報に関する情報の収集と分析をするエージェント
- [agents/stock_sentiment_agent.py](./agents/stock_sentiment_agent.py): 指定した銘柄に関する市場心理に関する情報を収集するエージェント
  - 市場心理、アナリストの分析レポート、専門家の意見の3つを踏まえて情報収取します
- [agents/investment_decision_agent.py](./agents/investment_decision_agent.py): 上記の3つの情報を総合して、投資判断の決断を下すエージェント

これらのエージェントは、Azure モデル推論 API のクライアントを使って、推論を行います。

これらの `AssistantAgent` エージェントには、ツールを割り当てることができるため、Azure AI Agent Service のエージェントをツールとして割り当てます。

このサンプルコードでは、以下の Azure AI Agent Service のツールエージェントを実装しており、これらはすべて Bing グラウンディング検索ツールとして利用して得られた検索結果の情報を LLM が取り纏めて、`Assistant Agent` の実装に返すエージェントです：

- [tools/stock_price_trends.py](./tools/stock_price_trends.py): 株価トレンドを取得するツール
- [tools/news_analysis.py](./tools/news_analysis.py): ニュースや最新の情報を取得するツール
- [tools/market_sentiment.py](./tools/market_sentiment.py): 市場心理の情報を取得するツール
- [tools/analyst_reports.py](./tools/analyst_reports.py): アナリストの分析レポートの情報を取得するツール
- [tools/expert_opinions.py](./tools/expert_opinions.py): 専門家の意見に関する情報を取得するツール

それぞれのエージェントが LLM に渡すシステムメッセージは、[`messages_ja.py`](./messages_ja.py) で定義されています。

Azure AI Foundry SDK ツールは、これらのコードではすべてトレースを有効にしているため、Azure AI Foundry のプロジェクトでは、Application Insights を接続して、トレース情報を取得できるようにしてください。
