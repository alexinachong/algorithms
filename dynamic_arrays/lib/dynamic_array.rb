require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" unless check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    val = @store[@length - 1]
    @store[@length - 1] = nil
    @length -= 1
    val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length + 1 > @capacity
      resize!
    end
    @store[@length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    i = 0
    val = @store[0]
    while i < @length
      @store[i] = @store[i + 1]
      i += 1
    end
    @store[@length - 1] = nil
    @length -= 1
    val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    if @length + 1 > @capacity
      resize!
    end
    i = @length - 1
    while i >= 0
      @store[i + 1] = @store[i]
      i -=1
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    index >= 0 && index < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_store[i] = @store[i]
      i += 1
    end
    @store = new_store
  end
end
