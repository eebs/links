class TagsController < ApplicationController
    def show
        @name = params[:name]
        @links = Link.tagged_with(params[:name]).page(params[:page]).per_page(10)
        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @tags }
        end
    end

    def index
        @tags = Link.tag_counts
    end
end
