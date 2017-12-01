Rails.application.routes.draw do
  root 'static_pages#home'
  get "/checkpos", to: 'static_pages#checkpos'
end
