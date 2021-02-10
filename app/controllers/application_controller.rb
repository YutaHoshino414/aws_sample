class ApplicationController < ActionController::Base
  before_action :set_parents

  private
  def set_parents
    @parents = Category.where(ancestry: nil)
  end
end
