class DuctsController < ApplicationController
  before_action :set_duct, only: %i[ show edit update destroy ]

  # GET /ducts or /ducts.json
  def index
    @ducts = Duct.all
  end

  # GET /ducts/1 or /ducts/1.json
  def show
    qr = RQRCode::QRCode.new("
      #{request.base_url}/ducts/#{@duct.id}")
    png = qr.as_png(
      resize_gte_to: false,
      border_modules: 4,
      module_px_size: 6
    )
    @png = png.to_data_url
  end

  # GET /ducts/new
  def new
    @duct = Duct.new
  end

  # GET /ducts/1/edit
  def edit
  end

  # POST /ducts or /ducts.json
  def create
    @duct = Duct.new(duct_params)

    respond_to do |format|
      if @duct.save
        format.html { redirect_to duct_url(@duct), notice: "Duct was successfully created." }
        format.json { render :show, status: :created, location: @duct }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @duct.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ducts/1 or /ducts/1.json
  def update
    respond_to do |format|
      if @duct.update(duct_params)
        format.html { redirect_to duct_url(@duct), notice: "Duct was successfully updated." }
        format.json { render :show, status: :ok, location: @duct }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @duct.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ducts/1 or /ducts/1.json
  def destroy
    @duct.destroy!

    respond_to do |format|
      format.html { redirect_to ducts_url, notice: "Duct was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duct
      @duct = Duct.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def duct_params
      params.require(:duct).permit(:width, :height, :length, :line_type, :location, :floors, :position, :duct_line_id, :duct_type)
    end
end
