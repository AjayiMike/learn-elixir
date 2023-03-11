defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def hello do
    :world
  end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_out_cells_with_odd_value
    |> build_pixel_map
    |> draw_image
    |> save_image(input <> ".png")
  end

  defp hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  defp pick_color(%Identicon.Image{hex: hex_list} = image_struct) do
    # one way to take the first three value
    # [r, g, b | _tail] = hex_list
    # [r, g, b]

    # elegant way
    [r, g, b] = Enum.take(hex_list, 3)

    %Identicon.Image{image_struct | color: {r, g, b}}
  end

  defp build_grid(%Identicon.Image{hex: hex_list} = image_struct) do
    grid =
      Enum.chunk_every(hex_list, 3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image_struct | grid: grid}
  end

  # defp mirror_rows(rows_list) do
  #   for list <- rows_list do
  #     list |> mirror_row
  #   end
  # end

  defp mirror_row(list) do
    [first, second | _tail] = list
    list ++ [second, first]
  end

  defp filter_out_cells_with_odd_value(%Identicon.Image{grid: grid} = image_struct) do
    grid = Enum.filter(grid, fn {value, _index} -> rem(value, 2) == 0 end)
    %Identicon.Image{image_struct | grid: grid}
  end

  defp build_pixel_map(%Identicon.Image{grid: grid} = image_struct) do
    pixel_map =
      Enum.map(grid, fn {_value, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50
        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image_struct | pixel_map: pixel_map}
  end

  defp draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  defp save_image(image_binary, filename) do
    :egd.save(image_binary, filename)
  end
end
