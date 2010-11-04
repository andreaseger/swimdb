class Authentication
  include Mongoid::Document
  referenced_in :user
  field :provider
  field :uid

  field :uid_provider
  field :provider_user

  before_validation :set_composite_fields

  #index( [ [:provider, Mongo::ASCENDING],
  #         [:uid, Mongo::ASCENDING] ],
  #    :unique => true )
  #index( [ [:provider, Mongo::ASCENDING],
  #         [:user_id, Mongo::ASCENDING] ],
  #    :unique => true )
  #for each provider the uid has to be unique
  #validates_uniqueness_of :uid, :scope => :provider
  #validates_uniqueness_of :provider, :scope => :user_id
  validates_uniqueness_of :uid_provider, :provider_user
  validates_presence_of :user_id


  def set_composite_fields
    self.uid_provider = "#{uid}#{provider}"
    self.provider_user = "#{provider}#{user_id}"
  end
end

