class DuctLinesController < ApplicationController
  before_action :set_duct_line, only: %i[ show edit update destroy ]

  # GET /duct_lines or /duct_lines.json
  def index
    @duct_lines = DuctLine.all
  end

  # GET /duct_lines/1 or /duct_lines/1.json
  def show
    qr = RQRCode::QRCode.new("
    #{request.base_url}/duct_lines/#{@duct_line.id}")
    png = qr.as_png(
      resize_gte_to: false,
      border_modules: 4,
      module_px_size: 6
    )
    @png = png.to_data_url
    @duct_line = DuctLine.includes(:ducts).find(params[:id])
  end

  # GET /duct_lines/new
  def new
    @duct_line = DuctLine.new
  end

  # GET /duct_lines/1/edit
  def edit
  end

  # POST /duct_lines or /duct_lines.json
  def create
    @duct_line = DuctLine.new(duct_line_params)

    respond_to do |format|
      if @duct_line.save
        format.html { redirect_to duct_line_url(@duct_line), notice: "Duct line was successfully created." }
        format.json { render :show, status: :created, location: @duct_line }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @duct_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /duct_lines/1 or /duct_lines/1.json
  def update
    respond_to do |format|
      if @duct_line.update(duct_line_params)
        format.html { redirect_to duct_line_url(@duct_line), notice: "Duct line was successfully updated." }
        format.json { render :show, status: :ok, location: @duct_line }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @duct_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /duct_lines/1 or /duct_lines/1.json
  def destroy
    @duct_line.destroy!

    respond_to do |format|
      format.html { redirect_to duct_lines_url, notice: "Duct line was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duct_line
      @duct_line = DuctLine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def duct_line_params
      params.require(:duct_line).permit(:name, :image, :pdf_document)
    end
end
