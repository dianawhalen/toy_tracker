class DesignersController < ApplicationController

  # GET: /designers
  get "/designers" do
    erb :"/designers/index.html"
  end

  # GET: /designers/new
  get "/designers/new" do
    erb :"/designers/new.html"
  end

  # POST: /designers
  post "/designers" do
    redirect "/designers"
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
