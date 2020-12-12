class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :set_movie
  before_action :authenticate_user!

  # GET /movies/:movie_id/reviews/new
  def new
    @review = Review.new
  end

  # GET /movies/:movie_id/reviews/:id/edit
  def edit
  end

  # POST /movies/:movie_id/reviews
  def create
    @review = current_user.reviews.new(review_params)
    @review.movie_id = @movie.id
    @review.movie_api_id = @movie.api_id

    if @review.save
      redirect_to "/movies/#{@movie.api_id}", notice: I18n.t('reviews.create.notice')
    else
      redirect_to "/movies/#{@movie.api_id}", notice: I18n.t('reviews.create.destroy')
    end
  end

  # PATCH/PUT /movies/:movie_id/reviews/:id
  def update
    if @review.update(review_params)
      redirect_to "/movies/#{@movie.api_id}", notice: I18n.t('reviews.update.notice')
    else
      redirect_to "/movies/#{@movie.api_id}", alert: I18n.t('reviews.update.alert')
    end
  end

  # DELETE /movies/:movie_id/reviews/:id
  def destroy
    if @review.destroy
      redirect_back fallback_location: '', notice: I18n.t('reviews.destroy.notice')
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:comment)
    end
end
