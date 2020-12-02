Simpler.application.routes do
  get '/tests', 'tests#index'
  get '/tests/:id', 'tests#show'
end
