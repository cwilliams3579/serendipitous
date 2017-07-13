class ProductsController < InheritedResources::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def show
    @reviews = Review.where(product_id: @product.id).order("created_at DESC")
    if @reviews.blank?
      @avg_rating = 0
    else
      @avg_rating = @reviews.average(:rating).round(2)
    end
  end

  def create
    @product = Product.new(product_params)
     @product.user_id = current_user.id
     respond_to do |format|
       if @product.save
         format.html { redirect_to @product, notice: 'Product was successfully created.' }
       else
         format.html { render :new }
       end
     end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

    def product_params
      params.require(:product).permit(:image, :name, :description, :price, :user_id)
    end
end
