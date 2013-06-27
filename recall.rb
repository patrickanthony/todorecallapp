require 'rubygems'
require 'sinatra'
require 'data_mapper'
require 'thin'
require 'sqlite3'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
  @notes = Note.all :order => :id.desc
  @title = 'All Notes'
  erb :home
end


