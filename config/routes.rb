Hi5::Application.routes.draw do
  devise_for :users, path_names: { sign_in: "login", sign_out: "logout" },
                     controllers: { omniauth_callbacks: "omniauth_callbacks"}

  get "landing/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'landing#index'

  resources :profiles, except: [:index, :destroy]

  resources :recyclables
  resources :redeemers

# spencers-mbp-2:Hi5 Spencer$ rake routes
#                   Prefix Verb     URI Pattern                            Controller#Action
#         new_user_session GET      /users/login(.:format)                 devise/sessions#new
#             user_session POST     /users/login(.:format)                 devise/sessions#create
#     destroy_user_session DELETE   /users/logout(.:format)                devise/sessions#destroy
#  user_omniauth_authorize GET|POST /users/auth/:provider(.:format)        omniauth_callbacks#passthru {:provider=>/twitter|facebook/}
#   user_omniauth_callback GET|POST /users/auth/:action/callback(.:format) omniauth_callbacks#(?-mix:twitter|facebook)
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
#            landing_index GET      /landing/index(.:format)               landing#index

#                     root GET      /                                      landing#index
# Profiles:
#             profiles     POST     /profiles(.:format)                    profiles#create
#              new_profile GET      /profiles/new(.:format)                profiles#new
#             edit_profile GET      /profiles/:id/edit(.:format)           profiles#edit                   profile GET      /profiles/:id(.:format)                profiles#show
#                          PATCH    /profiles/:id(.:format)                profiles#update
#                          PUT      /profiles/:id(.:format)                profiles#update
# Recyclers:
#                recyclers GET      /recyclers(.:format)                   recyclers#index
#                          POST     /recyclers(.:format)                   recyclers#create
#             new_recycler GET      /recyclers/new(.:format)               recyclers#new
#            edit_recycler GET      /recyclers/:id/edit(.:format)          recyclers#edit
#                 recycler GET      /recyclers/:id(.:format)               recyclers#show
#                          PATCH    /recyclers/:id(.:format)               recyclers#update
#                          PUT      /recyclers/:id(.:format)               recyclers#update
#                          DELETE   /recyclers/:id(.:format)               recyclers#destroy
# Redeemers:
#                redeemers GET      /redeemers(.:format)                   redeemers#index
#                          POST     /redeemers(.:format)                   redeemers#create
#             new_redeemer GET      /redeemers/new(.:format)               redeemers#new
#            edit_redeemer GET      /redeemers/:id/edit(.:format)          redeemers#edit
#                 redeemer GET      /redeemers/:id(.:format)               redeemers#show
#                          PATCH    /redeemers/:id(.:format)               redeemers#update
#                          PUT      /redeemers/:id(.:format)               redeemers#update
#                          DELETE   /redeemers/:id(.:format)               redeemers#destroy

end
