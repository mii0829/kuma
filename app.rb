require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development? 
require 'open-uri'
require 'sinatra/json'
require './models.rb'

before do
    Dotenv.load
    Cloudinary.config do |config|
        config.cloud_name = ENV['CLOUD_NAME']
        config.api_key = ENV['CLOUDINARY_API_KEY']
        config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end
end

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get '/' do
    erb :sign_in
end

get '/signup' do
    erb :sign_up
end

post '/signup' do
    # grade_id も追加する
    user = User.create(
        name: params[:name],
        mail: params[:mail],
        grade_id: params[:grade_id],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    )
    if user.persisted?
        session[:user] = user.id
        redirect '/'
    else
       "ユーザー登録に失敗しました" 
    end
end

get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(mail: params[:mail])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
        redirect '/subjects'
    else
       "ログインに失敗しました" 
    end
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end

get '/subjects' do
    erb :subjects
end

post '/subjects' do
    
end

@subject_id = 0
get '/board' do
    subject_id = params['id']
    @subject_id = subject_id
    @subject = Subject.find(subject_id)
    
    # データベースから subject_key を使用して教科の情報を取得する
    # @hoge のようなインスタンス変数に値を代入して、 erb ファイルで表示する
     @contents = Question.where(subject_id: subject_id).order('id desc')
     #puts "========================"
     #puts @contents[0].tags[0].name
     #puts "========================"
     
    erb :board
end

post '/new' do
    img_url = ''
    if params[:file]
        img = params[:file]
        tempfile = img[:tempfile]
        upload = Cloudinary::Uploader.upload(tempfile.path)
        img_url = upload['url']
    end
    
   question = Question.create({
        user_id: current_user.id,
        body: params[:body],
        image: img_url,
        subject_id: params[:subject_id],
    })
    question.tags.create(name: params[:tag])

    link = "/board?id=#{params[:subject_id]}"
    redirect link
end