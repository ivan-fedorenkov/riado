Riado::Application.routes.draw do

  resources :regions do
      get :set_current, :on => :member     
  end
  
  resources :acols
  resources :advocatory_formations
  
  root :to => 'application#index'
end
