Rails.application.routes.draw do
  root 'static_pages#home'
  get "/getlines", to: 'static_pages#getlines'
  get "/checkpos", to: 'static_pages#checkpos'
end
