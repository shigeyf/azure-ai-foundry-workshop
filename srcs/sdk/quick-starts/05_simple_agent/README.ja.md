# クイックスタート 5: Azure AI Foundry で シンプルな AI Agent アプリを開発する

[English](./README.md) | [日本語](./README.ja.md)

このノートでは、Azure AI Foundry SDK を使用して、AI エージェントを使った推論チャットアプリケーションを開発する方法について説明します。

Azure AI Foundry では、エージェントを実行するための Azure AI Agent Service と呼ばれるプラットフォームを提供します。Azure AI Agent Service は、エージェントの実行に必要となるコンピューティングおよびストレージのリソースを開発者が管理する必要がなく、高品質で拡張可能な AI エージェントを安全にビルド、デプロイ、スケーリングできるように設計されたフル マネージド サービスです。

これまでの一般的な AI アプリケーションでは、クライアント側の関数呼び出しをサポートするために何百行ものコードを必要としていましたが、Azure AI Agent Service を使用することで、数行のコードで実行できるようになります。

AI Agent Service では、様々なツールを割り当てて推論モデルを使ってエージェントを実行することができます。

- ナレッジ ツール
  - Bing 検索を使用したグラウンディング （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/bing-grounding?tabs=python&pivots=code-example)）
  - ファイル検索 （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/file-search?tabs=python&pivots=azure-blob-storage-code-examples)）
  - Azure AI Search （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/azure-ai-search?tabs=azurecli%2Cpython&pivots=code-examples)）
- アクション ツール
  - コードインタープリター （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/code-interpreter?tabs=python&pivots=overview)）
  - 独自の関数 （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/function-calling?tabs=python&pivots=code-example)）
  - Azure Functions （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/azure-functions?pivots=code-example)）
  - OpenAPI で定義された API ツール （[コード例](https://learn.microsoft.com/ja-jp/azure/ai-services/agents/how-to/tools/openapi-spec?tabs=python&pivots=code-example)）

> **注意**
> "Bing 検索を使用したグラウンディング" で対応している OpenAI モデルは以下のモデルです：
> gpt-3.5-turbo-0125、gpt-4-0125-preview、gpt-4-turbo-2024-04-09、gpt-4o-0513

以下のノートがあります：

- [コードインタープリター ツールを使ったエージェント](./agent_chat.ipynb)
- [Azure AI Search ツールを使ったエージェント](./agent_chat_aisearch.ipynb)
- [OpenAPI ツールを使ったエージェント](./agent_chat_openapi.ipynb)
