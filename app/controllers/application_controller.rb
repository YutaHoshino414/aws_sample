class ApplicationController < ActionController::Base
  before_action :set_parents
  before_action :set_children

  private
  def set_parents
    @parents = Category.where(ancestry: nil)
  end

  def set_children
    @children = Category.find_by(name:"レディース", ancestry: nil).children
  end
end
