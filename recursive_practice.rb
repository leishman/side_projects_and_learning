require 'rspec'

def flatten(array, result = [])
  array.each do |element|
    if element.kind_of?(Array)
      flatten(element, result)
    else
      result << element
    end
  end
  result
end

flatten([1,[8,9]])




