defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Create deck.

  ## Examples

  iex> Cards.create_deck()
  ["Ace Spades", "Ace Clubs", "Ace Hearts", "Ace Diamonds", "Two Spades",
  "Two Clubs", "Two Hearts", "Two Diamonds", "Three Spades", "Three Clubs",
  "Three Hearts", "Three Diamonds", "Four Spades", "Four Clubs", "Four Hearts",
  "Four Diamonds", "Five Spades", "Five Clubs", "Five Hearts", "Five Diamonds"]

  """

  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # for loop is called list comprehension in elixir

    for value <- values, suit <- suits do
      value <> " " <> "of" <> " " <> suit
    end

    # another way to achive this is commented below
    # x =
    #   for value <- values do
    #     for suit <- suits do
    #       value <> " " <> "of" <> " " <> suit
    #     end
    #   end

    # List.flatten(x)
  end

  @doc """
  shuffle a list

  ## Examples

  iex> Cards.shuffle(["Ace", "Two", "Three"])
  [ "Two", "Three", "Ace"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  checks if a card is contained in a deck/list of card

  ## Examples

  iex Cards.contains(["Ace", "Two", "Three"], "Three")
  true

  iex> Cards.contains(["Ace", "Two", "Three"], "Fivr")
  false

  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  deal a hand of cards for players

  ## Examples

  iex> Cards.deal(["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
  "Two of Spades"], 2)
  ["Ace of Spades", "Ace of Clubs"], ["Ace of Hearts", "Ace of Diamonds",
  "Two of Spades"]

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  save a deck of card in a file on the local machine

  #Examples

  iex> Cards.save(["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
  "Two of Spades"], "file")
  :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  retrieve a saved deck of card saved on the local machine

  #Examples

  iex> Cards.load("file")
  ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
  "Two of Spades"]

  """
  def load(filename) do
    # THIS WORKS
    # if status == :okay do
    #   :erlang.binary_to_term(binary)
    # else
    #   {:error, "no file with such name"}
    # end

    # THIS ALSO WORKS
    # case status do
    #   :ok ->
    #     :erlang.binary_to_term(binary)

    #   :error ->
    #     {:error, "no file with such name"}

    #   _ ->
    #     {:error, "something went wrong!"}
    # end

    case File.read(filename) do
      {:ok, content} ->
        :erlang.binary_to_term(content)

      {:error, _error_reason} ->
        {:error, "no file with such name"}

      _ ->
        {:error, "something went wrong!"}
    end
  end

  @doc """
  Create a deck, shuffle the deck and deal

  ## Examples

  create_hand(hand_size)
  iex> ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
  "Two of Spades"]

  """

  def create_hand(hand_size) do
    {hand, _rest} = Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size)
    hand
  end
end
