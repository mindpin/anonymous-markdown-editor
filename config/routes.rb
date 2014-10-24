Rails.application.routes.draw do
  resources :documents, path: "/" do
    member do
      get ":version",
          to: "documents#version",
          as: :version
    end
  end

  resources :images
end
