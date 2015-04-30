class TagsController < ApplicationController
  def new
    @tags = Tag.all
    @tag = Tag.new()
  end

  def tag_params
    params.require(:tag).permit(:name)
  end

  def create
    @tag = Tag.create(tag_params)
    redirect_to :tags
  end

  def update
  end

  def edit
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_index_path
  end

  def index
    @tags = Tag.all
  end

  def show
    @creature = Creature.find(params[:id])
    @tags = @creature.tags
  end
end
