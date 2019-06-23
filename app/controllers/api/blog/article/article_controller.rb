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
      category_id = body['category_id']
      if category_id.nil?
        render json: { result: 'missing parameters. expected category__id' }, status: :bad_request
      else
        category = ArticleCategory.find_by(id: category_id)
        if category.nil?
          render json: { result: 'wrong parameters. the category you gave does not exist' }, status: :bad_request
        else
          if title.nil? || content.nil?
            render json: { result: 'missing parameters. expected title and content params' }, status: :bad_request
          else
            Article.new(user_id: @user.id, content: content, title: title, article_category_id: category_id).save
            render json: { result: 'success' }
          end
        end
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

  def list_category
    ret = ArticleCategory.all
    render json: ret
  end

  def list_article_in_category
    ret = Article.where(article_category_id: params['category_id'])
    render json: hydrate_article_list(ret)
  end

  def list_article
    ret = Article.all
    render json: hydrate_article_list(ret)
  end

  private

  def hydrate_article_list(article_list)
    ret = []

    article_list.each {|article|
      ret.push({article: article, nb_upvote: article.nb_upvote, comment_list: ArticleComment.where(article_id: article.id)})
    }

    ret
  end
end
