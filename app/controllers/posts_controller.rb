class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorise_request, only: [:create, :update, :destroy]
  before_action :set_organisation, only: [:create, :update, :destroy] 

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @post, status: :ok
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = @organisation.posts.new(post_params)

    if @post.save
      # format.html { redirect_to @post, notice: 'Post was successfully created.' }
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        # format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        # format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      # format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_organisation
      @organisation = Organisation.find(params[:organisation_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.permit(:title, :content, :organisation)
    end
end
