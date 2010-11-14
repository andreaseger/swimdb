class Admins::RegistrationsController < ApplicationController
  prepend_before_filter :authenticate_scope!

  # GET /resource/edit
  def edit
  end

  # PUT /resource
  def update
    if @admin.update_with_password(params[:admin])
      #flash[:notice] = 'You updated your account successfully.'
      set_flash_message :notice, :updated
      sign_in @admin
      redirect_to after_sign_in_path_for(@admin)
      return
    else
      clean_up_passwords(@admin)
      render :action => 'edit'
    end
  end

  protected

    # Authenticates the current scope and gets a copy of the current resource.
    # We need to use a copy because we don't want actions like update changing
    # the current user in place.
    def authenticate_scope!
      authenticate_admin!
      @admin = current_admin
    end

    def clean_up_passwords(object) #:nodoc:
      object.clean_up_passwords if object.respond_to?(:clean_up_passwords)
    end

    def set_flash_message(key, kind, options={}) #:nodoc:
      options[:scope] = "devise.registrations"
      options[:default] = Array(options[:default]).unshift(kind.to_sym)
      options[:resource_name] = 'admin'
      flash[key] = I18n.t("admin.updated", options)
    end
end

