class TransactionsController < ApplicationController


# SPINACH notice how you can also skip that universal before_filter
  skip_before_filter :authenticate_user!, only: [:new, :create]

  def new
    # SPINACH I have no idea how this permalink will work
    @product = Product.find_by!(permalink: params[:permalink])
  end

# SPINACH notice how he is using a nonrestful action here
  def pickup
    @sale = Sale.find_by!(guid: params[:guid])
    @product = @sale.product
  end


  def create
    product = Product.find_by!(
      permalink: params[:permalink]
    )

    token = params[:stripeToken]
  end

  def begin
    charge  = Stripe::Charge.create(
      amount: product.price,
      currency: "usd",
      card: token,
      description: params[:email]
    )
    @sale = product.sales.create!(
      email: params[:email]
    )
    redirect_to pickup_url(guid: @sale.guid)

    rescue Stripe::CardError => e
      # The card has been declined or some other error has occurred
      @error = e
      render :new
    end
  end

  def download
    @sale = Sale.find_by!(guid: params[:guid])

    resp = HTTParty.get(@sale.product.file.url)

    filename = @sale.product.file.url
    send_data resp.body,
      :filename => File.basname(filename),
      :content_type => resp.headers['Content-Type']
  end

end