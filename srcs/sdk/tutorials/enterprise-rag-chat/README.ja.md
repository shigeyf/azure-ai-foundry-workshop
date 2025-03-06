# チュートリアル: Azure AI Foundry SDK を使用してカスタム RAG チャットアプリを構築する

[English](./README.md) | [日本語](./README.ja.md)

このチュートリアルでは、Azure AI Foundry SDK（およびその他のライブラリ）を使用して、あなたの小売会社である Contoso Trek のためのチャットアプリを構築、設定、および評価します。あなたの小売会社はアウトドアキャンプ用品と衣類を専門としています。チャットアプリは、製品やサービスに関する質問に答えることができます。例えば、「最も防水性の高いテントはどれですか？」や「寒冷地向けの最適な寝袋はどれですか？」といった質問に答えることができます。

このチュートリアルは、以下の Microsoft Learn ドキュメントで紹介されている詳細なチュートリアルです。パート 1 はこのチュートリアルではカバーされていません。環境をセットアップするには、ドキュメントに従ってください。

- [パート1 - Azure AI Foundry SDK を使用してカスタムナレッジリトリーバル（RAG）アプリを構築するためのプロジェクトと開発環境をセットアップする](https://learn.microsoft.com/ja-jp/azure/ai-foundry/tutorials/copilot-sdk-create-resources?tabs=windows)
  - プロジェクトを作成する
  - Azure AI Search インデックスを作成する
  - Azure CLI をインストールしてサインインする
  - Python とパッケージをインストールする
  - モデルをプロジェクトにデプロイする
  - 環境変数を設定する

> 他のチュートリアルやクイックスタートを完了している場合、このチュートリアルに必要なリソースの一部を既に作成しているかもしれません。その場合、ここでの手順をスキップしても構いません。

- [パート2 - Azure AI Foundry SDK を使用してカスタムナレッジリトリーバル（RAG）アプリを構築する](https://learn.microsoft.com/ja-jp/azure/ai-foundry/tutorials/copilot-sdk-build-rag)
  - サンプルデータを取得する
  - チャットアプリで使用するデータの検索インデックスを作成する
  - カスタム RAG コードを開発する
- [パート3 - Azure AI Foundry SDK を使用してカスタムチャットアプリケーションを評価する](https://learn.microsoft.com/ja-jp/azure/ai-foundry/tutorials/copilot-sdk-evaluate)
  - 評価データセットを作成する
  - Azure AI 評価ツールを使用してチャットアプリを評価する
  - アプリを反復して改善する

このプロジェクトで利用する環境変数は、以下の通りです。

```text
PROJECT_CONNECTION_STRING=<your-project-connection-string>
SEARCH_INDEX_NAME="example-index"
EMBEDDINGS_MODEL="text-embedding-ada-002"
INTENT_MAPPING_MODEL="gpt-4o-mini"
CHAT_MODEL="gpt-4o-mini"
EVALUATION_MODEL="gpt-4o-mini"
INTENT_MAPPING_PROMPT="intent_mapping.prompty"
GROUNDED_CHAT_PROMPT="grounded_chat.prompty"
EVALUATION_DATA="chat_eval_data.jsonl"
PRODUCT_INFO_FOLDER="product-info"
```
