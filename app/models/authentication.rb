class Authentication
  include MongoMapper::Document
  belongs_to :user
  key :provider, String
  key :uid, String

  #for each provider the uid has to be unique
  validates_uniqueness_of :uid, :scope => :provider
  validates_uniqueness_of :provider, :scope => :user_id
  validates_presence_of :user_id
end

