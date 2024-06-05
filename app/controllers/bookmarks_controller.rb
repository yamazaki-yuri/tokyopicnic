class BookmarksController < ApplicationController
  def index
    @bookmark_parks = current_user.bookmark_parks.includes(:park_images).order(created_at: :desc)
    render partial: 'bookmarks/index'
  end

  def create
    @park = Park.find(params[:park_id])
    current_user.bookmark(@park)
  end

  def destroy
    @park = current_user.bookmarks.find(params[:id]).park
    current_user.unbookmark(@park)
  end
end
