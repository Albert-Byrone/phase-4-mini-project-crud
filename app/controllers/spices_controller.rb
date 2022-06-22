class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    spices = Spice.all
    render json: spices
  end

  def show
    spice = find_spice
    render json: spice
  end

  def create
    spice = Spice.create(spice_params)
    render json: spice, status: :created
  end

  def update
    spice = find_spice
    spice.update(spice_params)
    render json: spice, status: :updated
  end

  def destroy
    spice = find_spice
    spice.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { error: 'Not Found'}, status: :not_found
  end

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def spice_params
    params.permits(:title, :description, :image, :notes, :rating)
  end
end
