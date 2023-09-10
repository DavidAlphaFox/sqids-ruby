# frozen_string_literal: true

require 'rspec'
require_relative '../lib/sqids'

describe Sqids do
  it 'encodes and decodes using simple alphabet' do
    sqids = Sqids.new(alphabet: '0123456789abcdef')

    numbers = [1, 2, 3]
    id = '489158'

    expect(sqids.encode(numbers)).to eq(id)
    expect(sqids.decode(id)).to eq(numbers)
  end

  it 'decodes after encoding with a short alphabet' do
    sqids = Sqids.new(alphabet: 'abc')

    numbers = [1, 2, 3]
    encoded = sqids.encode(numbers)

    expect(sqids.decode(encoded)).to eq(numbers)
  end

  it 'decodes after encoding with a long alphabet' do
    sqids = Sqids.new(alphabet:
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+|{}[];:\'"/?.>,<`~')

    numbers = [1, 2, 3]
    encoded = sqids.encode(numbers)

    expect(sqids.decode(encoded)).to eq(numbers)
  end

  it 'fails when alphabet has multibyte characters' do
    expect do
      Sqids.new(alphabet: 'ë1092')
    end.to raise_error(ArgumentError)
  end

  it 'fails when alphabet characters are repeated' do
    expect do
      Sqids.new(alphabet: 'aabcdefg')
    end.to raise_error(ArgumentError)
  end

  it 'fails when alphabet is too short' do
    expect do
      Sqids.new(alphabet: 'ab')
    end.to raise_error(ArgumentError)
  end
end
