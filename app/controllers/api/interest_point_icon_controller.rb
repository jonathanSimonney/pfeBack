class Api::InterestPointIconController < ApplicationController
  def list
    ret = InterestPointCategory.all
    render :json => ret
  end
end
