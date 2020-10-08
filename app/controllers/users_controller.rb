class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
          redirect '/tweets'
        else
          erb :'users/signup'
        end
      end

    post "/signup" do
        user = User.new(:username => params[:username],:email => params[:email], :password => params[:password])
            if user.save
                session[:user_id] = user.id
                redirect "/tweets"
              else
                redirect "/signup"
            end
      end

      get '/login' do
        if logged_in?
          redirect '/tweets'
        else
          erb :'users/login'
        end
      end

    post "/login" do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end 
    end

    get '/logout' do
        if logged_in?
          session.clear
          redirect to '/login'
        else 
          redirect '/'
        end
      end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @tweets = @user.tweets
        erb :'tweets/tweets'
      end

end
