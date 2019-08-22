require 'rack-flash'

class ToysController < ApplicationController
  enable :sessions
  use Rack::Flash

  # GET: /toys
  get "/toys" do
    redirect_if_not_logged_in
    @toys = Toy.all
    erb :"/toys/index.html"
  end

  # GET: /toys/new
  get "/toys/new" do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :"/toys/new.html"
  end

  # POST: /toys
  post "/toys" do
    if !params[:name].blank?
      @user = User.find_by_id(session[:user_id])
      @toy = Toy.create(params[:toy])
      @user.toys << @toy
      redirect "toys/#{@toy.slug}"
    else
      flash[:message] = "** Name may not be blank **"
      redirect "/toys/new"
    end
  end

  # GET: /toys/5
  get "/toys/:slug" do
    redirect_if_not_logged_in
    @toy = Toy.find_by_slug(params[:slug])
    erb :"/toys/show.html"
  end

  # GET: /toys/5/edit
  get "/toys/:slug/edit" do
    redirect_if_not_logged_in
    @toy = Toy.find_by_slug(params[:slug])
    if @toy.user == current_user
      erb :"/toys/edit.html"
    else
      flash[:message] = "** You may not edit another user's entry **"
      redirect "toys/#{@toy.slug}"
    end
  end

  # PATCH: /toys/5
  patch "/toys/:slug" do
    @toy = Toy.find_by_slug(params[:slug])
    if @toy.user == current_user && !params[:toy][:name].blank?
      @toy.update(params[:toy])
      redirect "toys/#{@toy.slug}"
    elsif params[:toy][:name].blank?
      flash[:message] = "** Name may not be blank **"
      redirect "toys/#{@toy.slug}/edit"
    else
      flash[:message] = "** You may not edit another user's entry **"
      redirect "toys/#{@toy.slug}"
    end
  end

  # DELETE: /toys/5/delete
  delete "/toys/:slug/delete" do
    @toy = Toy.find_by_slug(params[:slug])
    if @toy.user == current_user
      @toy.delete
      redirect "/toys"
    else
      flash[:message] = "** You may not delete another user's entry **"
      redirect "toys/#{@toy.slug}"
    end
  end

end
