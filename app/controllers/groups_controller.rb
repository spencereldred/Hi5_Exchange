class GroupsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    groups = Group.all
    groups.each do |group|
      group[:member_count] = group.profiles.length
    end
    respond_to do |format|
      format.html
      format.json { render :json => groups }
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
