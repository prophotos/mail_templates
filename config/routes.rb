ActionController::Routing::Routes.draw do |map|
  map.namespace :admin do |a|
    a.resources :mail_templates, :member => {:test => :post}
  end
end
