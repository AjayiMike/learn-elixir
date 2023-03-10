defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck = Cards.create_deck()
    assert Enum.count(deck) == 20

    # this also works
    # deck_length = length(Cards.create_deck())
    # assert deck_length == 20
  end

  test "Card.shuffle actually shuffles the deck of card" do
    deck = Cards.create_deck()
    shuffled_deck = Cards.shuffle(deck)
    assert length(deck) == length(shuffled_deck)
    refute deck == shuffled_deck
  end
end
