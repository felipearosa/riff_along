class SolosController < ApplicationController
  # def new
  #   @solo = Solo.new
  #   # authorize @solo
  # end

  def create
    @solo = Solo.new(params[:solo])
    # @solo.user = current_user
    # authorize @solo
    if @solo.save
      redirect_to solo_path(@solo)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
