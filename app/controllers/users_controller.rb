class UsersController < ApplicationController

  # GET: /signup
  get "/signup" do
    erb :"/users/signup.html"
  end

  # POST: /signup
  post "/signup" do
    @user = User.create(:username => params[:username], :email => params[:email])
    @user.save
    session[:user_id] = @user.id
    redirect "/users"
  end

  # GET: /login
  get "/login" do
    erb :"users/login.html"
  end

  # POST: /login
  post "/login" do
    user = User.find_by(:username => params[:username])
    if user != nil
      session[:user_id] = user.id
      redirect "/users"
    else
      redirect to "/signup"
    end
  end

  # GET: /logout
  get "/logout" do
    session.destroy
    redirect "/login"
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
