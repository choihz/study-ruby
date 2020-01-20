module Observable
  def observers
    @observer_list ||= []
  end
  def add_ovserver(obj)
    observers << obj
  end
  def notify_observers
    observers.each {|o| o.update}
  end
end
