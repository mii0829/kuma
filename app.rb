require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'

before do
    Dotenv.load
    Cloudinary.config do |config|
        config.cloud_name = ENV['CLOUD_NAME']
        config.api_key = ENV['CLOUDINARY_API_KEY']
        config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end
end

get '/' do
    @contents = Contribution.all.order('id desc')
    erb :index
end

post '/new' do
    img_url = ' '
    img1_url = ' '
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
    if params[:file1]
        img1 = params[:file1]
        tempfile1 = img1[:tempfile]
        upload1 = Cloudinary::Uploader.upload(tempfile1.path)
        img1_url = upload1['url']
    end
    
     logger.info "yuruyuru"
     logger.info img_url
    logger.info img1_url
    
    Contribution.create({
        name: params[:user_name],
        body: params[:body],
        img: img_url,
        img1: img1_url,
        genre: params[:genre],
        group: params[:group],
        birth: params[:birth]
    })
    redirect '/'
end

post '/delete/:id' do
    Contribution.find(params[:id]).destroy
    redirect '/'
end

get '/edit/:id' do
    @content = Contribution.find(params[:id])
    erb :edit
end

post '/renew/:id' do
    img_url = ' '
    img1_url = ' '
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
    if params[:file1]
        img1 = params[:file1]
        tempfile = img1[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img1_url = upload['url']
    end
    
   
    
    content = Contribution.find(params[:id])
    content.update({
        name: params[:user_name],
        body: params[:body],
        genre: params[:genre],
        group: params[:group],
        birth: params[:birth],
        img: img_url,
        img1: img1_url
    })
    redirect '/'
end
