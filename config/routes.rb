Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations'},
  path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
end
    root 'workout#index'

    get 'workout/options'

    get 'workout/results/:workout' => 'workout#results', :as => "results"

    get 'workout_controller/index'

    get 'workout_controller/results'

  end