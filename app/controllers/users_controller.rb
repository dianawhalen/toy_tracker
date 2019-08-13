require 'rack-flash'

class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  # GET: /signup
  get "/signup" do
    if logged_in?
      redirect "/toys"
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

  # GET: /account
  get "/account" do
    if logged_in?
      @user = current_user
      erb :"/users/account.html"
    else
      redirect "/login"
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

  # GET: /users/5
  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /users/5/edit
  get "/users/:slug/edit" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user == current_user
        erb :"/users/edit.html"
      else
        flash[:message] = "You cannot edit another user's profile."
      end
    else
      redirect "/login"
    end
  end

  # PATCH: /users/5
  patch "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    @user.update(params[:user])
    redirect "/users/#{@user.slug}"
  end

  # DELETE: /users/5/delete
  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      flash[:message] = "You cannot delete another user's Profile."
    else
      @user.delete
      redirect "/"
    end
  end

end
