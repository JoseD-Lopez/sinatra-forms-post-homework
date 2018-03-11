class PostsController < Sinatra::Base

  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  
  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") } 

  configure :development do
      register Sinatra::Reloader
  end

def store_name(filename, string)
  File.open(filename, "a+") do |file|
    file.puts(string)
  end
end

def read_names
  return [] unless File.exist?("names.txt")
  File.read("names.txt").split("\n")
end

get "/namentry" do
  @name = params["name"]
  @names = read_names
  erb :namentry
end

post "/namentry" do
  @name = params["name"]
  store_name("names.txt", @name)
  redirect "/namentry?name=#{@name}"
end

end