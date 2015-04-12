class ChargesController < ActionController::Base

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Account - #{current_user.name}",
      amount: default_amount
    }
  end

  def create
    #Set default ammount to $15 for Premium Account
    @amount = 15_00 
    customer = Stripe::Customer.create(
      email: current_user.email,
      card:  params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: default_amount,
      description: "Premium Account - #{current_user.email}",
      currency: 'usd'
    )

    # flash[:success] = "#{current_user.email}, is now a Premium Member!"
    current_user.upgrade_account
    redirect_to user_path(current_user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  def default_amount
    amount = 15_00
    amount
  end

end