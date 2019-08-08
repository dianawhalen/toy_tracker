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
  get "/designers/:id" do
    erb :"/designers/show.html"
  end

  # GET: /designers/5/edit
  get "/designers/:id/edit" do
    erb :"/designers/edit.html"
  end

  # PATCH: /designers/5
  patch "/designers/:id" do
    redirect "/designers/:id"
  end

  # DELETE: /designers/5/delete
  delete "/designers/:id/delete" do
    redirect "/designers"
  end
end
