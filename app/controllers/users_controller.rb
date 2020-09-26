class UsersController < ApplicationController

  get '/' do 
    erb :index
  end 
  
  post '/start' do 
    # binding.pry 
    if params[:choice] == "Login"
      redirect to '/login'
    elsif params[:choice] == "Sign Up"
      redirect to '/signup'
      
    end 
  end 

  get '/login' do 
    if logged_in?
      redirect to '/tweets'
    else 
      erb :'users/login'
    end 
  end 
  
  get '/signup' do
    # binding.pry
    erb :'users/create_user'
  end 
  
  post '/signup' do 
    user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
		if user.save 
		  redirect "/login"
		else 
		  @a = ["Invalid credentials. Please try again."]
		  erb :'users/create_user'
		end 
  end 
  
  post '/login' do 
    user = User.find_by(:username => params[:username])
    # binding.pry
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect to '/tweets'
		else 
		  @a = ["Invalid credentials. Please try again."]
		  erb :'users/login'
		end 
  end 
  
  get '/users/logout' do 
    session.clear 
    redirect to '/'
  end 
  
  
  
end

