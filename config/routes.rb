# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  devise_for :admins,
             skip: %i[sign_up registration],
             controllers: {sessions: "admin/auth/sessions"}

  root to: "home#index"

  authenticate :admin do
    mount Sidekiq::Web => "/sidekiq"
  end

  admin_resources = %i[
    articles
  ]

  namespace :admin do
    resources :admins
    root to: redirect("/admin/admins")

    admin_resources.each do |resource_name|
      resources resource_name
    end
  end

  api_resources = admin_resources

  namespace :api do
    namespace :v1 do
      mount BaseUploader.upload_endpoint(:cache) => "/file_upload", :as => :file_upload

      api_resources.each do |resource_name|
        jsonapi_resources resource_name
      end
    end
  end

  namespace :webhooks do
    get "social_auth/vk_oauth_handler", to: "social_auth#vk_oauth_handler"
    get "social_auth/facebook_oauth_handler", to: "social_auth#facebook_oauth_handler"
  end
end
