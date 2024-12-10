module Day9
  VERSION = "0.1.0"

  class Seq
    property size, item

    def initialize(@size : Int32, @item : Int32 | Nil)
    end
  end

  def self.part1(input : String)
    is_file = true
    id = 0
    result = [] of Int32 | Nil
    input
      .chars
      .each do |c|
        begin
          i = c.to_i8
        rescue
          next
        end
        if is_file
          (1..c.to_i8).each { |_| result << id }
        else
          (1..c.to_i8).each { |_| result << nil }
        end

        if is_file
          id += 1
        end
        is_file = !is_file
      end
    sort_part1! result
    checksum result
  end

  def self.part2(input : String)
    is_file = true
    id = 0
    result = [] of Seq
    input
      .chars
      .each do |c|
        begin
          i = c.to_i32
        rescue
          next
        end
        if is_file
          result << Seq.new i, id
        else
          result << Seq.new i, nil
        end

        if is_file
          id += 1
        end
        is_file = !is_file
      end
    sort_part2! result
    list = to_a(result)
    checksum list
  end

  def self.sort_part1!(list : Array(Int32 | Nil))
    idx = 0
    last = list.size - 1
    while idx < last
      if !list[idx]
        while !list[last]
          last -= 1
        end
        list[idx], list[last] = list[last], list[idx]
        last -= 1
      end
      idx += 1
    end
  end

  def self.sort_part2!(list : Array(Seq))
    total = 0
    current_idx = list.size - 1
    while current_idx >= 0
      if list[current_idx].item == nil
        current_idx -= 1
        next
      end

      current = list[current_idx]
      found_idx = (0..(current_idx - 1)).find { |i|
        list[i].item == nil && list[i].size >= current.size
      }
      if found_idx
        # cleanup first
        assert list[current_idx].item != nil
        assert list[current_idx - 1].item == nil
        current = list.delete_at(current_idx)
        list[current_idx - 1].size += current.size
        if current_idx + 1 < list.size
          assert list[current_idx].item == nil
          after = list.delete_at(current_idx)
          list[current_idx - 1].size += after.size
        end

        # then insert
        assert list[found_idx].item == nil
        assert current.size > 0
        list[found_idx].size -= current.size
        list.insert(found_idx, current)
        list.insert(found_idx, Seq.new(0, nil))

        current_idx += 1
      end
      current_idx -= 1
    end
  end

  def self.checksum(list : Array(Int32 | Nil)) : Int64
    (list.each.zip(0..))
      .map { |tup|
        val, idx = tup[0], tup[1]
        if val
          (val * idx).to_i64
        else
          0.to_i64
        end
      }
      .sum
  end

  def self.assert(cond : Bool)
    if !cond
      raise "Assertion fail"
    end
  end

  def self.to_a(list : Array(Seq)) : Array(Int32 | Nil)
    ret = [] of Int32 | Nil
    list.each do |item|
      (1..item.size).each do |_|
        ret << item.item
      end
    end
    ret
  end
end
