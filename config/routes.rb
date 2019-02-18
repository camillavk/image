Rails.application.routes.draw do
  post 'upload_image' => 'images#upload'

  get 'retrieve_image' => 'images#retrieve'
end
