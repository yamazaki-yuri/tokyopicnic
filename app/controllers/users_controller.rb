class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @park_reports = current_user.park_reports.includes(:park, :report_images).order(created_at: :desc)
  end
end
