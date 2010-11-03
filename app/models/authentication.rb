class Authentication
  include Mongoid::Document
  referenced_in :user
  field :provider
  field :uid

  #for each provider the uid has to be unique
  validates_uniqueness_of :uid, :scope => :provider
  validates_uniqueness_of :provider, :scope => :user_id
  validates_presence_of :user_id

end

