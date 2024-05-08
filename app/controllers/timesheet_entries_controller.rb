class TimesheetEntriesController < ApplicationController
  before_action :authenticate_employee!, only: %i[show edit update destroy]
  before_action :set_timesheet_entry, only: %i[show edit update destroy]

  # GET /timesheet_entries or /timesheet_entries.json
  def index
    @timesheet_entries = TimesheetEntry.all
  end

  # GET /timesheet_entries/1 or /timesheet_entries/1.json
  def show
    @employee = @timesheet_entry.employee
    @now = Time.now
  end

  # GET /timesheet_entries/new
  def new
    @employee = current_employee
    @timesheet_entry = @employee.timesheet_entries.last
    if @timesheet_entry&.ended_at.nil?
      @timesheet_entry.update(ended_at: params[:ended_at])
    else
      @timesheet_entry = TimesheetEntry.new(timesheet_entry_params)
    end
  end

  # GET /timesheet_entries/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js { } # This will render edit.js.erb
    end
  end

  # POST /timesheet_entries or /timesheet_entries.json
  def create
    @employee = current_employee
    @timesheet_entry = @employee.timesheet_entries.last

    if @timesheet_entry && @timesheet_entry.ended_at.nil?
      @timesheet_entry.update(ended_at: params[:timesheet_entry][:ended_at])
    else
      @timesheet_entry = TimesheetEntry.new(timesheet_entry_params)
    end

    respond_to do |format|
      if @timesheet_entry.save
        Status.create!(employee_id: @employee.id, text: "Available")
        now = Time.now.strftime("%I:%M %p") # Store the formatted time in the now variable
        format.html { redirect_to employee_path(@employee), notice: "You have clocked in at #{now}" }
        format.json { render :show, status: :created, location: @timesheet_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @timesheet_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timesheet_entries/1 or /timesheet_entries/1.json
  def update
    respond_to do |format|
      if @timesheet_entry.update(timesheet_entry_params)
        now = Time.now.strftime("%I:%M %p")
        format.html { redirect_to employee_path(@employee), notice: "You have clocked out at #{now}." }
        format.js { } # This will render update.js.erb
      else
        format.html { render :edit }
      end
    end
    @employee.calculate_hours_worked
  end

  # DELETE /timesheet_entries/1 or /timesheet_entries/1.json
  def destroy
    @timesheet_entry.destroy

    respond_to do |format|
      format.html { redirect_to timesheet_entries_url, notice: "Timesheet entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_timesheet_entry
    @timesheet_entry = TimesheetEntry.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def timesheet_entry_params
    params.require(:timesheet_entry).permit(:employee_id, :started_at, :ended_at, :hours_worked, :comments,
                                            :entry_approval_status, :pay_period_id)
  end
end
