class CreaturesController < ApplicationController


  def index
    @creatures = Creature.all
  end

  def new
    @creature = Creature.new
    @tags = Tag.all
  end

  def show
    @creature = Creature.find(params[:id])
    @tags = @creature.tags
    list = flickr.photos.search :text => @creature.name, :sort => "relevance"
    results = list.map do |photo|
      "https:/farm3.static.flickr.com/#{photo["server"]}/""#{photo["id"]}_""#{photo["secret"]}_n.jpg"
    end
    @result = results
  end


  def create
    @creature = Creature.create(creature_params)
    tags = params[:creature][:tag_ids]
    tags.each do |tag_id|
      @creature.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    redirect_to @creature
  end

  def creature_params
  params.require(:creature).permit(:name,:description)
  end

  def edit
    @creature = Creature.find(params[:id])
    @tags = Tag.all
  end

  def update
    @creature = Creature.find(params[:id])
    @creature.update(creature_params)
    @tags = Tag.all
    @creature.tags.clear
    tags = params[:creature][:tag_ids]
    tags.each do |tag_id|
      @creature.tags << Tag.find(tag_id) unless tag_id.blank?
    end
    redirect_to @creature
  end

  def tag
    tag = Tag.find_by_name(params[:tag])
    @creatures = tag.creatures
  end

  def destroy
    @creature = Creature.find(params[:id])
    @creature.destroy
    redirect_to creatures_path
  end

end



