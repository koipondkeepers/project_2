module Sinatra
  class Server < Sinatra::Base
    db = PG.connect(dbname: 'project_2')

    get "/" do
      @projects = db.exec("SELECT * FROM projects")
      erb :index
    end

    get "/projects/:id" do
      @id = params[:id]
      @project = db.exec("SELECT * FROM projects WHERE id=#{@id}").first
      erb :project
    end

    post '/projects' do
      @comment = params[:comment]
      db.exec_params("INSERT INTO comments (project_id, content) VALUES($1,$2)", [@title,@comment])
      erb :project
    end

    get "/makeProject" do
      erb :makeProject
    end

    post '/makeProject' do
      @title = params[:title]
      @description = params[:description]
      @url = "http://#{params[:url]}"
      db.exec_params("INSERT INTO projects (title, description, url) VALUES($1,$2,$3)", [@title,@description,@url])
      @submitted = true
      erb :makeProject
    end





  end
end
