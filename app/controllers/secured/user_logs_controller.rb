class Secured::UserLogsController < Secured::AuthorController
  before_action :set_secured_user_log, only: [:show, :edit, :update, :destroy]

  # GET /secured/user_logs
  # GET /secured/user_logs.json
  def index
    @secured_user_logs = Secured::UserLog.all
  end

  # GET /secured/user_logs/1
  # GET /secured/user_logs/1.json
  def show
  end

  # GET /secured/user_logs/new
  def new
    @secured_user_log = Secured::UserLog.new
  end

  # GET /secured/user_logs/1/edit
  def edit
  end

  # POST /secured/user_logs
  # POST /secured/user_logs.json
  def create
    @secured_user_log = Secured::UserLog.new(secured_user_log_params)

    respond_to do |format|
      if @secured_user_log.save
        format.html { redirect_to @secured_user_log, notice: 'User log was successfully created.' }
        format.json { render :show, status: :created, location: @secured_user_log }
      else
        format.html { render :new }
        format.json { render json: @secured_user_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /secured/user_logs/1
  # PATCH/PUT /secured/user_logs/1.json
  def update
    respond_to do |format|
      if @secured_user_log.update(secured_user_log_params)
        format.html { redirect_to @secured_user_log, notice: 'User log was successfully updated.' }
        format.json { render :show, status: :ok, location: @secured_user_log }
      else
        format.html { render :edit }
        format.json { render json: @secured_user_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /secured/user_logs/1
  # DELETE /secured/user_logs/1.json
  def destroy
    @secured_user_log.destroy
    respond_to do |format|
      format.html { redirect_to secured_user_logs_url, notice: 'User log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_secured_user_log
      @secured_user_log = Secured::UserLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def secured_user_log_params
      params.require(:secured_user_log).permit(:user_id)
    end
end
