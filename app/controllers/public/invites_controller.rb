class Public::InvitesController < ApplicationController
  
  def index
    @user = current_user
  end
  
end
