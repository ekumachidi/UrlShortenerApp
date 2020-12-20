class ShortUrlsController < ApplicationController
  def index
    @short_urls = ShortUrl.order(visits: :desc).limit(100)
  end

  def show
    return render '404', layout: false, status: 404 unless (@short_urls = ShortUrl.find_by(slug: params[:id]))

    @short_urls.update(visits: @short_urls.visits + 1)
    redirect_to @short_urls.original_url
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    @short_url = ShortUrl.new(short_url_params)

    if @short_url.save
      FetchPageTitleJob.perform_later(@short_url)
      redirect_to root_path, notice: "Your link was shortened to: #{ENV['HOST_URL'] + @short_url.slug}"
    else
      render :new
    end
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url)
  end
end
