# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5500"  # 許可するオリジン（リクエスト元のURL）
    resource "*",                     # すべてのリソースを許可
      headers: :any,                   # 任意のヘッダーを許可
      methods: [ :get, :post, :put, :patch, :delete, :options ]  # 許可するHTTPメソッド
  end
end
