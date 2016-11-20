class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy, :join]
  before_action :set_backer, only: [:show, :new]

  def index
    @challenges = Challenge.all
  end

  def show
  end

  def new
    @challenge = Challenge.new
  end

  def edit
  end

  def join
    @backer = @challenge.backers.find_or_initialize_by(backer_params)

    if @backer.valid?
      capture_payment(
        @challenge,
        @backer,
        params[:stripeToken],
      )
    else
      render :show
    end
  end

  def capture_payment(challenge, backer, token)
    payment = Payment.create(
      challenge: challenge,
      amount: challenge.amount,
      backer: backer
    )

    customer = Stripe::Customer.create(
      email:  backer.email,
      source: token
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       (challenge.amount * 100).to_i,
      description:  'Rickshaw Run Sponsorship',
      currency:     'aud'
    )

    update_payment(charge, payment, backer, challenge)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    payment.update(
      status: 'failed',
      fail_reason: e
    )
    
    render :show
  end

  def update_payment(charge, payment, backer, challenge)
    if charge.status == 'succeeded'
      payment.update(status: 'paid')
      backer.save
      session[:backer_id] = backer.id
      redirect_to challenge, flash: { success: 'Thanks and stuff' }
    else
      payment.update(
        status: 'failed',
        fail_reason: charge.failure_message
      )
    end
  end

  def create
    @challenge = Challenge.new(challenge_params)

    if @challenge.valid?

      byebug

      capture_payment(
        @challenge,
        # @backer,  
        params[:stripeToken],
      )
      redirect_to @challenge, notice: 'Challenge was successfully created.'
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(
        :description,
        :amount,
        :status,
        backers_attributes: [
          :id,
          :name,
          :email
        ]
      )
    end

    def backer_params
      params.require(:backer).permit(:name, :email, :challenge_id)
    end

    def set_backer
    @backer = Backer.find_or_initialize_by(id: session[:backer_id])
    end
end
