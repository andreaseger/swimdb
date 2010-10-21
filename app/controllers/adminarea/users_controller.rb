class Adminarea::UsersController < InheritedResources::Base
  before_filter :authenticate_admin!
  actions :all, :except => [ :new, :create ]
  def index
    @users = User.all
  end

  def update
    #delete the password field if empty => it will stay unchanged
    params[:user].delete(:password) if params[:user][:password]==""
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation]==""
    update!
  end

end

