Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource 'cse'
  resources :questions_image, only: [:create]
end

# constrains format: :json do
#
# end
