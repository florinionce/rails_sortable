class SortableController < ApplicationController
  #
  # post /sortable/reorder, :klass => ["1", "3", "2"]
  #
  def reorder
    klass, ids, sortable_column = parse_params
    attr = klass.sort_attribute
    models = klass.order(attr).to_a
    ids.each_with_index do |id, new_sort|
      model = models.find {|m| m.id == id }
      model.update_sort!(new_sort, sortable_column) if model.read_attribute(attr) != new_sort
    end
    head :ok
  end

private

  def parse_params
    klass_name = params.keys.first
    ids = params[klass_name].map { |id| id.to_i }
    sortable_column = params[:sortable_column]
    [ klass_name.constantize, ids, sortable_column ]
  end
end
