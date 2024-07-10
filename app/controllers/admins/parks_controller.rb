class Admins::ParksController < Admins::BaseController
  def index
    @parks = Park.all
  end
end
