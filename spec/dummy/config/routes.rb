Rails.application.routes.draw do

  resources :schedules
  get 'schedules/:id/edit-in-modal' => 'schedules#edit_in_modal'
  get 'schedules/:id/edit_with_index' => 'schedules#edit_with_index', as: 'edit_schedule_with_index'

  get 'custom_schedules/new' => 'schedules#new_custom'
  get 'custom_schedules/:id/edit' => 'schedules#edit_custom'

  resources :no_sql_models, only: [:new, :index]

  resources :people
end
