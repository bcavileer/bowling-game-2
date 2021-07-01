require 'game'

describe Game do
  it 'starts with score 0' do
    expect(subject.score).to eq(0)
  end

  describe 'on the first roll' do
    describe 'player bowls a gutter ball' do
      it 'has a score of 0 until frame is completed' do
        subject.bowl(0)
        expect(subject.score).to eq(0)
      end
    end

    describe 'player knocks over a pin' do
      it 'has a score of 1' do
        subject.bowl(1)
        expect(subject.score).to eq(0)
      end
    end
  end

  describe 'on the second roll' do
    describe 'player bowls two gutter balls' do
      it 'has a score of 0' do
        subject.bowl(0)
        subject.bowl(0)
        expect(subject.score).to eq(0)
      end
    end

    describe 'player knocks over a pin then another pin' do
      it 'has a score of 2' do
        subject.bowl(1)
        subject.bowl(1)
        expect(subject.score).to eq(2)
      end
    end

    describe 'player knocks over 9 pins then 1 pin' do
      it 'counts as a spare' do
        subject.bowl(9)
        subject.bowl(1)
        expect(subject.score).to eq(0)
      end
    end
  end

  describe 'on the third roll' do
    describe 'player bowls a strike and then two gutter balls' do
      it 'has a score of 0' do
        subject.bowl(10)
        subject.bowl(0)
        subject.bowl(0)
        expect(subject.score).to eq(10)
      end
    end

    describe 'player bowls a strike and then a gutter ball then 1 pin' do
      it 'has a score of 0' do
        subject.bowl(10)
        subject.bowl(0)
        subject.bowl(1)
        expect(subject.score).to eq(12)
      end
    end

    describe 'player bowls a strike and then 1 pin then a gutter ball ' do
      it 'has a score of 0' do
        subject.bowl(10)
        subject.bowl(1)
        subject.bowl(0)
        expect(subject.score).to eq(12)
      end
    end
  end

  describe 'on the fourth roll' do
    describe 'player bowls a spare and then two gutter balls' do
      it 'has a score of 0' do
        subject.bowl(5)
        subject.bowl(5)
        subject.bowl(0)
        subject.bowl(0)
        expect(subject.score).to eq(10)
      end
    end

    describe 'player bowls a spare and then a gutter ball then 1 pin' do
      it 'has a score of 0' do
        subject.bowl(5)
        subject.bowl(5)
        subject.bowl(0)
        subject.bowl(1)
        expect(subject.score).to eq(11)
      end
    end

    describe 'player bowls a spare and then 1 pin then a gutter ball ' do
      it 'has a score of 0' do
        subject.bowl(5)
        subject.bowl(5)
        subject.bowl(1)
        subject.bowl(0)
        expect(subject.score).to eq(12)
      end
    end
  end

  describe 'a gutter game' do
    it 'scores 0' do
      20.times { subject.bowl(0) }
      expect(subject.score).to eq(0)
    end
  end

  describe 'all ones game' do
    it 'scores 20' do
      20.times { subject.bowl(1) }
      expect(subject.score).to eq(20)
    end
  end

  describe 'final spare' do
    it 'scores spare plus bonus pins' do
      18.times { subject.bowl(0) }
      subject.bowl(5)
      subject.bowl(5)
      subject.bowl(1)
      expect(subject.score).to eq(11)
    end
  end

  describe 'final strikes' do
    it 'scores 30' do
      18.times { subject.bowl(0) }
      subject.bowl(10)
      subject.bowl(10)
      subject.bowl(10)
      expect(subject.score).to eq(30)
    end
  end

  describe 'perfect game' do
    it 'scores 300' do
      12.times { subject.bowl(10) }
      expect(subject.score).to eq(300)
    end
  end
end
