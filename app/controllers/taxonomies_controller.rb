class TaxonomiesController < ApplicationController
  before_action :set_taxonomy, only: [:show, :edit, :update, :destroy]

  # GET /taxonomies
  # GET /taxonomies.json
  def index
    if params[:search]
      f = Taxonomy.search(params[:search])
    else
      f = Taxonomy.all
    end
    @taxonomies = f.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /taxonomies/1
  # GET /taxonomies/1.json
  def show
  end

  # GET /taxonomies/new
  def new
    @taxonomy = Taxonomy.new
  end

  # GET /taxonomies/1/edit
  def edit
  end

  # POST /taxonomies
  # POST /taxonomies.json
  def create
    @taxonomy = Taxonomy.new(taxonomy_params)
    @taxonomy.user_id = current_user.id 
    respond_to do |format|
      if @taxonomy.save
        format.html { redirect_to @taxonomy, notice: @taxonomy.code+t(:was_created) }
        format.json { render :show, status: :created, location: @taxonomy }
      else
        format.html { render :new }
        format.json { render json: @taxonomy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /taxonomies/1
  # PATCH/PUT /taxonomies/1.json
  def update
    respond_to do |format|
      if @taxonomy.update(taxonomy_params)
        format.html { redirect_to @taxonomy, notice: @taxonomy.code+t(:was_updated) }
        format.json { render :show, status: :ok, location: @taxonomy }
      else
        format.html { render :edit }
        format.json { render json: @taxonomy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxonomies/1
  # DELETE /taxonomies/1.json
  def destroy
    @taxonomy.destroy
    respond_to do |format|
      format.html { redirect_to taxonomies_url, notice: @taxonomy.code+t(:was_destroyed) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_taxonomy
      @taxonomy = Taxonomy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def taxonomy_params
      params.require(:taxonomy).permit(:code, :description)
    end
end
