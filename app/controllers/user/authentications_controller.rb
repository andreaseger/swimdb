class User::AuthenticationsController < ApplicationController

  def index
  end

  def create
    case params[:provider]
    when 'facebook', 'twitter'
      oauth
    else
      render :text => request.env["omniauth.auth"].to_yaml
    end
  end

  def destroy
  end

  def edit
    @authentications = current_user.authentications
  end

  private
  def oauth
    # You need to implement the method below in your model
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    provider = env["omniauth.auth"]["provider"]
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
      sign_in_and_redirect @user#, :event => :authentication
    else
      session["devise.#{provider}_data"] = env["omniauth.auth"]#.except('extra')
      redirect_to new_user_registration_url
    end
  end
end

