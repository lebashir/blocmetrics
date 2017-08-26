class RegisteredApplicationsController < ApplicationController
  def index
    @user = current_user
    @registered_applications = @user.registered_applications
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = current_user.registered_applications.new(app_params)

    if @registered_application.save
      flash[:notice] = "Application Registered"
      redirect_to @registered_application
    else
      flash.now[:alert] = "Error registering your application."
      render :new
    end
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.update(app_params)
      flash[:notice] = "Registered Application updated."
      redirect_to @registered_application
    else
      flash.now[:alert] = "Error updating Application."
      render :edit
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "#{@registered_application.name} was deleted."
      redirect_to registered_applications_path
    else
      flash.now[:alert] = "Error deleting Application."
      render :show
    end
  end

  private

  def app_params
    params.require(:registered_application).permit(:name, :url)
  end

end
