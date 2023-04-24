Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/_/up", to: "health#show"

  root "browse#show", defaults: { gopher_path: "1/#{ENV.fetch('GOPHER_PATH', '')}" }
  get "/_/search", to: "search#show"
  get "/_/external_gopher_link", to: "pages#external_gopher_link"
  get "*gopher_path", to: "browse#show", format: false
end
