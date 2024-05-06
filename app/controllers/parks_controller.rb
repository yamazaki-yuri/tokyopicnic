class ParksController < ApplicationController
  def show
    @park = Park.find(params[:id])
  end
end
