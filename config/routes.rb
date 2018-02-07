Rails.application.routes.draw do

  devise_for :users

  root 'workout#index'

  get 'workout/options'

  get 'workout/results/:workout' => 'workout#results', :as => "results"

  get 'workout_controller/index'

  get 'workout_controller/results'

end
