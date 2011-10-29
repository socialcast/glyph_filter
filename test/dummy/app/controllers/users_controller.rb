class UsersController < ActionController::Base
  before_filter :find_users
  def index; end
  private
  def find_users
    @users = User.glyph_filter(:name, params[:glyph]).all
  end
end