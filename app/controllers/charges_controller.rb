class ChargesController < ApplicationController
  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => '"A month\'s subscription - #{current_user.email}',
      :currency    => 'usd'
    )

    current_user.upgrade_to_premium
    flash[:success] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
    redirect_to edit_user_registration_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia membership - #{current_user.name}",
      amount: 500
    }
  end
end
