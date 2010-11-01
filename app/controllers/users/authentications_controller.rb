class Users::AuthenticationsController < InheritedResources::Base
  include AuthUserAdmin
  actions :index, :destroy
  before_filter :auth_user_admin!, :only => [:edit, :update, :destroy]
  #before_filter :authenticate_user!

  def create
    case params[:provider]
    when 'facebook', 'twitter'
      oauth
    else
      render :text => request.env["omniauth.auth"].to_yaml
    end
  end

  def edit
    if admin_signed_in?
      # if admin show me the authentications of the choosen user
      @user = User.find(params[:id])
      @authentications = @user.authentications
    else
      # else show them of the current_user
      @authentications = current_user.authentications
    end
  end

  def destroy
    destroy!{edit_users_authentication_path}
  end

  private

  def oauth
    # You need to implement the method below in your model
    data = request.env["omniauth.auth"]
    @user = User.find_for_oauth(data, current_user)

    # reditect to the profile if the user was logged in
    if current_user
      redirect_to edit_users_authentication_path(current_user)
      return
    end
    #else login or redirect to the signup page
    provider = data["provider"]
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
      sign_in_and_redirect @user
    else
      session["devise.#{provider}_data"] = case provider
      when 'facebook'
        data
      when 'twitter'
        data.except('extra')
      end
      redirect_to new_user_registration_url
    end
  end
end

