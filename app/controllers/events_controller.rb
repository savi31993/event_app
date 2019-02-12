class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_author, only: [:edit, :update, :destroy]
  before_action :require_login, only: [:create, :manager, :change_status, :index]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    @has_rsvp_ed_all = {}
    @status_all = {}

    @events.each do |event|
      get_rsvp_info(event.id)
      @has_rsvp_ed_all[event.id] = @has_rsvp_ed
      @status_all[event.id] = @status
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    get_rsvp_info(@event.id)
  end

  # GET /events/new
  def new
    @categories = Category.all.by_name
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @categories = Category.all.by_name
  end

  # POST /events
  # POST /events.json
  def create
    @categories = Category.all.by_name
    @event = Event.new(event_params)
    @event.owner = current_user
    @event.category = Category.find(params[:event][:category_id])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if !params[:status].nil?
      change_status(@event, params[:status][:status])
    end

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manager
  end

  def change_status
    event_id = params[:event_id]
    new_status = params[:new_status]
    event = Event.find(event_id)

    get_rsvp_info(event_id)

    if @has_rsvp_ed
      rsvp = Rsvp.find(@rsvp_id)
      rsvp.update_attribute(:status, new_status)
    else
      rsvp = Rsvp.create(:user => current_user, :status => new_status, :event => event)
    end

    redirect_back(fallback_location: categories_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.fetch(:event, {}).permit(:name, :description, :category_id)
    end

    def require_author
      # redirect_to(events_path) unless @event.owner == current_user
      if current_user != @event.owner
        if params[:status].nil?
          redirect_to(events_path)
        end
      end
    end

    def require_login
      redirect_to(categories_path) unless current_user != nil
    end
end
