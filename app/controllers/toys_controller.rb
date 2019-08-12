require 'rack-flash'

class ToysController < ApplicationController
  enable :sessions
  use Rack::Flash

  # GET: /toys
  get "/toys" do
    if logged_in?
      @toys = Toy.all
      erb :"/toys/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /toys/new
  get "/toys/new" do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      erb :"/toys/new.html"
    else
      redirect "/login"
    end
  end

  # POST: /toys
  post "/toys" do
    @user = User.find_by_id(session[:user_id])
    @toy = Toy.create(params[:toy])
    @user.toys << @toy
    redirect "toys/#{@toy.slug}"
  end

  # GET: /toys/5
  get "/toys/:slug" do
    if logged_in?
      @toy = Toy.find_by_slug(params[:slug])
      erb :"/toys/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /toys/5/edit
  get "/toys/:slug/edit" do
    @toy = Toy.find_by_slug(params[:slug])
    if @toy.user == current_user
      erb :"/toys/edit.html"
    else
      flash[:message] = "You cannot edit another user's Toy entry."
      # redirect "toys/#{@toy.slug}"
    end
  end

  # PATCH: /toys/5
  patch "/toys/:slug" do
    @toy = Toy.find_by_slug(params[:slug])
    @toy.update(params[:toy])
    redirect "toys/#{@toy.slug}"
  end

  # DELETE: /toys/5/delete
  delete "/toys/:slug/delete" do
    @toy = Toy.find_by_slug(params[:slug])
    if @toy.user != current_user
      flash[:message] = "You cannot delete another user's Toy entry."
    else
      @toy.delete
      redirect "/toys"
    end
  end

end
