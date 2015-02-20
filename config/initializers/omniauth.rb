Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'ID', 'TOKEN', :scope => 'repo,gist'
end