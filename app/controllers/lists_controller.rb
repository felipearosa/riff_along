class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[show]

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    authorize @list
    if params[:list][:video_id]
      @video = Video.find(params[:list][:video]) if params[:list][:video] != ''
      unless @video
        video_id = CGI.escape(params[:list][:video_id])
        url = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=#{video_id}&key=#{ENV.fetch('YOUTUBE_API')}"
        videos_serialized = URI.open(url,'User-Agent' => 'ruby').read
        videos_info = JSON.parse(videos_serialized)["items"][0]
        video_title = videos_info["snippet"]["title"]
        video_image_url = videos_info["snippet"]["thumbnails"]["medium"]["url"]
        @video = Video.new(title: video_title, image_url: video_image_url, youtube_key: video_id)
        @video.save!
      end
      if params[:solos]
        @test = []
        @solos = params[:solos]
        @solos.each do |_key, arr|
          arr = arr.split(',').map { |word| word.strip }
          next if arr.length == 4
          @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
          @solo.done = arr[2] == 'mastered'
          @solo.video = @video
          @solo.save!
        end
      end

      @catalog = Catalog.new
      @catalog.video = @video
      @catalog.list = @list

      if @catalog.save
        redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
      else
        render 'videos/show', status: :unprocessable_entity
      end
    else
      if @list.save
        redirect_to user_path(current_user)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
    authorize @list
  end

  def update
    authorize @list
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def show
    @user = @list.user
    authorize @user
  end

  def destroy
    authorize @list
    @list.destroy
    redirect_to user_path(current_user), status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :description)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
