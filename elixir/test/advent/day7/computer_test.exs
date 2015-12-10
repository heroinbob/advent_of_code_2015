defmodule Advent.Day7.ComputerTest do
  use ExUnit.Case, async: true
  use Bitwise
  alias Advent.Day7.Computer

  test "exec/1 should execute the specified commands" do
    commands = [
      #{:ASSIGN, 123, :x},
      #{:ASSIGN, 456, :y},
      #{:AND, {:x, :y}, :d},
      #{:OR, {:x, :y}, :e},
      #{:LSHIFT, {:x, 2}, :f},
      #{:RSHIFT {:y, 2}, :g},
      #{:NOT, :x, :h},
      #{:NOT, :y, :i}
    ]
    expected = [
      d: 72,
      e: 507,
      f: 492,
      g: 114,
      h: 65412,
      i: 65079,
      x: 123,
      y: 456
    ]

    #assert Computer.exec(commands) == expected
  end

  test "compute/2 supports assignment to a number" do
    assert Computer.compute({:ASSIGN, 19138, :b}, HashDict.new) == 19138
  end

  test "compute/2 supports assignment to a value in a register" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 7)
    assert Computer.compute({:ASSIGN, :x, :y}, hash) == 7
  end

  test "compute/2 supports binary not of a value" do
    assert Computer.compute({:NOT, 1, :a}, HashDict.new) == -2
  end

  test "compute/2 supports NOT of a value in a register" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 7)
    assert Computer.compute({:NOT, :x, :y}, hash) == -8
  end

  test "compute/2 supports AND of raw value on left, register value on right" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 7)
    assert Computer.compute({:AND, {1, :x}, :a}, hash) == 1
  end

  test "compute/2 supports AND of raw value on right, register value on left" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 9)
    assert Computer.compute({:AND, {:x, 6}, :a}, hash) == 0
  end

  test "compute/2 supports AND of 2 register values" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 9)
    hash = HashDict.put(hash, :y, 87)
    assert Computer.compute({:AND, {:x, :y}, :a}, hash) == 1
  end

  test "compute/2 supports or two register values" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 1)
    hash = HashDict.put(hash, :y, 17)
    assert Computer.compute({:OR, {:x, :y}, :a}, hash) == 17
  end

  test "compute/2 supports OR a raw value on left, register val on right" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 5)
    assert Computer.compute({:OR, {2, :x}, :a}, hash) == 7
  end

  test "compute/2 supports RSHIFT a register value" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 5)
    assert Computer.compute({:RSHIFT, {:x, 1}, :a}, hash) == 2
  end

  test "compute/2 supports LSHIFT a register value" do
    hash = HashDict.new
    hash = HashDict.put(hash, :x, 1)
    assert Computer.compute({:LSHIFT, {:x, 10}, :a}, hash) == 1024
  end
end
