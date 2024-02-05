Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "localhost:5173", "cookbook-frontend-3nng.onrender.com", "localhost:8080"
    resource "*", headers: :any, methods: [:get, :post, :patch, :put, :delete]
  end
end
