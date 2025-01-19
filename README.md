## 必要な環境

- Ruby 3.x 以上
- Rails 6.x 以上
- PostgreSQL または MySQL（データベースによる）
- Node.js（フロントエンドが必要な場合）
- その他必要な依存関係（`bundle install` でインストールされます）

## セットアップ手順

### 1. リポジトリのクローン

まず、このリポジトリをクローンします。

```bash
git https://github.com/aoi20031020/triggle_app_service
cd triggle_app_service
```


### 2. 必要な Gem のインストール

依存する Gem をインストールします。

```bash
bundle install
```

### 3. データベースの設定

データベースを設定し、マイグレーションを実行します。

```bash
rails db:create
rails db:migrate
rails db:seed  # 任意（初期データがある場合←ないです）
```

### 4. CORS の設定（フロントエンドからのリクエストを許可する）

フロントエンドから API をリクエストする場合は、CORS 設定が必要です。以下の設定を行います。

- `Gemfile` に `rack-cors` を追加します（まだ追加していない場合）。

```ruby
gem 'rack-cors'
```

- `bundle install` でインストールします。

```bash
bundle install
```

- `config/initializers/cors.rb` に以下の設定を追加します。

```ruby
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5500'  # フロントエンドのURLを指定
    resource '*',                     # すべてのリソースを許可
      headers: :any,                   # 任意のヘッダーを許可
      methods: [:get, :post, :put, :patch, :delete, :options]  # 許可するHTTPメソッド
  end
end
```

### 5. サーバーの起動

Rails サーバーを起動します。

```bash
rails server
```

デフォルトでは、`http://localhost:3000` でアクセスできます。

### 6. フロントエンドの設定（必要に応じて）

もしフロントエンドが別途必要な場合（例えば、`localhost:5500` で提供される場合）、以下の手順で立ち上げます。

1. 必要な依存関係をインストールします。

```bash
npm install
```

2. サーバーを起動します。

```bash
npm start
```

これで、フロントエンドは `http://localhost:5500` で起動します。

### 7. API エンドポイント

- `GET /api/result`: ゲーム結果を取得します。
- `POST /api/result`: ゲーム結果を送信します。

例：ゲーム結果を送信する（`POST /api/result`）

```bash
curl -X POST http://localhost:3000/api/result \
  -H "Content-Type: application/json" \
  -d '{
    "game_result": {
      "timestamp": "2025-01-18T12:34:56.789Z",
      "player_number": 4,
      "final_scores": [20, 15, 10, 30],
      "game_record": [
        {
          "player_number": 1,
          "click_pole": [2.5, 3.7],
          "clicked_pole": [4.2, 5.1],
          "player1": 10,
          "player2": 0,
          "player3": 0,
          "player4": 0
        },
        {
          "player_number": 2,
          "click_pole": [5.6, 6.8],
          "clicked_pole": [7.3, 8.4],
          "player1": 10,
          "player2": 5,
          "player3": 0,
          "player4": 0
        }
      ]
    }
  }'
```

### 8. トラブルシューティング

- **CORS エラーが発生する場合**
  フロントエンドとバックエンドの URL が異なる場合、CORS 設定が必要です。上記の設定を確認してください。


## Triggle Game APIドキュメント

Triggle Gameの結果と記録を管理・取得するためのAPIです。

## バージョン

- バージョン: 1.0.0

## サーバー

- URL: [http://localhost:3000](http://localhost:3000)
  - 説明: local

## エンドポイント

### `/api/result`

#### GET: ゲーム結果を取得

ゲーム結果を取得します。タイムスタンプ、プレイヤー番号、最終スコア、ゲーム記録を含みます。

**レスポンス:**

- `200 OK`: ゲーム結果が正常に取得されました。

```json
{
  "game_result": {
    "timestamp": "2025-01-18T12:34:56.789Z",
    "player_number": 4,
    "final_scores": [20, 15, 10, 30],
    "game_record": [
      {
        "player_number": 1,
        "click_pole": [2.5, 3.7],
        "clicked_pole": [4.2, 5.1],
        "player1": 10,
        "player2": 0,
        "player3": 0,
        "player4": 0
      },
      {
        "player_number": 2,
        "click_pole": [5.6, 6.8],
        "clicked_pole": [7.3, 8.4],
        "player1": 10,
        "player2": 5,
        "player3": 0,
        "player4": 0
      }
    ]
  }
}
```

- `500 Internal Server Error`: サーバーエラーが発生しました。

#### POST: ゲーム結果を送信

新しいゲーム結果を送信します。タイムスタンプ、プレイヤー番号、最終スコア、ゲーム記録を含むデータを送信します。

**リクエストボディ:**

```json
{
  "game_result": {
    "timestamp": "2025-01-18T12:34:56.789Z",
    "player_number": 4,
    "final_scores": [20, 15, 10, 30],
    "game_record": [
      {
        "player_number": 1,
        "click_pole": [2.5, 3.7],
        "clicked_pole": [4.2, 5.1],
        "player1": 10,
        "player2": 0,
        "player3": 0,
        "player4": 0
      },
      {
        "player_number": 2,
        "click_pole": [5.6, 6.8],
        "clicked_pole": [7.3, 8.4],
        "player1": 10,
        "player2": 5,
        "player3": 0,
        "player4": 0
      }
    ]
  }
}
```

**レスポンス:**

- `201 Created`: ゲーム結果が正常に送信されました。
- `400 Bad Request`: データが無効なためリクエストが失敗しました。
- `500 Internal Server Error`: サーバーエラーが発生しました。

## スキーマ

### `game_result`

- `timestamp` (string, date-time): 結果が記録されたタイムスタンプ。
- `player_number` (integer): ゲームに参加したプレイヤーの人数。
- `final_scores` (array of integers): 各プレイヤーの最終スコア。
- `game_record` (array of objects): ゲーム記録。各プレイヤーの操作やスコアを含みます。

#### `game_record` の各エントリー

- `player_number` (integer): 手を行ったプレイヤーの番号。
- `click_pole` (array of floats): プレイヤーがクリックしたポールの座標。
- `clicked_pole` (array of floats): プレイヤーがクリックしたポールの座標。
- `player1`, `player2`, `player3`, `player4` (integer): 各プレイヤーの手番後のスコア。

## エラーレスポンス

- `400 Bad Request`: リクエストが無効な場合。
- `500 Internal Server Error`: サーバーエラーが発生した場合。

```
