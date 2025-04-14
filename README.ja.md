# Azure AI Foundry ワークショップ: 初心者から中級者に向けて

[English](./README.md) | [日本語](./README.ja.md)

このリポジトリには、Azure AI Foundry サービスを活用して、Azure 上で独自の AI アプリケーションを開発および構築するための学習資料が含まれています。

ローカルコンピュータで学習する際は、VSCode ワークスペースファイル [`default`](./default.code-workspace) を開いてください。

ワークスペースは以下のセクションに分かれています：

## デプロイメント

### Terraform

`deployments/terraform` フォルダーには、Azure AI Foundry リソースをデプロイするための Terraform スクリプトが含まれています。このフォルダー内の [README (日本語)](./infra/terraform/README.ja.md) を参照して、デプロイメントの詳細な手順を確認してください。

## SDK クイックスタート

`srcs/sdk/quick-starts` フォルダーには、Azure AI Foundry SDK を使用してアプリケーション開発を学ぶためのクイックスタート例が含まれています。Jupyter Notebook を使用して、ステップバイステップで学習できます。

各サブフォルダーは特定のユースケースに焦点を当てています:

- Notebook を使用したサンプルアプリケーション開発の学習
  - 以下が含まれます:
    - [0. Azure AI Foundry の基礎](./srcs/sdk/quick-starts/00_basics/)
      - SDK の基本機能を理解するための基本例。
    - [1. Azure AI Foundry を使用したシンプルな AI 推論チャットアプリケーションの構築](./srcs/sdk/quick-starts/01_simple_inference_chat/)
      - シンプルな推論チャット機能を示します。
    - [2. Azure AI Foundry を使用したシンプルな AI 推論チャットアプリケーションの構築 (続)](./srcs/sdk/quick-starts/02_simple_chat_with_prompt_template/)
      - チャットインタラクションのためのプロンプトテンプレートの使用方法を示します。
    - [3. Azure AI Foundry を使用した RAG を活用した AI 推論チャットアプリケーションの開発](./srcs/sdk/quick-starts/03_rag_chat/)
      - チャットアプリケーションのための Retrieval-Augmented Generation (RAG) を実装します。
    - [4. Azure AI Foundry を使用した推論モデル結果の評価アプリケーションの開発](./srcs/sdk/quick-starts/04_evaluation/)
      - AI モデルとその出力を評価する例。
    - [5. Azure AI Foundry を使用したシンプルな AI エージェントアプリケーションの開発](./srcs/sdk/quick-starts/05_simple_agent/)
      - シンプルな AI エージェントの構築を示します。

## SDK チュートリアル

`srcs/sdk/tutorials` フォルダーには、より高度なユースケース向けの包括的なチュートリアルが含まれています:

- モジュール化されたコードを使用したサンプルアプリケーションの構築
- 以下が含まれます:
  1. [Azure AI Foundry SDK を使用したカスタム RAG チャットアプリの構築](./srcs/sdk/tutorials/enterprise-rag-chat/)
     - エンタープライズ向け RAG チャットアプリケーションの構築に関するチュートリアル。
  1. [Azure AI Agent Service と AutoGen を組み合わせたカスタムエージェントアプリの構築](./srcs/sdk/tutorials/ai-agent-service/)
     - AI エージェントサービスの作成方法を説明します。

## はじめる

1. このリポジトリをクローンします。
1. 各フォルダー内の手順に従って、例やチュートリアルをセットアップして実行してください。

## コントリビューション

コントリビューションは大歓迎です！ 提案や改善点があれば、PR (プルリクエスト) を送信するか、Issues を作成してください。
