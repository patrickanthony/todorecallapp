require 'rubygems'
require 'sinatra'
require 'datamapper'
require 'thin'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :completed, Text, :required => true, :default => false
  property :created at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @notes = Note.all :order => :id.desc
  @title = 'All Notes'
  erb :home
end


