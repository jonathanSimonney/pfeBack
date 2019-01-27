class Api::InterestPointCategoryController < ApplicationController
  def list
    ret = InterestPointCategory.all
    render :json => ret
  end
end
