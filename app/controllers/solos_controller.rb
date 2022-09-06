class SolosController < ApplicationController

  # def new
  #   @solo = Solo.new
  #   # authorize @solo
  # end

  def update
      @solo = Solo.find(params[:id])
      if @solo.done
        @solo.done = false
      else
        @solo.done = true
      end

      if @solo.save
      else
        render 'videos/show', status: :unprocessable_entity
      end
  end

  def destroy
    @solo = Solo.find(params[:id])
    @solo.destroy

    redirect_to user_video_path(user_id: current_user, id: @solo.video.youtube_key), status: :see_other
  end
end
