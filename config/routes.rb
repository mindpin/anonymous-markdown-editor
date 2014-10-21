Rails.application.routes.draw do
  resources :documents, path: "/" do
    member do
      get "version/:version",
          to: "documents#version",
          as: :version
    end
  end
end
