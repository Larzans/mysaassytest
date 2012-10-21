class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    @sortby = "uoeuo"
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G','PG','PG-13','R']
    @selected_ratings = selected_ratings
    #@params = params

    @sort_by = nil
    if params[:sortby] == "date" then @sortby = "release_date"; end
    if params[:sortby] == "title" then @sortby = "title"; end
    @movies = Movie.find(:all, :conditions => {:rating => @selected_ratings}, :order => @sortby)
	#Post.find :all, :conditions => ['author = ? AND title = ?',
         #            'F2Andy', 'ActiveRecord find']

    @sortby = params[:sortby]
  end

  def selected_ratings
    if !params.has_key? :ratings then return @all_ratings; end
    params[:ratings].keys
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
