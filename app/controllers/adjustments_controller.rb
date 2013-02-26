class AdjustmentsController < ApplicationController
  def index
  end

  def create
    set_value = false
    delta = params[:adjustment][:delta].to_f
    case params[:adjustment][:action].downcase
    when 'decrement'
      delta = -delta
    when 'set'
      set_value = true
    end

    item = Item.find_by_name(params[:adjustment][:name]) # FIXME: match partial or alias as well
    return redirect_to adjustments_path, alert: "No item found by name '#{params[:adjustment][:name]}'." unless item

    respond_to do |format|
      @adjustment = Adjustment.new(delta: delta, item: item, reset: set_value)
      if @adjustment.save
        format.html { redirect_to adjustments_url, notice: "#{item.name} quantity was adjusted by #{delta}." }
        format.json { render json: @adjustment, status: :created, location: @adjustment }
      else
        format.html { render action: "index" } # FIXME: set flash error (or done automatically?)
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end
end
