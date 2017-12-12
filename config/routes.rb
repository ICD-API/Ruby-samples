Rails.application.routes.draw do
  get 'interaction/new'

  post 'interaction/show'

  root 'interaction#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
