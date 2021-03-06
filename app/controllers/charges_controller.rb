class ChargesController < ActionController::Base

  before_action :validate_role

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

  def validate_role
    if current_user
      if current_user.role == 'standard'
        true
      else
        redirect_to user_path(current_user)
        flash[:error] = "#{current_user.name} is already a Premium Member"
      end
    else
      redirect_to new_user_session_path
      flash[:notice] = "You must be signed in to perform that action"
    end
  end

end
