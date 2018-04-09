class GradingTools::AveragePolicy
  def initialize(params={})
    @scale = params[:scale] || 100
    @drop = params[:drop] || 0
  end

  def average(grades)
    len = grades.length
    if (0 == len)
      0
    elsif ((0 == @drop) || (len <= @drop))
      grades.inject(:+)/len.to_f
    else
      sorted = grades.sort
      (grades.inject(:+) - sorted[0..@drop-1].inject(:+))/(len.to_f - @drop)
    end
  end

  def compute(grades)
    if (grades.length > 0)
      (average(grades) * 100/@scale).round(2)
    end
  end

  def describe(grades)
    if (grades.length > 0)
      droptext = ""
      if (@drop > 0)
        droptext = ", dropping the lowest #{@drop}"
      end
      if (@scale != 100)
        "average of #{average(grades).round(1)} on a #{@scale}-point scale#{droptext}"
      else
        "average#{droptext}"
      end
    end
  end
end
