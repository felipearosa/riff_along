class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit update destroy]

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if params[:list][:video_id]
      video_id = CGI.escape(params[:list][:video_id])
      url = "https://youtube.googleapis.com/youtube/v3/videos?part=snippet&id=#{video_id}&key=#{ENV.fetch('YOUTUBE_API')}"
      videos_serialized = URI.open(url).read
      videos_info = JSON.parse(videos_serialized)["items"][0]
      video_title = videos_info["snippet"]["title"]
      video_image_url = videos_info["snippet"]["thumbnails"]["medium"]["url"]
      @video = Video.new(title: video_title, image_url: video_image_url, youtube_key: video_id)
      @video.save!
      if params[:solos]
        @test = []
        @solos = params[:solos]
        @solos.each do |_key, arr|
          arr = arr.split(',')
          @solo = Solo.new(starting_time: arr[0], ending_time: arr[1])
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
        redirect_to user_video_path(user_id: current_user, id: @video.youtube_key)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def edit
  end

  def update
    @list.update(list_params)

    redirect_to list_path(@list)
  end

  def show
  end

  def destroy
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
