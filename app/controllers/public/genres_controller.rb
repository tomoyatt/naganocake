class Public::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @genres = Genre.all
    @items = Item.where(genre_id: @genre.id)
  end
end
