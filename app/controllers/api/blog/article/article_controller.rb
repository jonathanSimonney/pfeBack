# frozen_string_literal: true

class Api::Blog::Article::ArticleController < ApplicationController
  protect_from_forgery prepend: true
  respond_to :json

  def add_article
    @user = User.where(authentication_token: params[:token]).first
    if @user
      body = JSON.parse request.raw_post

      title = body['title']
      content = body['content']
      if title.nil? || content.nil?
        render json: { result: 'missing parameters. expected title and content params' }, status: :bad_request
      else
        Article.new(user_id: @user.id, content: content, title: title).save
        render json: { result: 'success' }
      end
    else
      render json: { error: 'wrong token' }, status: :unauthorized
    end
  end

  def upvote_article
    @user = User.where(authentication_token: params[:token]).first
    @article = Article.find_by(id: params[:article_id])
    if @user && @article
      if ArticleUpvote.find_by(user_id: @user.id, article_id: params[:article_id]).nil?
        ArticleUpvote.new(user_id: @user.id, article_id: params[:article_id]).save
        render json: { result: 'success' }
      else
        render json: { result: 'wrong parameters. You already voted on asked article' }, status: :bad_request
      end
    else
      render json: { error: 'wrong token or unexhisting article id' }, status: :unauthorized
    end
  end
end
