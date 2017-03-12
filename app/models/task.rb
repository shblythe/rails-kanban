class Task < ActiveRecord::Base
  def eisenhower_sort_index
    result=0
    if self.urgent=="true" then result-=4 end
    if self.important=="true" then result-=2 end
    if self.urgent==nil and self.important==nil then result=1 end
    return result
  end
end
