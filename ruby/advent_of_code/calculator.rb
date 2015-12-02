module AdventOfCode
  class Calculator
    def initialize(dimensions)
      dimensions.sort!

      @length = dimensions[0]
      @width = dimensions[1]
      @height = dimensions[2]
    end

    # Calculate the amount of paper needed for a package with the specified
    # dimensions.
    #
    # Returns ft^2 of the surface area of the package, plus extra that is
    # equal to the area of the smallest side.
    def total_paper
      surface_area + smallest_area
    end

    # Returns exact surface area of the package.
    def surface_area
      2 * (side_1_area + side_2_area + side_3_area)
    end

    # Returns area of the smallest side.
    def smallest_area
      [side_1_area, side_2_area, side_3_area].min
    end

    # Calculator the total ribbon needed to wrap the package and tie a bow.
    def total_ribbon
      ribbon_length + bow_length
    end

    # Calculate the amount of ribbon required to wrap the perimeter of the
    # smallest face on the package.
    def ribbon_length
      2 * (length + width)
    end

    # Calculate the length required for the bow, which is equal to the volume
    # of the package.
    def bow_length
      sizes.inject :*
    end

    private

    attr_reader :length, :width, :height

    def side_1_area
      length * width
    end

    def side_2_area
      width * height
    end

    def side_3_area
      height * length
    end

    def sizes
      [length, width, height]
    end
  end
end
