require('sinatra')
require('sinatra/reloader')
require("pg")
require("sinatra/activerecord")
require('./lib/task')
require('./lib/list')
also_reload('lib/**/*.rb')

get("/") do
  @lists = List.all()
  erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end

post("/tasks") do
  description = params.fetch("description")
  @task = Task.new({:description => description, :done => false})
  if @task.save()
    erb(:success)
  else
    erb(:errors)
  end
end

post("/lists") do
  name = params.fetch("name")
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:index)
end
