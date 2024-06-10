class ParkDecorator < Draper::Decorator
  delegate_all

  def display_permission_value(column)
    case object.send(column)
    when 'possible'
      '◯'
    when 'impossible'
      '×'
    when 'unspecified'
      '-'
    when 'within_common_sense'
      '△'
    end
  end
end
