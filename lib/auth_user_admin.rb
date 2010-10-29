module AuthUserAdmin

  def auth_user_admin!
    unless admin_signed_in?
      warden.authenticate!(:scope => :user)
    end
  end
end

