class UsersController < ApplicationController

  # GET: /users/5
  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /signup
  get "/signup" do
    if logged_in?
      redirect "toys"
    else
      erb :"/users/signup.html"
    end
  end

  # POST: /signup
  post "/signup" do
    if params[:username].blank? || params[:email].blank? || params[:password].blank?
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end
    @user.save
    session[:user_id] = @user.id
    redirect "/users/#{@user.slug}"
  end

  # GET: /login
  get "/login" do
    if logged_in?
      redirect "/toys"
    else
      erb :"users/login.html"
    end
  end

  # POST: /login
  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/toys"
    else
      redirect "/signup"
    end
  end

  # GET: /profile
  get "/profile" do
    @current_user = User.find_by_id(session[:user_id])
    if @current_user
      redirect "/users/#{@current_user.id}"
    else
      redirect "/users"
    end
  end

  # GET: /logout
  get "/logout" do
    if logged_in?
      session.destroy
      redirect "/login"
    else
      redirect "/"
    end
  end

  # GET: /users
  get "/users" do
    if logged_in?
      @users = User.all
      erb :"/users/index.html"
    else
      redirect "/login"
    end
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    if session[:user_id]
      erb :"/users/edit.html"
    else
      redirect "/login"
    end
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
