require "pry"

helpers do 
  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
end


# Homepage (Root path)
get "/" do
  erb :index
end

get "/signup" do
  erb :signup
end

post "/signup" do

  first_name = params[:first_name]
  last_name = params[:last_name]
  username = params[:username]
  email = params[:email]
  password = params[:password]
  password_confirmation = params[:password_confirmation]
  gender = params[:gender]
  country = params[:country]

  if password == password_confirmation
    user = User.find_by(first_name: first_name, last_name: last_name, username: username, email: email, password: password, gender: gender, country: country)
    if user
      redirect "/login"

    else 
      user = User.create(first_name: first_name, last_name: last_name, username: username, email: email, password: password, gender: gender, country: country)
      session[:user_id] = user.id
      redirect "/"
    end
  end
end

get "/login" do
  erb :login
end

post "/login" do

  username = params[:username]
  password = params[:password]

  user = User.where(username: username, password: password).first
  if user
    session[:user_id] = user.id
    redirect "/"
  else
    erb :signup
  end
end

get "/logout" do
  session.clear
  redirect "/login"
end


get "/movies/new" do
  erb :'movies/new'
end

post "/movies/new" do
  title = params[:title]
  year = params[:year]
  gross = params[:gross]
  poster = params[:poster]
  trailer = params[:trailer]

  if title && year && gross && poster && trailer
    movie = Movie.find_by(title: title)
    if movie
      redirect :'/movies/new'
    end
  elsif
    erb :'/movies/new'
  
    
  else
    movie = Movie.new(title: title, year: year, gross: gross, poster: poster, trailer: trailer)
    if movie.save  
    redirect "/movies/#{movie.id}" 
    end


    end   
end




get "/movies/:id" do
  @movie = Movie.find(params[:id])
  erb :'movies/movie'
end











