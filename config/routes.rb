CheckinsService::Application.routes.draw do

  resource :checkins, :only => [:index, :create]
  get 'stream/checkins' => 'stream#checkins'

  root :to => 'checkins#index'
end
