class Authentication
  include MongoMapper::Document
  belongs_to :user
  key :provider, String
  key :uid, String

  #for each provider the uid has to be unique
  validates_uniqueness_of :uid, :scope => :provider
end

