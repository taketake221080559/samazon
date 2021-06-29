class Dashboard::MajorCategoriesController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_major_category, only: %w[show edit update destroy]
    layout "dashboard/dashboard"
  
    def index
      @major_categories = MajorCategory.display_list(params[:pages])
      @major_category = MajorCategory.new
    end
  
    def show
    end
  
    def create
      major_category = MajorCategory.new(major_category_params)
      major_category.save
      redirect_to dashboard_major_categories_path
    end
  
    def edit
    end
  
    def update
      @major_category.update(major_category_params)
      redirect_to dashboard_major_categories_path
    end
  
    def destroy
      @major_category.destroy
      redirect_to dashboard_major_categories_path
    end
  
    private
      def major_category_params
        params.require(:major_category).permit(:name, :description)
      end
  
      def set_major_category
          @major_category = MajorCategory.find(params[:id])        
      end
  end