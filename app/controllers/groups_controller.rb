class GroupsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    respond_to do |format|
      format.html
      format.json { render :json => Group.all }
    end
  end

  def new
    respond_to do |format|
      format.html
      format.json { render :json => Group.new }
    end
  end

  def create
    group = Group.create(params[:group])
    respond_to do |format|
      format.html
      format.json { render :json => group }
    end
  end

  def update
    group = Group.find(params[:id])
    changes = {
      name:         params[:name],
      url:          params[:url],
      description:  params[:description],
      promo_code:   params[:promo_code]
    }
    group.update_attributes(changes)
    respond_to do |format|
      format.html
      format.json { render :json => trans }
    end
  end

end
