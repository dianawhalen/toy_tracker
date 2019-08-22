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
      flash[:message] = "** Fields may not be blank **"
      redirect "/signup"
    elsif User.find_by(:username => params[:username])
      flash[:message] = "** Username already exists — Please choose another **"
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    end
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
    elsif @user
      flash[:message] = "Incorrect password!! Try again."
      redirect "/login"
    else
      redirect "/signup"
    end
  end

  # GET: /account
  get "/account" do
    redirect_if_not_logged_in
    @user = current_user
    erb :"/users/account.html"
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
    redirect_if_not_logged_in
    @users = User.all
    erb :"/users/index.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:slug" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:slug/edit" do
    redirect_if_not_logged_in
    @user = User.find_by_slug(params[:slug])
    if @user == current_user
      erb :"/users/edit.html"
    else
      flash[:message] = "** You may not edit another user's profile **"
      redirect "users/#{@user.slug}"
    end
  end

  # PATCH: /users/5
  patch "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    if params[:user][:username].blank?
      flash[:message] = "** Username may not be blank **"
      redirect "users/#{@user.slug}/edit"
    elsif User.find_by(:username => params[:user][:username])
      flash[:message] = "** Username already exists — Please choose another **"
      redirect "users/#{@user.slug}/edit"
    elsif @user == current_user && !params[:user][:username].blank?
      @user.update(params[:user])
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "** You may not edit another user's profile **"
      redirect "users/#{@user.slug}"
    end
  end

  # DELETE: /users/5/delete
  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    if @user != current_user
      redirect "/users/#{@user.slug}"
    else
      @user.toys.each {|toy| toy.delete }
      @user.delete
      session.destroy
      redirect "/"
    end
  end

end
