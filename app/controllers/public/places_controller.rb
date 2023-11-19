class Public::PlacesController < ApplicationController
   before_action :authenticate_user!

  def create
    @place = Place.new(place_params)
    @family = current_user.family
    @place.family = @family if @family.present?
		if @place.save
		   @places =Place.all
      flash[:notice] = "保管場所を追加しました"
		else
		  @places = Place.all
      flash[:alert] = "エラーにより保管場所を追加できません"
		end
    redirect_to @family.present? ? edit_family_path(@family) : root_path
  end

  def destroy
    @place = Place.find(params[:id])
    @place.destroy!
    flash[:notice] = '保管場所を削除しました'
    @family = current_user.family
    redirect_to @family.present? ? edit_family_path(@family) : root_path
  end

  private

	def place_params
	  params.require(:place).permit(:name)
	end
end
