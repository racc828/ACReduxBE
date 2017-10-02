Rails.application.routes.draw do
  namespace :api do
		namespace :v1 do
			resources :users, :projects, :lists, :tasks
      post '/sessions', to: 'sessions#create'
      get '/sessions/current_user', to: 'sessions#show'
      post '/projects/add_user', to: 'projects#add_user'
      post '/tasks/add_user', to: 'tasks#add_user'
      post '/projects/delete_user', to: 'projects#delete_user'
      post '/tasks/delete_user', to: 'tasks#delete_user'
      post '/tasks/get_tasks', to: 'tasks#get_tasks'
		end
	end
end
