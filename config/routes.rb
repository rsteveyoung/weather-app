Rails.application.routes.draw do
  root to: 'weather#index'
  get '*path' => redirect('/')
end
