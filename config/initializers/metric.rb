Metric.configure do |config|
  config.api_key = ENV['METRIC_KEY']
  config.secret_key = ENV['METRIC_SECRET']
end

