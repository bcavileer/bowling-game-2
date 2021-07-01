class Game
  def initialize
    @frames = build_frames
  end

  attr_reader :frames

  def score
    frames.map { |frame| frame.score }.compact.sum
  end

  def bowl(pins)
    frame = frames.find { |f| f.incomplete? }
    raise 'Game Over' unless frame
    frame.bowl(pins)
  end

  # Builds frames backwards to reference next frame
  def build_frames
    prev_frame = nil
    10.times.map do |frame_number|
      prev_frame = Frame.new(10 - frame_number, prev_frame)
    end.reverse!
  end

  class Frame
    attr_reader :frame_number, :next_frame
    attr_accessor :roll_1, :roll_2, :roll_3

    def initialize(frame_number, next_frame)
      @frame_number = frame_number
      @next_frame   = next_frame
    end

    def complete?
      return !!roll_3 if final_frame? && (strike? || spare?)
      strike? || roll_2
    end

    def incomplete?
      !complete?
    end

    def bowl(pins)
      return self.roll_3 = pins if roll_2
      return self.roll_2 = pins if roll_1
      self.roll_1 = pins
    end

    def score
      return nil unless complete?

      if strike?
        if final_frame?
          return 10 + roll_2 + roll_3
        end
        return next_frame&.score ? 10 + next_frame.score : nil
      end

      if spare?
        return next_roll ? 10 + next_roll : nil
      end

      roll_1 + roll_2
    end

    def strike?
      roll_1 == 10
    end

    def spare?
      return false unless roll_2
      roll_1 + roll_2 == 10
    end

    def next_roll
      if final_frame?
        roll_3
      else
        next_frame.roll_1
      end
    end

    def final_frame?
      frame_number == 10
    end
  end
end
