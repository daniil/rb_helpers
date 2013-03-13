class OrderVersions
  def initialize(a, b)
    a_arr = a.split '.'
    b_arr = b.split '.'

    # Order by length of array as we want to iterate the larger one
    @v_arr = [a_arr, b_arr].sort {|a, b| b.length <=> a.length}

    # If elements in an array are equal we have two equal versions
    if a_arr == b_arr
      puts display_ordered @v_arr
      return
    end

    # Iterate through larger array
    @v_arr.first.each_index do |i|
      a = @v_arr.first[i]
      b = @v_arr.last[i]

      if i?(a) && i?(b) # are current values both integers?
        result = compare_and_display(a, b) # compare current version digit, if not equal display and return
        if result
          puts result
          return
        end
      else
        if b # is shorter array still has a value?
          if i? a # a is major, display and return
            puts display_ordered [@v_arr.first, @v_arr.last]
            return
          elsif i? b # b is major, display and return
            puts display_ordered [@v_arr.last, @v_arr.first]
            return
          else
            result = compare_and_display(a, b) # compare minor versions, display and return
            if result
              puts result
              return
            end
          end
        else
          puts display_ordered [@v_arr.last, @v_arr.first] # b is a final version, display and return
          return
        end
      end
    end
  end

  # Check if value is an integer
  def i?(v)
    !!(v =~ /^[-+]?[0-9]+$/)
  end

  # Compare two values
  def compare_and_display(a, b)
    if (a <=> b) == -1
      display_ordered [@v_arr.last, @v_arr.first]
    elsif (a <=> b) == 1
      display_ordered [@v_arr.first, @v_arr.last]
    end
  end

  # Format for presentation
  def display_ordered(a)
    return a.map {|a| a.join('.')}
  end
end

# Example usage
OrderVersions.new("1.3.0.b", "1.3.a")