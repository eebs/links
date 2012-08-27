require 'open-uri'

class LinksController < ApplicationController
  load_and_authorize_resource

  # GET /links
  # GET /links.json
  def index
    show_anon_message unless user_signed_in?
    @link = Link.new
    @links = Link.order('created_at DESC').page(params[:page]).per_page(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
      format.atom { render :layout => false}
    end
  end

  def mylinks
    @links = Link.where(:user_id => current_user.id).order('created_at DESC').page(params[:pgae]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    respond_to do |format|
      if @link.save
        if not @link.title?
          @link.title = Nokogiri::HTML(open @link.url).title
        end
        if @link.save
          format.html { redirect_to root_path, notice: 'Link was successfully created.' }
          format.json { render json: @link, status: :created, location: @link }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.json
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end

  protected
    def show_anon_message
      flash.now[:info] = "Note: You won't be able to edit or delete links you post while not logged in."
    end
end
