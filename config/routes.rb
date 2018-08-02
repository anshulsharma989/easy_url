Rails.application.routes.draw do
  get 'home' => "tiny_urls#home"
  post 'get_tiny_url' => "tiny_urls#get_tiny_url"
  match '*a' => "tiny_urls#get_orginal_url", :via => [:get]
end
