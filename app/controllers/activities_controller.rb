class ActivitiesController < ApplicationController
  before_action :ensure_current_user, :only => [:show, :edit, :update, :destroy]

  def ensure_current_user
    @activities = Activity.find(params[:id])
    if @activities.user_id != current_user.id
      redirect_to root_url, :alert => "Sorry, you are not authorized to view this page"
    end

  end


  def index
    @activities = current_user.activities
  end

  def show
    @activity = Activity.find(params[:id])
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new
    @activity.name = params[:activity][:name]
    @activity.starting_time = Chronic.parse(params[:activity][:starting_time])
    @activity.ending_time = Chronic.parse(params[:activity][:ending_time])
    @activity.user_id = current_user.id
    @activity.event_id = params[:activity][:event_id]
    @activity.description = params[:description]
    @activity.image = params[:image]

    respond_to do |format|
      if @activity.save
        format.html do
          redirect_to :back, :notice => "Activity created successfully."
        end
        format.js do
          render('create.js.erb')
        end
      else
          render 'new'
      end
    end
  end

  def edit
    @activity = Activity.find(params[:id])
  end

  def update
    @activity = Activity.find(params[:id])

    @activity.name = params[:name]
    @activity.starting_time = Chronic.parse(params[:starting_time])
    @activity.ending_time = Chronic.parse(params[:ending_time])
    @activity.user_id = params[:user_id]
    @activity.event_id = params[:event_id]
    @activity.description = params[:description]
    @activity.image = params[:image]

    if @activity.save
      redirect_to :back, :notice => "Activity updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])

    @activity.destroy

    respond_to do |format|
      format.html do
        redirect_to :back, :notice => "Activity deleted."
      end
      format.js do
        render('destroy.js.erb')
      end
    end
  end
end
