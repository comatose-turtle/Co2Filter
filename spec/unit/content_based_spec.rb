require 'spec_helper'

describe Co2Filter::ContentBased do
  let(:user_profile) {
    {
      1 => 5,
      2 => 2,
      3 => 10,
      4 => 4,
      5 => 7,
      6 => 5,
      7 => 1,
      8 => 0.5,
      9 => 3,
      10 => 2
    }
  }
  let(:user_ratings) {
    {
      100 => 5.0,
      102 => 3.0,
      105 => 2.5
    }
  }
  let(:items) {
    {
      100 => {
        2 => 1.0,
        4 => 0.2,
        5 => 0.9,
        6 => 0.5,
        9 => 1.0
      },
      101 => {
        1 => 0.75,
        2 => 0.3,
        4 => 0.1,
        5 => 0.2,
        7 => 0.9
      },
      102 => {
        1 => 0.6,
        2 => 1.0,
        3 => 0.9,
        4 => 0.1,
        5 => 0.05,
        6 => 1.0,
        11 => 1.0,
        12 => 0.4
      },
      103 => {
        5 => 0.4,
        7 => 0.1,
        8 => 0.8,
        9 => 1.0,
        10 => 0.7,
        11 => 0.7
      },
      104 => {
        1 => 0.65,
        3 => 0.2,
        5 => 0.5,
        7 => 0.2,
        9 => 0.4,
        11 => 1.0
      },
      105 => {
        1 => 1.0,
        2 => 1.0,
        3 => 1.0,
        4 => 1.0,
        5 => 1.0,
        6 => 1.0,
        7 => 1.0,
        8 => 1.0,
        9 => 1.0,
        10 => 1.0,
        11 => 1.0,
        12 => 1.0,
        13 => 1.0,
        14 => 1.0
      },
      106 => {
        11 => 1.0,
        12 => 1.0,
        13 => 1.0,
        14 => 1.0
      }
    }
  }
  context '#filter' do
    context 'translates a set of data into recommendation results' do
      it 'can accept a UserProfile object' do
        result = Co2Filter::ContentBased.filter(user: Co2Filter::ContentBased::UserProfile.new(user_profile), items: items)
        expect(result).to be_a(Co2Filter::ContentBased::Results)
        expect(result.ids_by_rating).to eq([105, 102, 100, 104, 103, 101, 106])
      end

      it 'can accept a hash of item ratings' do
        result = Co2Filter::ContentBased.filter(user: user_ratings, items: items)
        expect(result).to be_a(Co2Filter::ContentBased::Results)
        expect(result.ids_by_rating).to eq([103, 104, 106, 101])
      end
    end
  end

  context '#ratings_to_profile' do
    it 'turns a list of item ratings into a list of attribute ratings (user profile)' do
      result = Co2Filter::ContentBased.ratings_to_profile(user_ratings: user_ratings, items: items)
      expect(result).to be_a(Co2Filter::ContentBased::UserProfile)
      expect(result.to_hash).to include({
          1 => 4.3,
          2 => 10.5,
          3 => 5.2,
          4 => 3.8,
          5 => 7.15,
          6 => 8.0,
          7 => 2.5,
          8 => 2.5,
          9 => 7.5,
          10 => 2.5,
          11 => 5.5,
          12 => 3.7,
          13 => 2.5,
          14 => 2.5
        })
    end
  end
end
