class User::AuthenticationsController < InheritedResources::Base
  actions :index, :destroy
  def create
    case params[:provider]
    when 'facebook', 'twitter'
      oauth
    else
      render :text => request.env["omniauth.auth"].to_yaml
    end
  end

  def edit
    @authentications = current_user.authentications
  end

  private
  def oauth
    # You need to implement the method below in your model
    @user = User.find_for_oauth(env["omniauth.auth"], current_user)
    # reditect to the profile if the user was logged in
    if current_user
      redirect_to edit_user_authentication_path(current_user)
      return
    end
    #else login or redirect to the signup page
    provider = env["omniauth.auth"]["provider"]
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
      sign_in_and_redirect @user#, :event => :authentication
    else
      session["devise.#{provider}_data"] = case provider
      when 'facebook'
        env["omniauth.auth"]#.except('extra')
      when 'twitter'
        env["omniauth.auth"].except('extra')
      end
      redirect_to new_user_registration_url
    end
  end
end

