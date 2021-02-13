class BlogsController < ApplicationController
  before_action :set_blog, only: %w[ show edit update destroy ]
  require 'payjp'
  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all
    @parents = Category.all.where(ancestry: nil)
    #  binding.pry
    # @grandchilds = Category.where(ancestry: "1/3")
    # @grandchilds2 = Category.where(ancestry: "2/4")
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @comments = @blog.comments
    @comment = @blog.comments.build
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    # @parents = Category.all.where(ancestry: nil)
    @children = Category.find_by(name:"レディース", ancestry: nil).children
    @children2 = Category.find_by(name:"メンズ", ancestry: nil).children
  # binding.pry
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def purchase
    @blog = Blog.find(params[:id])
  end

  def pay
    @blog = Blog.find(params[:id])

    Payjp.api_key = "sk_test_c50831c684c20a48dd29ef03"
    Payjp::Charge.create(
      :amount => @blog.price,
      :card => params['payjp-token'],
      :currency => 'jpy'
    )
    
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
      # binding.pry
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:name, :category_id, :content, :price, images: [])
    end
end
