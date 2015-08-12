class MoviesController < ApplicationController

  before_action :find_movie, only: [:show, :update, :edit, :destroy]

  def find_movie
    @movie = Movie.find(params["id"])
  end

  def update
    @movie.title = params[:title]
    @movie.year = params[:year]
    @movie.save
    redirect_to root_url
  end

  def edit
  end

  def new
    @movie = Movie.new
  end

  def create
    # form_params = params.permit(:title, :year, :director_id)
    # @movie = Movie.new(form_params)
    #
    @movie = Movie.new
    @movie.title = params["title"]
    @movie.year = params["year"]
    @movie.director_id = params["director_id"]

    if @movie.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    if params["keyword"].present?
      k = params["keyword"].strip
      @movies = Movie.where("title LIKE ?", "%#{k}%")
    else
      @movies = Movie.all
    end

    @movies = @movies.page(params[:page]).per(4)

    respond_to do |format|
      format.html do
        render 'index'
      end
      format.json do
        render :json => @movies
      end
      format.xml do
        render :xml => @movies
      end
    end

  end

  def destroy
    @movie.delete
    redirect_to "/movies"
  end

  def show
    cookies.signed["fruit"] = "choc chip cookies"
    session["history"] ||= []
    session["history"] << @movie.id
  end

end
