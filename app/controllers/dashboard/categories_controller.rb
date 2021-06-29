class Dashboard::CategoriesController < ApplicationController
    before_action :authenticate_admin!, except: :index
    before_action :set_category, only: %w[show edit update destroy]
    layout "dashboard/dashboard"
  
    def index
      @categories = Category.display_list(params[:page])
      @category = Category.new
      @major_categories = MajorCategory.all
    end
  
    def show
    end
  
    def create
      category = Category.new(category_params)
      category.save
      redirect_to dashboard_categories_path
    end
  
    def edit
      @major_categories = MajorCategory.all
    end
  
    def update
      @category.update(category_params)
      @category.save
      redirect_to dashboard_categories_path
    end
  
    def destroy
      @category.destroy
      redirect_to dashboard_categories_path
    end
  
    private
      def set_category
        @category = Category.find(params[:id])
      end
  
      def category_params
        params.require(:category).permit(:name,:description,:major_category_name,:major_category_id)
      end
  end