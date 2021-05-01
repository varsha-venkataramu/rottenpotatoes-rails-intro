class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # @movies = Movie.all
    # @movies = Movie.order(params[:sort])

    # if params[:sort_by] == 'title'
    # @title_header = 'hilite'
    # elsif params[:sort_by] == 'release_date'
    # @release_header ='hilite'
    # end
    
    # @sort = params[:sort]
    # @all_ratings = Movie.ratings
    # @ratings =  params[:ratings] || Hash[@all_ratings.map {|rating| [rating, rating]}]
    # @movies = Movie.where(rating:@ratings.keys).order(@sort)
    
    @sort = params[:sort]
    #@all_ratings = Movie.ratings
    #@ratings =  params[:ratings] || Hash[@all_ratings.map {|rating| [rating, rating]}]
    #@movies = Movie.where(rating:@ratings.keys).order(@sort)
    @movies = Movie.order(@sort)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
