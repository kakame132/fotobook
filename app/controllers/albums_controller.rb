class AlbumsController < ApplicationController
  def edit
    @c=0
    @album=Album.find(params[:id])
    render 'edit_album_title'
  end
  def update
    @album=Album.find(params[:id])
    @c=1
    @title=params.require(:album).permit(:title)
    @album.update(title: @title["title"])
    render 'edit_album_title'
  end
end
