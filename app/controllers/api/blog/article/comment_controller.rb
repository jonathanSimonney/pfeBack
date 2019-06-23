# frozen_string_literal: true

class Api::Blog::Article::CommentController < ApplicationController
  protect_from_forgery prepend: true
  respond_to :json

  def create_comment
    @user = User.where(authentication_token: params[:token]).first
    @article = Article.find_by(id: params[:article_id])
    if @user && @article
      body = JSON.parse request.raw_post

      title = body['title']
      content = body['content']
      if title.nil? || content.nil?
        render json: { result: 'missing parameters. expected title and content params' }, status: :bad_request
      else
        ArticleComment.new(user_id: @user.id, content: content, title: title, article_id: @article.id).save
        render json: { result: 'success' }
      end
    else
      render json: { error: 'wrong token or unexhisting article id' }, status: :unauthorized
    end
  end
end
