class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params.except(:photo))

    if params[:user][:photo].present?
      uploaded_photo = Cloudinary::Uploader.upload(
        params[:user][:photo],
        folder: "boutbuddy/fighters",
        transformation: [
          { effect: "remove_background" },
          { gravity: "person", aspect_ratio: "2:3", crop: "fill" }
        ]
      )
      resource.photo = uploaded_photo['secure_url']
    end

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = if params[:user][:photo].present?
                        uploaded_photo = Cloudinary::Uploader.upload(
                          params[:user][:photo],
                          folder: "boutbuddy/fighters",
                          transformation: [{ effect: "remove_background" },
                          { gravity: "person", aspect_ratio: "2:3", crop: "fill" }
                          ]
                        )
                        update_resource(resource, account_update_params.except(:photo).merge(photo: uploaded_photo['secure_url']))
                      end
    yield resource if block_given?
    if resource_updated
      set_flash_message_for_update(resource, prev_unconfirmed_email)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :weight, :reach, :height, :username, :role, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :weight, :reach, :height, :username, :role, :password, :password_confirmation, :current_password])
  end
end
