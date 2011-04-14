class Date
  def workday?
    [1,2,3,4,5].include?(self.wday)
  end
end