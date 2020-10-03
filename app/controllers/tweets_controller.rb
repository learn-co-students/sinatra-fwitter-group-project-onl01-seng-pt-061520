class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in?
          @user = current_user
          @tweets = Tweet.all
          erb :'tweets/tweets'
        else
          redirect '/login'
        end
      end
    
    
      get '/tweets/new' do
        if logged_in?
          erb :'tweets/new'
        else
          redirect '/login'
        end
      end
    
      post '/tweets' do
        tweet = Tweet.new(content: params[:content], user: current_user)
        if tweet.save
          redirect '/tweets'
        else 
          redirect '/tweets/new'
        end
      end
    
      get '/tweets/:id' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'tweets/show'
        else
          redirect '/login'
        end
      end
    
      get '/tweets/:id/edit' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          erb :'tweets/edit'
        else
          redirect '/login'
        end
      end
    
      patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if params[:content].empty? 
          redirect "/tweets/#{@tweet.id}/edit" 
        else
          @tweet.content = params[:content] 
          @tweet.save
          redirect "/tweets/#{@tweet.id}"
        end
      end
    
      delete '/tweets/:id/delete' do 
        if logged_in?
          @tweet = Tweet.find(params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.destroy
          end
          redirect '/tweets'
        else
          redirect '/login'
        end
    end
end
