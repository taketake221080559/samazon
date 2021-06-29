class Dashboard::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %w[show edit update destroy]
  layout "dashboard/dashboard"

  def index
    sort_query = []
    @sorted = ""

    if params[:sort].present?
      slices = params[:sort].split(' ')
      sort_query[slices[0]] = slices[1]
      @sorted = params[:sort]
    end

    if params[:keyword] != nil
      keyword = trim(params[:keyword])
      @total_count = Product.search_for_id_and_name(keyword).count
      @products = Product.search_for_id_and_name(keyword).sort_order(sort_query).display_list(params[:pages])
    else
      keyword = ""
      @total_count = Product.count
      @products = Product.display_list(params[:page])
    end

    @sort_list = Product.sort_list
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    product = Product.new(crud_params)
    product.save
    redirect_to dashboard_products_path
  end

  def edit
    @categories = Category.all
  end

  def update
    # binding.pry
    @product.update(crud_params)
    binding.pry
    redirect_to dashboard_products_path
  end

  def destroy
    @product.destroy
    redirect_to dashboard_products_path
  end

  def import
  end

  def import_csv
    if params[:file] && File.extname(params[:file].original_filename) == ".csv"
      Product.import_csv(params[:file])
      flash[:success] = "CSVでの一括登録が成功しました!"
      redirect_to import_csv_dashboard_products_url
    else
      flash[:danger] = "CSVが追加されていません。CSVを追加してください。"
      redirect_to import_csv_dashboard_products_url
    end
  end

  def download_csv
    send_file(
      "#{Rails.root}/public/csv/products.csv",
      filename: "products.csv",
      type: :csv
    )
  end


  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.permit(:name, :description, :price, :recommend_flag, :carriage_flag, :category_id, :image)
    end

    # def product_params
    #   params.require(:product).permit(:name, :description, :price, :recommended_flag, :category_id)
    # end

    def crud_params
      params.require(:product).permit(:name, :description, :price, :recommended_flag, :carriage_flag, :category_id, :image)
    end
end