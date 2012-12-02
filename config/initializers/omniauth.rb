Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, '447662195295668', 'a707ee8f497555e49ce6397395f4d546'
end
