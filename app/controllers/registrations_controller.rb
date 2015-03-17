class RegistrationsController < Devise::RegistrationsController

  # GET /resource/edit
  def edit
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia membership - #{current_user.first_name}",
      amount: 500
    }
    super
  end
end
