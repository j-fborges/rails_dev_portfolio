# frozen_string_literal: true

# == Route Map
#
#                               Prefix Verb   URI Pattern                                                                              Controller#Action
#                             projects GET    /projects(.:format)                                                                      projects#index
#                                      POST   /projects(.:format)                                                                      projects#create
#                          new_project GET    /projects/new(.:format)                                                                  projects#new
#                         edit_project GET    /projects/:id/edit(.:format)                                                             projects#edit
#                              project GET    /projects/:id(.:format)                                                                  projects#show
#                                      PATCH  /projects/:id(.:format)                                                                  projects#update
#                                      PUT    /projects/:id(.:format)                                                                  projects#update
#                                      DELETE /projects/:id(.:format)                                                                  projects#destroy
#                                 root GET    /                                                                                        pages#home
# toggle_featured_image_field_projects POST   /projects/toggle_featured_image_field(.:format)                                          projects#toggle_featured_image_field
#                                      GET    /projects(.:format)                                                                      projects#index
#                                      POST   /projects(.:format)                                                                      projects#create
#                                      GET    /projects/new(.:format)                                                                  projects#new
#                                      GET    /projects/:id/edit(.:format)                                                             projects#edit
#                                      GET    /projects/:id(.:format)                                                                  projects#show
#                                      PATCH  /projects/:id(.:format)                                                                  projects#update
#                                      PUT    /projects/:id(.:format)                                                                  projects#update
#                                      DELETE /projects/:id(.:format)                                                                  projects#destroy
#                   rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#            rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                   rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#            update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                 rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  resources :projects do
    collection do
      post :toggle_featured_image_field
    end
  end
end
