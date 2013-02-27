class AdjustmentsController < ApplicationController
  def index
  end

  def create
    set_value = false
    convert_value = false
    convert_value = true if params[:adjustment][:delta] =~ /[a-zA-Z]/
    delta = params[:adjustment][:delta].to_f
    delta = params[:adjustment][:delta].to_s if convert_value
    case params[:adjustment][:action].downcase
    when 'decrement'
      if convert_value
        delta = "-#{delta}"
      else
        delta = -delta
      end
    when 'set'
      set_value = true
    end

    item = Item.find_by_name(params[:adjustment][:name]) # FIXME: match partial or alias as well
    item = Item.find_by_id(params[:adjustment][:name].to_i) unless item # Maybe they submitted an ID
    return redirect_to adjustments_path, alert: "No item found by name '#{params[:adjustment][:name]}'." unless item

    respond_to do |format|
      @adjustment = Adjustment.new(delta: delta, item: item, reset: set_value)
      @adjustment.convert(delta.to_s) if convert_value
      if @adjustment.save
        format.html { redirect_to adjustments_url, notice: "#{item.name} quantity was adjusted by #{delta}; the new quantity is #{item.quantity}." }
        format.json { render json: @adjustment, status: :created, location: @adjustment }
      else
        format.html { render action: "index" }
        format.json { render json: @adjustment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end
end
