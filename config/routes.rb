# frozen_string_literal: true

# == Route Map
#
#                               Prefix Verb   URI Pattern                                                                              Controller#Action
#                     new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                         user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#                 destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#                    new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                   edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                        user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                      PUT    /users/password(.:format)                                                                devise/passwords#update
#                                      POST   /users/password(.:format)                                                                devise/passwords#create
#               accept_user_invitation GET    /users/invitation/accept(.:format)                                                       users/invitations#edit
#               remove_user_invitation GET    /users/invitation/remove(.:format)                                                       users/invitations#destroy
#                  new_user_invitation GET    /users/invitation/new(.:format)                                                          users/invitations#new
#                      user_invitation PATCH  /users/invitation(.:format)                                                              users/invitations#update
#                                      PUT    /users/invitation(.:format)                                                              users/invitations#update
#                                      POST   /users/invitation(.:format)                                                              users/invitations#create
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
  devise_for :users, skip: [:registrations], controllers: { invitations: 'users/invitations' }
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'

  resources :projects do
    collection do
    end
  end
end
