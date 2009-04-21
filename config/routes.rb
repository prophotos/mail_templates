ActionController::Routing::Routes.draw do |map|
  map.resources :mail_templates, :member => {:test => :post}
end
