class UsersController < ApplicationController

  # GET: /signup
  get "/signup" do
    erb :"/users/new.html"
  end

  # POST: /signup
  post "/signup" do
    "Signed Up"
    binding.pry
  end

  # GET: /login
  get "/login" do
    erb :"users/login.html"
  end

  # POST: /login
  post "/login" do
    "Logged In"
  end

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
