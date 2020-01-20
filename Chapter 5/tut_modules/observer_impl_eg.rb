require_relative 'observer_impl'

class TelescopeScheduler

  # 일정이 변경되면 통지를 받을 수 있도록 다른 클래스에 등록한다.
  include Observable

  def initialize
    @observer_list = [] # folks with telescope time
  end
  def add_viewer(viewer)
    @observer_list << viewer
  end
end
