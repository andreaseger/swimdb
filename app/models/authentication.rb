class Authentication
  include Mongoid::Document
  referenced_in :user
  field :provider
  field :uid

  #index( [ [:provider, Mongo::ASCENDING],
  #         [:uid, Mongo::ASCENDING] ],
  #    :unique => true )
  #index( [ [:provider, Mongo::ASCENDING],
  #         [:user_id, Mongo::ASCENDING] ],
  #    :unique => true )
  #for each provider the uid has to be unique
  validates_uniqueness_of :uid, :scope => :provider
  validates_uniqueness_of :provider, :scope => :user_id
  validates_presence_of :user_id

end

