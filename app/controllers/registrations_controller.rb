class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(user)
      user_path(user)
    end

    # def after_destroy_path_for(user)
    #   concert_halls_path
    # end
end
