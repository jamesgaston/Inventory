class CategoriesController < ApplicationController
  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def delete
  end

  def index
  	@categories = Category.order("name") 
  end

end
