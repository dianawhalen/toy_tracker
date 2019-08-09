class DesignersController < ApplicationController

  # GET: /designers
  get "/designers" do
    @designers = Designer.all
    erb :"/designers/index.html"
  end

  # GET: /designers/new
  get "/designers/new" do
    @toys = Toy.all
    erb :"/designers/new.html"
  end

  # POST: /designers
  post "/designers" do
    @designer = Designer.create(name: params[:designer][:name])
    @designer.save
    slug = @designer.slug
    redirect "designers/#{@designer.slug}"
  end

  # GET: /designers/5
  get "/designers/:slug" do
    @designer = Designer.find_by_slug(params[:slug])
    erb :"/designers/show.html"
  end

  # GET: /designers/5/edit
  get "/designers/:slug/edit" do
    erb :"/designers/edit.html"
  end

  # PATCH: /designers/5
  patch "/designers/:slug" do
    redirect "/designers/:slug"
  end

  # DELETE: /designers/5/delete
  delete "/designers/:slug/delete" do
    redirect "/designers"
  end
end
