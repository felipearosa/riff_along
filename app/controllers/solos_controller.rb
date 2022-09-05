class SolosController < ApplicationController

  # def new
  #   @solo = Solo.new
  #   # authorize @solo
  # end


  def destroy
    @solo = Solo.find(params[:id])
    @solo.destroy

    redirect_to user_video_path(user_id: current_user, id: @solo.video.youtube_key), status: :see_other
  end
end
