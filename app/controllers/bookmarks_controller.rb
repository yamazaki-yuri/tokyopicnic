class BookmarksController < ApplicationController
  def create
    @park = Park.find(params[:park_id])
    current_user.bookmark(@park)
  end

  def destroy
    @park = current_user.bookmarks.find(params[:id]).park
    current_user.unbookmark(@park)
  end
end
