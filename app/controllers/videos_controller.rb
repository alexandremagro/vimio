class VideosController < ApplicationController
  before_action :set_video, only: [:show, :view]

  def index
    @videos = Video.order(created_at: :desc)
  end

  def show
  end

  # XHR action send by the video event
  def view
    @video.increment!(:view_count)

    render json: @video
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
end
