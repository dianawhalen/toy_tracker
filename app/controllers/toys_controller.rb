class ToysController < ApplicationController

  # GET: /toys
  get "/toys" do
    @toys = Toy.all
    if logged_in?
      erb :"/toys/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /toys/new
  get "/toys/new" do
    @user = User.find_by_id(session[:user_id])
    if logged_in?
      erb :"/toys/new.html"
    else
      redirect "/login"
    end
  end

  # POST: /toys
  post "/toys" do
    @toy = Toy.create(params[:toy])
    binding.pry
    redirect "toys/#{@toy.slug}"
  end

  # GET: /toys/5
  get "/toys/:slug" do
    @toy = Toy.find_by_slug(params[:slug])
    erb :"/toys/show.html"
  end

  # GET: /toys/5/edit
  get "/toys/:slug/edit" do
    @toy = Toy.find_by_slug(params[:slug])
    erb :"/toys/edit.html"
  end

  # PATCH: /toys/5
  patch "/toys/:slug" do
    @toy = Toy.find_by_slug(params[:slug])
    if params[:designer][:name].empty?
      @toy.update(params[:toy])
    else
      @new_designer = Designer.create(params[:designer])
      @toy.update(name: params[:toy][:name], designer: @new_designer)
    end
    redirect "toys/#{@toy.slug}"
  end

  # DELETE: /toys/5/delete
  delete "/toys/:slug/delete" do
    @toy = Toy.find_by_slug(params[:slug])
    @toy.delete
    redirect "/toys"
  end

end
