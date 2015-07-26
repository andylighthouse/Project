# require "pry"

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
    redirect "/signup"
  end
end














