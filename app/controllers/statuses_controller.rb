class StatusesController < ApplicationController
  before_action :set_status, only: %i[ show edit update destroy ]

  # GET /statuses/1 or /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @employee = current_employee
    @status = Status.new(status_params)
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses or /statuses.json
  def create
    if current_employee.status.nil?
      @status = Status.new(employee_id: current_employee.id)

    else
      @status = current_employee.status
      @status.update(text: params[:text]) # Assuming 'text' is the parameter you want to update
    end
  
  
    if @status.save
      # Handle successful save
      redirect_to employee_path(@status.employee_id)
    else
      # Handle validation errors
      render :new, status: :unprocessable_entity
    end
  end  

  # PATCH/PUT /statuses/1 or /statuses/1.json
  def update
    respond_to do |format|
      if @status.update(status_params)
        respond_to do |format|
          format.html { redirect_to employee_url(@status.employee_id), notice: "Status was successfully updated." }
          format.json { render :show, status: :ok, location: @status }
        end
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1 or /statuses/1.json
  def destroy
    @status.destroy

    respond_to do |format|
      format.html { redirect_to statuses_url, notice: "Status was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_status
    @status = Status.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def status_params
    params.require(:status).permit(:text, :employee_id)
  end
end
