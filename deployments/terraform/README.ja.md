# Terraform を使用した Azure AI Foundry リソースのデプロイ

このフォルダーには、Azure AI Foundry リソースをデプロイするための Terraform スクリプトが含まれています。Terraform は、宣言型構成言語を使用してインフラストラクチャを定義およびプロビジョニングすることを可能にするインフラストラクチャコード (IaC) ツールです。

## 前提条件

リソースをデプロイする前に、以下を確認してください:

1. **Terraform のインストール**
   - [Terraform の公式サイト](https://www.terraform.io/downloads.html) から Terraform をインストールしてください。
1. **Azure CLI のインストール**
   - [Microsoft の公式ドキュメント](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) から Azure CLI をインストールしてください。
1. **Azure サブスクリプション**
   - 有効な Azure サブスクリプションを持っていることを確認してください。
1. **サービス プリンシパル** または Azure ユーザー アカウント
   - Azure サブスクリプション内でリソースをデプロイするための必要な権限を持つサービス プリンシパル (またはユーザー アカウント) を作成してください。

## デプロイの手順

1. **Azure にログインする（認証）**:

   ```bash
   az login --tenant <your_TENANT_ID>
   ```

   サービス プリンシパルを使用する場合、以下を使用して認証します:

   ```bash
   az login --service-principal -u <APP_ID> -p <PASSWORD> --tenant <Tyour_ENANT_ID>
   ```

2. **Terraform デプロイを初期化する**:

   デプロイメント プロジェクト フォルダーに移動して、以下を実行します:

   ```bash
   terraform init
   ```

3. **Terraform デプロイを計画する**:

   作成または変更されるリソースを確認します:

   ```bash
   terraform plan -var-file="variables.tfvars"
   ```

4. **計画済みのデプロイを実施する**:

   リソースを Azure にデプロイします:

   ```bash
   terraform apply -var-file="variables.tfvars"
   ```

   プロンプトが表示されたら、デプロイメントを確認します。

5. **完了したデプロイの内容を確認する**:

   デプロイが完了したら、Azure ポータルでリソースを確認します。

## リソースのクリーンアップ

Terraform によってデプロイされたリソースを破棄するには、以下を実行します:

```bash
terraform destroy -var-file="variables.tfvars"
```

または

```bash
terraform apply -destroy -var-file="variables.tfvars"
```

## フォルダー構造

- `modules`: Azure AI Foundry 環境リソースのための Terraform モジュール
  - `ai-foundry-core`: Azure AI Foundry Hub リソースおよび必要/オプションのリソース。
  - `ai-foundry-services`: AI Foundry 環境に接続された AI 関連サービス
- `sandbox`: Azure AI Foundry のサンドボックス環境のデプロイメント プロジェクト フォルダー

## 注意事項

- クライアント シークレットやパスワードなどの機密情報を Terraform ファイルにハードコーディングしないようにしてください。環境変数や安全なシークレット管理ソリューションを使用してください。
- 互換性とセキュリティを確保するために、Terraform プロバイダーとモジュールを定期的に最新バージョンに更新してください。

詳細については、[Terraform ドキュメント](https://www.terraform.io/docs) を参照してください。
