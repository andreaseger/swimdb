class User::RegistrationsController < Devise::RegistrationsController
  private
  def build_resource(*args)
    super
    if data = session["devise.facebook_data"]
      @user.apply_omniauth(data)
      @user.valid?
    end
  end
end

