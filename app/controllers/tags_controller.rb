class TagsController < ApplicationController
  def index
    @tag = Tag.find_by(name: params[:tag])
  end
end