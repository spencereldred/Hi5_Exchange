Hi5::Application.routes.draw do
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks"}

  get "landing/about", as: 'how_it_works'
  root to: 'landing#index'
  resources :profiles, except: [:destroy]
  resources :transactions, except: [:update, :destroy]
  resources :redeemers, except: [:create, :new, :destroy]
  get '/admins' => 'admins#index'
  resources :groups


#                   Prefix Verb     URI Pattern                            Controller#Action
#         new_user_session GET      /users/login(.:format)                 devise/sessions#new
#             user_session POST     /users/login(.:format)                 devise/sessions#create
#     destroy_user_session DELETE   /users/logout(.:format)                devise/sessions#destroy
#  user_omniauth_authorize GET|POST /users/auth/:provider(.:format)        omniauth_callbacks#passthru {:provider=>/twitter|facebook/}
#   user_omniauth_callback GET|POST /users/auth/:action/callback(.:format) omniauth_callbacks#:action
#            user_password POST     /users/password(.:format)              devise/passwords#create
#        new_user_password GET      /users/password/new(.:format)          devise/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)         devise/passwords#edit
#                          PATCH    /users/password(.:format)              devise/passwords#update
#                          PUT      /users/password(.:format)              devise/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)                devise/registrations#cancel
#        user_registration POST     /users(.:format)                       devise/registrations#create
#    new_user_registration GET      /users/sign_up(.:format)               devise/registrations#new
#   edit_user_registration GET      /users/edit(.:format)                  devise/registrations#edit
#                          PATCH    /users(.:format)                       devise/registrations#update
#                          PUT      /users(.:format)                       devise/registrations#update
#                          DELETE   /users(.:format)                       devise/registrations#destroy
#             how_it_works GET      /landing/about(.:format)               landing#about
#                     root GET      /                                      landing#index
#                 profiles GET      /profiles(.:format)                    profiles#index
#                          POST     /profiles(.:format)                    profiles#create
#              new_profile GET      /profiles/new(.:format)                profiles#new
#             edit_profile GET      /profiles/:id/edit(.:format)           profiles#edit
#                  profile GET      /profiles/:id(.:format)                profiles#show
#                          PATCH    /profiles/:id(.:format)                profiles#update
#                          PUT      /profiles/:id(.:format)                profiles#update
#             transactions GET      /transactions(.:format)                transactions#index
#                          POST     /transactions(.:format)                transactions#create
#          new_transaction GET      /transactions/new(.:format)            transactions#new
#         edit_transaction GET      /transactions/:id/edit(.:format)       transactions#edit
#              transaction GET      /transactions/:id(.:format)            transactions#show
#                redeemers GET      /redeemers(.:format)                   redeemers#index
#            edit_redeemer GET      /redeemers/:id/edit(.:format)          redeemers#edit
#                 redeemer GET      /redeemers/:id(.:format)               redeemers#show
#                          PATCH    /redeemers/:id(.:format)               redeemers#update
#                          PUT      /redeemers/:id(.:format)               redeemers#update
#                   admins GET      /admins(.:format)                      admins#index
#                   groups GET      /groups(.:format)                      groups#index
#                          POST     /groups(.:format)                      groups#create
#                new_group GET      /groups/new(.:format)                  groups#new
#               edit_group GET      /groups/:id/edit(.:format)             groups#edit
#                    group GET      /groups/:id(.:format)                  groups#show
#                          PATCH    /groups/:id(.:format)                  groups#update
#                          PUT      /groups/:id(.:format)                  groups#update
#                          DELETE   /groups/:id(.:format)                  groups#destroy

end
