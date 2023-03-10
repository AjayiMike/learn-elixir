defmodule Cards do
  @moduledoc """
  Provides a set of methods for creating and handling a deck of cards.
  """

  @doc """
  Create a deck of cards.

  ## Examples


        iex> Cards.create_deck()
        ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds",
        "Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
        "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
        "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
        "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]

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
  shuffle a deck of cards

  ## Examples


        iex> :rand.seed(:exsplus, {1, 2, 3})
        iex> deck = Cards.create_deck
        iex> Cards.shuffle(deck)
        ["Five of Clubs", "Five of Spades", "Three of Spades", "Three of Hearts",
        "Three of Clubs", "Two of Spades", "Five of Hearts", "Five of Diamonds",
        "Four of Spades", "Two of Hearts", "Two of Clubs", "Four of Diamonds",
        "Four of Clubs", "Ace of Clubs", "Ace of Spades", "Four of Hearts",
        "Two of Diamonds", "Three of Diamonds", "Ace of Diamonds", "Ace of Hearts"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  checks if a card is contained in a deck/list of cards

  ## Examples


        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Clubs")
        true
        iex> Cards.contains?(deck, "King of Diamonds")
        false

  """

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  deal a hand of cards for a player

  ## Examples


        iex> deck = Cards.create_deck
        iex> Cards.deal(deck, 4)
        {["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds"],
        ["Two of Spades", "Two of Clubs", "Two of Hearts", "Two of Diamonds",
         "Three of Spades", "Three of Clubs", "Three of Hearts", "Three of Diamonds",
         "Four of Spades", "Four of Clubs", "Four of Hearts", "Four of Diamonds",
         "Five of Spades", "Five of Clubs", "Five of Hearts", "Five of Diamonds"]}

  """

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  save a deck of cards in a file on the local machine

  #Examples


        iex> Cards.save(["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds", "Two of Spades"], "file")
        :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  retrieve a saved deck of cards that is saved on the local machine

  #Examples


        iex> Cards.load("file")
        ["Ace of Spades", "Ace of Clubs", "Ace of Hearts", "Ace of Diamonds", "Two of Spades"]

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
  Create a deck, shuffle the deck and deal a hand

  ## Examples

        iex> :rand.seed(:exsplus, {1, 2, 3})
        iex> Cards.create_hand(5)
        ["Five of Clubs", "Five of Spades", "Three of Spades", "Three of Hearts",
        "Three of Clubs"]

  """

  def create_hand(hand_size) do
    {hand, _rest} = Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size)
    hand
  end
end
