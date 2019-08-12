module Concerns::HasSortableRelation
  extend ActiveSupport::Concern
  def apply_order_to_relation(param_ids, relation_name, foreign_key)
    incoming_ids = param_ids.reject(&:blank?).map(&:to_i)
    objects = public_send(relation_name).to_a
    return unless objects.any? { |o| o.position.blank? } ||
      incoming_ids != objects.sort_by(&:position).map(&foreign_key)
    objects_by_id = objects.index_by(&foreign_key)
    incoming_ids.each_with_index { |id, i| objects_by_id[id].position = i }
  end
end
