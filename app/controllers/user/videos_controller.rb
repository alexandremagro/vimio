# Authenticated actions for Videos
class User::VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_video, only: [:edit, :update, :destroy]

  layout 'card'

  def index
    @videos = current_user.videos.order(created_at: :desc)
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.build(video_params)

    if @video.save
      redirect_to video_path(@video), notice: 'Video was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @video.update(video_params)
      redirect_to user_videos_path, notice: 'Video was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @video.destroy

    redirect_to user_videos_path
  end

  private

  def set_video
    @video = current_user.videos.find(params[:id])
  end

  def video_params
    params.require(:video).permit(:name, :url)
  end
end
