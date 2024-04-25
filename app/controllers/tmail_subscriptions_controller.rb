class TmailSubscriptionsController < ApplicationController
  before_action :set_tmail_subscription, only: %i[ show edit update destroy ]

  # GET /tmail_subscriptions or /tmail_subscriptions.json
  def index
    @tmail_subscriptions = TmailSubscription.all
  end

  # GET /tmail_subscriptions/1 or /tmail_subscriptions/1.json
  def show
  end

  # GET /tmail_subscriptions/new
  def new
    @tmail_subscription = TmailSubscription.new
  end

  # GET /tmail_subscriptions/1/edit
  def edit
  end

  # POST /tmail_subscriptions or /tmail_subscriptions.json
  def create
    @tmail_subscription = TmailSubscription.new(tmail_subscription_params)

    respond_to do |format|
      if @tmail_subscription.save
        format.html { redirect_to tmail_subscription_url(@tmail_subscription), notice: "Tmail subscription was successfully created." }
        format.json { render :show, status: :created, location: @tmail_subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tmail_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tmail_subscriptions/1 or /tmail_subscriptions/1.json
  def update
    respond_to do |format|
      if @tmail_subscription.update(tmail_subscription_params)
        format.html { redirect_to tmail_subscription_url(@tmail_subscription), notice: "Tmail subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @tmail_subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tmail_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tmail_subscriptions/1 or /tmail_subscriptions/1.json
  def destroy
    @tmail_subscription.destroy

    respond_to do |format|
      format.html { redirect_to tmail_subscriptions_url, notice: "Tmail subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tmail_subscription
      @tmail_subscription = TmailSubscription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tmail_subscription_params
      params.require(:tmail_subscription).permit(:employee_id)
    end
end
