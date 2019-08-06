class ToysController < ApplicationController

  # GET: /toys
  get "/toys" do
    @toys = Toy.all
    if session[:user_id]
      erb :"/toys/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /toys/new
  get "/toys/new" do
    erb :"/toys/new.html"
  end

  # POST: /toys
  post "/toys" do
    @toy = Toy.create(name: params[:toy][:name], edition: params[:toy][:edition], designer: Designer.find_or_create_by(name: params[:designer][:name]))
    redirect "toys/#{@toy.slug}"
  end

  get "/toys/:slug" do
    @toy = Toy.find_by_slug(params[:slug])
    erb :"/toys/show.html"
  end

  # GET: /toys/5
  get "/toys/:id" do
    erb :"/toys/show.html"
  end

  # GET: /toys/5/edit
  get "/toys/:id/edit" do
    erb :"/toys/edit.html"
  end

  # PATCH: /toys/5
  patch "/toys/:id" do
    redirect "/toys/:id"
  end

  # DELETE: /toys/5/delete
  delete "/toys/:id/delete" do
    redirect "/toys"
  end
end
