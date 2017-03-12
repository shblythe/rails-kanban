class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :change]

  # GET /tasks
  # GET /tasks.json

  def tasks_eisen_pending_count
    tasks = Task.all
    eisen_pending = tasks.where("state='open' AND urgent is null and important is null")
    print "************* Eisen pending: ",eisen_pending.count
    return eisen_pending.count
  end
  helper_method :tasks_eisen_pending_count
  
  def index
    @tasks = Task.all
    @open = @tasks.where(state:"open").sort_by &:eisenhower_sort_index
    @wip = @tasks.where(state:"wip").sort_by &:eisenhower_sort_index
    @closed = @tasks.where(state:"closed").sort_by &:eisenhower_sort_index
  end
  
  def eisenhower
    @tasks = Task.all
    @eisen_q1 = @tasks.where("state='open' AND urgent='true' AND important='true'")
    @eisen_q2 = @tasks.where("state='open' AND urgent='false' AND important='true'")
    @eisen_q3 = @tasks.where("state='open' AND urgent='true' AND important='false'")
    @eisen_q4 = @tasks.where("state='open' AND urgent='false' AND important='false'")
    @eisen_pending = @tasks.where("state='open' AND urgent is null and important is null")
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def change
    [:state,:urgent,:important].each do |p|
      if params[p] then
        #Equivalent to the original
        #@task.update_attributes(state: params[:state].downcase())
        #Because (state: x) is the same as ("state"=>x)
        #And "state".to_sym() results in :state
        @task.update_attributes(p=>params[p.to_sym()].downcase())
      end
    end
    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Task updated"}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:content,:state)
    end
end
