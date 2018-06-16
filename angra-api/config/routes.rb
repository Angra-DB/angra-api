Rails.application.routes.draw do
  scope '/api' do
    post '/create_db/:db_name' => 'angra_services#create_db'
    post '/save' => 'angra_services#save'
    post '/lookup/:key' => 'angra_services#lookup'
    post '/update/:key' => 'angra_services#update'
    post '/delete/:key' => 'angra_services#delete'
  end
end
