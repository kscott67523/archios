class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy]

  # GET /requests or /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1 or /requests/1.json
  def show
    @request.status
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  # POST /requests or /requests.json
  # POST /requests or /requests.json
  # POST /requests or /requests.json
  def create
    # Parse JSON data from request body
    request_data = JSON.parse(request.body.read)

    # Extract email and request body from request data
    email = request_data["From"]
    request_body = request_data["TextBody"]

    # Find employee by email
    employee = Employee.find_by(email: email)

    if employee.present?
      # Create a request
      request = Request.create(email: email, request_body: request_body)

      if request.persisted?
        # Redirect based on employee's last entry
        if employee.clocked_in?
          employee.last_entry.update(ended_at: Time.now)
        else
          TimesheetEntry.create!(
            employee_id: employee.id,
            started_at: Time.now,
            pay_period_id: PayPeriod.current.id,
          )
        end
        render json: { message: "Request processed successfully and timesheet entry created" }, status: :ok
      else
        render json: { error: "Failed to create request" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Employee not found for the given email" }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def request_params
    params.require(:request).permit(:email, :request_body)
  end
end
