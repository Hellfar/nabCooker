require 'rest-client'

class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :validate, :favorite, :select_diet, :edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    authorize Meal

    @meals = policy_scope(Meal)
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    authorize @meal
  end

  def validate
    authorize @meal

    result = RestClient.get "https://reqres.in/api/unknown/2"

    respond_to do |format|
      format.html { redirect_to @meal, notice: result }
      format.json { render :show, status: :validated, location: @meal }
    end
  end

  def favorite
    authorize @meal

    current_user.update meal_id: (@meal.favorite? current_user) ? nil : @meal.id

    respond_to do |format|
      format.html { redirect_to @meal, notice: (@meal.favorite? current_user) ? "This meal is now your favorite" : "This meal is now not your favorite" }
      format.json { render :show, status: :favorite, location: @meal }
    end
  end

  def select_diet
    authorize @meal

    current_user.update diet: @meal.category

    respond_to do |format|
      format.html { redirect_to @meal, notice: "This diet is now your personal diet" }
      format.json { render :show, status: :favorite, location: @meal }
    end
  end

  def unselect_diet
    authorize Meal

    current_user.update diet: nil

    respond_to do |format|
      format.html { redirect_to root_path, notice: "You have now no diet." }
      format.json { render :show, status: :favorite, location: @meal }
    end
  end

  # GET /meals/new
  def new
    @meal = Meal.new

    authorize @meal
  end

  # GET /meals/1/edit
  def edit
    authorize @meal
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)

    authorize @meal

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    authorize @meal

    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    authorize @meal

    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name, :category, :desc)
    end
end
