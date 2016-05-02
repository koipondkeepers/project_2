module Sinatra
  class Server < Sinatra::Base
    db = PG.connect(dbname: 'project_2')

    get "/" do
      @projects = db.exec("SELECT * FROM projects")
      erb :index
    end

    post "/votes" do
      @id = params[:id].to_i
      @votes = params[:votes].to_i + 1
      db.exec("UPDATE projects SET votes =#{@votes} WHERE id = #{@id}").first
      redirect to ("/")
    end

    get "/projects/:id" do
      @id = params[:id]
      @project = db.exec("SELECT * FROM projects WHERE id=#{@id}").first
      @comments = db.exec("SELECT * FROM comments WHERE project_id=#{@id}")
      erb :project
    end

    post "/comments" do
      @comment = params[:comment]
      @project_id = params[:project_id].to_i
      db.exec_params("INSERT INTO comments (project_id, content) VALUES($1,$2)", [@project_id,@comment])
      redirect to ("/projects/#{@project_id}")
      #erb :project
    end

    get "/makeProject" do
      erb :makeProject
    end

    post "/makeProject" do
      @title = params[:title]
      @description = params[:description]
      @url = "http://#{params[:url]}"
      db.exec_params("INSERT INTO projects (title, description, url) VALUES($1,$2,$3)", [@title,@description,@url])
      @submitted = true
      erb :makeProject
    end





  end
end
